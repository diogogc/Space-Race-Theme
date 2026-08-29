#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/stat.h>

static char sock_orig[512];
static char sock_front[512];
static int listen_fd = -1;

static void cleanup(void) {
    if (listen_fd >= 0) {
        close(listen_fd);
        listen_fd = -1;
    }
    unlink(sock_front);
    if (access(sock_orig, F_OK) == 0) {
        rename(sock_orig, sock_front);
    }
}

static void handle_sig(int sig) {
    cleanup();
    _exit(0);
}

static ssize_t write_all(int fd, const void *buf, size_t count) {
    size_t written = 0;
    const char *p = (const char *)buf;
    while (written < count) {
        ssize_t n = write(fd, p + written, count - written);
        if (n < 0) {
            if (errno == EINTR) continue;
            return -1;
        }
        written += (size_t)n;
    }
    return (ssize_t)written;
}

static void transform_command(const char *in, char *out, size_t out_max) {
    const char *commands[] = {
        "dispatch workspace ",
        "dispatch focusworkspaceoncurrentmonitor ",
        "dispatch movetoworkspace ",
        "dispatch togglespecialworkspace ",
        "dispatch focuswindow ",
        "dispatch focus ",
        NULL
    };

    for (int c = 0; commands[c]; c++) {
        const char *cmd = commands[c];
        const char *match = strstr(in, cmd);
        if (match) {
            const char *arg = match + strlen(cmd);
            while (*arg == ' ') arg++;

            // If already quoted or using parentheses, pass through as-is
            if (*arg == '"' || *arg == '\'' || *arg == '(') {
                snprintf(out, out_max, "%s", in);
                return;
            }

            char target[256];
            int i = 0;
            while (arg[i] && arg[i] != '\n' && arg[i] != ';' && arg[i] != '\r' && arg[i] != ' ' && i < 250) {
                // Sanitize: skip quotes or backslashes
                if (arg[i] != '"' && arg[i] != '\\') {
                    target[i] = arg[i];
                    i++;
                } else {
                    i++;
                }
            }
            target[i] = '\0';

            char *clean_target = target;
            if (strncmp(clean_target, "name:", 5) == 0) {
                clean_target += 5;
            }

            char remainder[2048] = "";
            if (arg[i]) {
                snprintf(remainder, sizeof(remainder), "%s", arg + i);
            }

            size_t prefix_len = (size_t)(match - in);
            char fn_name[64];
            const char *fn_start = cmd + strlen("dispatch ");
            size_t fn_len = strlen(fn_start) - 1; // remove trailing space
            if (fn_len >= sizeof(fn_name)) fn_len = sizeof(fn_name) - 1;
            memcpy(fn_name, fn_start, fn_len);
            fn_name[fn_len] = '\0';

            snprintf(out, out_max, "%.*sdispatch %s \"%s\"%s",
                     (int)prefix_len, in, fn_name, clean_target, remainder);
            return;
        }
    }

    snprintf(out, out_max, "%s", in);
}

static void rewrite_and_forward(int client_fd, int backend_fd) {
    char buf[4096];
    ssize_t n = read(client_fd, buf, sizeof(buf) - 1);
    if (n <= 0) return;
    buf[n] = '\0';

    char rewritten[4096];
    transform_command(buf, rewritten, sizeof(rewritten));

    size_t out_len = strlen(rewritten);
    write_all(backend_fd, rewritten, out_len);

    ssize_t resp_len;
    while ((resp_len = read(backend_fd, buf, sizeof(buf))) > 0) {
        write_all(client_fd, buf, (size_t)resp_len);
    }
}

int main(int argc, char **argv) {
    const char *sig = getenv("HYPRLAND_INSTANCE_SIGNATURE");
    const char *xdg = getenv("XDG_RUNTIME_DIR");
    if (!sig) {
        fprintf(stderr, "[hyprland-ipc-bridge] HYPRLAND_INSTANCE_SIGNATURE not set\n");
        return 1;
    }
    if (!xdg) xdg = "/run/user/1000";

    snprintf(sock_front, sizeof(sock_front), "%s/hypr/%s/.socket.sock", xdg, sig);
    snprintf(sock_orig, sizeof(sock_orig), "%s/hypr/%s/.socket.real.sock", xdg, sig);

    struct sockaddr_un addr;
    if (strlen(sock_front) >= sizeof(addr.sun_path)) {
        fprintf(stderr, "[hyprland-ipc-bridge] Socket path too long for sockaddr_un\n");
        return 1;
    }

    if (access(sock_orig, F_OK) != 0) {
        if (rename(sock_front, sock_orig) != 0) {
            perror("[hyprland-ipc-bridge] rename .socket.sock failed");
            return 1;
        }
    } else {
        unlink(sock_front);
    }

    atexit(cleanup);
    signal(SIGINT, handle_sig);
    signal(SIGTERM, handle_sig);
    signal(SIGHUP, handle_sig);

    listen_fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (listen_fd < 0) {
        perror("[hyprland-ipc-bridge] socket creation failed");
        return 1;
    }

    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, sock_front, sizeof(addr.sun_path) - 1);

    if (bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        perror("[hyprland-ipc-bridge] bind failed");
        return 1;
    }
    chmod(sock_front, 0700);

    if (listen(listen_fd, 128) < 0) {
        perror("[hyprland-ipc-bridge] listen failed");
        return 1;
    }

    // Daemonize safely
    if (argc <= 1 || strcmp(argv[1], "--no-daemon") != 0) {
        if (daemon(0, 0) < 0) {
            perror("[hyprland-ipc-bridge] daemon() failed");
        }
    }

    while (1) {
        int client_fd = accept(listen_fd, NULL, NULL);
        if (client_fd < 0) {
            if (errno == EINTR) continue;
            break;
        }

        int backend_fd = socket(AF_UNIX, SOCK_STREAM, 0);
        if (backend_fd >= 0) {
            struct sockaddr_un b_addr;
            memset(&b_addr, 0, sizeof(b_addr));
            b_addr.sun_family = AF_UNIX;
            strncpy(b_addr.sun_path, sock_orig, sizeof(b_addr.sun_path) - 1);
            if (connect(backend_fd, (struct sockaddr *)&b_addr, sizeof(b_addr)) == 0) {
                rewrite_and_forward(client_fd, backend_fd);
            }
            close(backend_fd);
        }
        close(client_fd);
    }

    return 0;
}
