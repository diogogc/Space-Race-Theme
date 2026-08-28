#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <wayland-client.h>
#include "/home/diogo/.gemini/antigravity-cli/brain/fbab4e4d-e2aa-46d9-8abb-3c2d3bef54ef/scratch/idle_test/ext-idle-notify-v1-client-protocol.h"

static struct wl_display *display = NULL;
static struct wl_registry *registry = NULL;
static struct wl_seat *seat = NULL;
static struct ext_idle_notifier_v1 *idle_notifier = NULL;
static struct ext_idle_notification_v1 *idle_notification = NULL;

static int timeout_minutes = 5;
static int lock_on_wake = 0;
static volatile sig_atomic_t reload_requested = 0;
static volatile sig_atomic_t terminate_requested = 0;
static pid_t running_screensaver_pid = 0;

static void load_config(void) {
    char path[512];
    const char *home = getenv("HOME");
    if (!home) home = "/home/diogo";
    snprintf(path, sizeof(path), "%s/.config/space-screensaver/config.json", home);

    FILE *f = fopen(path, "r");
    if (!f) {
        timeout_minutes = 5;
        lock_on_wake = 0;
        printf("[space-idle-daemon] Config not found, using default timeout=5m\n");
        fflush(stdout);
        return;
    }

    char buf[1024];
    size_t len = fread(buf, 1, sizeof(buf) - 1, f);
    fclose(f);
    buf[len] = '\0';

    char *tm = strstr(buf, "\"timeout_minutes\":");
    if (tm) {
        timeout_minutes = atoi(tm + 18);
    }
    char *lw = strstr(buf, "\"lock_on_wake\":");
    if (lw) {
        lock_on_wake = (strstr(lw, "true") != NULL && strstr(lw, "true") < lw + 25);
    }
    printf("[space-idle-daemon] Config loaded: timeout=%d min, lock_on_wake=%d\n", timeout_minutes, lock_on_wake);
    fflush(stdout);
}

static void sigchld_handler(int sig) {
    int saved_errno = errno;
    pid_t pid;
    int status;
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        if (pid == running_screensaver_pid) {
            running_screensaver_pid = 0;
        }
    }
    errno = saved_errno;
}

static void on_idled(void *data, struct ext_idle_notification_v1 *notification) {
    if (running_screensaver_pid > 0) {
        int status;
        if (waitpid(running_screensaver_pid, &status, WNOHANG) == 0) {
            // Screensaver is still actively running
            return;
        }
        running_screensaver_pid = 0;
    }

    printf("[space-idle-daemon] Inactivity threshold reached (%d min). Launching screensaver...\n", timeout_minutes);
    fflush(stdout);

    pid_t pid = fork();
    if (pid == 0) {
        // In child process:
        // Attempt executing space-screensaver from ~/.local/bin or PATH
        char screensaver_path[512];
        const char *home = getenv("HOME");
        if (!home) home = "/home/diogo";
        snprintf(screensaver_path, sizeof(screensaver_path), "%s/.local/bin/space-screensaver", home);

        execl(screensaver_path, "space-screensaver", NULL);
        execlp("space-screensaver", "space-screensaver", NULL);
        perror("[space-idle-daemon] Failed to execute space-screensaver");
        _exit(127);
    } else if (pid > 0) {
        running_screensaver_pid = pid;
    } else {
        perror("[space-idle-daemon] fork failed");
    }
}

static void on_resumed(void *data, struct ext_idle_notification_v1 *notification) {
    printf("[space-idle-daemon] User activity detected (resumed from idle).\n");
    fflush(stdout);
}

static const struct ext_idle_notification_v1_listener idle_listener = {
    .idled = on_idled,
    .resumed = on_resumed,
};

static void setup_idle_notification(void) {
    if (idle_notification) {
        ext_idle_notification_v1_destroy(idle_notification);
        idle_notification = NULL;
    }
    if (!idle_notifier || !seat) {
        fprintf(stderr, "[space-idle-daemon] Cannot setup idle notification: missing notifier or seat\n");
        fflush(stderr);
        return;
    }
    if (timeout_minutes <= 0) {
        printf("[space-idle-daemon] Screensaver disabled (timeout=0).\n");
        fflush(stdout);
        return;
    }

    uint32_t timeout_ms = (uint32_t)(timeout_minutes * 60 * 1000);
    printf("[space-idle-daemon] Arming idle timeout for %u ms (%d min)\n", timeout_ms, timeout_minutes);
    fflush(stdout);
    idle_notification = ext_idle_notifier_v1_get_idle_notification(idle_notifier, timeout_ms, seat);
    ext_idle_notification_v1_add_listener(idle_notification, &idle_listener, NULL);
}

static void registry_handle_global(void *data, struct wl_registry *reg, uint32_t name, const char *interface, uint32_t version) {
    if (strcmp(interface, ext_idle_notifier_v1_interface.name) == 0) {
        idle_notifier = wl_registry_bind(reg, name, &ext_idle_notifier_v1_interface, 1);
    } else if (strcmp(interface, wl_seat_interface.name) == 0) {
        seat = wl_registry_bind(reg, name, &wl_seat_interface, 1);
    }
}

static void registry_handle_global_remove(void *data, struct wl_registry *reg, uint32_t name) {}

static const struct wl_registry_listener registry_listener = {
    .global = registry_handle_global,
    .global_remove = registry_handle_global_remove,
};

static void handle_signal(int sig) {
    if (sig == SIGHUP || sig == SIGUSR1) {
        reload_requested = 1;
    } else if (sig == SIGINT || sig == SIGTERM) {
        terminate_requested = 1;
    }
}

int main(int argc, char **argv) {
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = sigchld_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART | SA_NOCLDSTOP;
    sigaction(SIGCHLD, &sa, NULL);

    struct sigaction sa_sig;
    memset(&sa_sig, 0, sizeof(sa_sig));
    sa_sig.sa_handler = handle_signal;
    sigemptyset(&sa_sig.sa_mask);
    sigaction(SIGHUP, &sa_sig, NULL);
    sigaction(SIGUSR1, &sa_sig, NULL);
    sigaction(SIGINT, &sa_sig, NULL);
    sigaction(SIGTERM, &sa_sig, NULL);

    load_config();

    display = wl_display_connect(NULL);
    if (!display) {
        fprintf(stderr, "[space-idle-daemon] Failed to connect to Wayland display.\n");
        return 1;
    }

    registry = wl_display_get_registry(display);
    wl_registry_add_listener(registry, &registry_listener, NULL);
    wl_display_roundtrip(display);

    if (!idle_notifier || !seat) {
        fprintf(stderr, "[space-idle-daemon] Compositor does not support ext-idle-notify-v1 or seat unavailable.\n");
        wl_display_disconnect(display);
        return 1;
    }

    setup_idle_notification();
    wl_display_flush(display);

    while (!terminate_requested) {
        if (reload_requested) {
            reload_requested = 0;
            load_config();
            setup_idle_notification();
            wl_display_flush(display);
        }

        if (wl_display_dispatch(display) < 0) {
            if (errno == EINTR) {
                // Interrupted by signal, check reload/terminate flags and continue
                continue;
            }
            fprintf(stderr, "[space-idle-daemon] Wayland display dispatch error: %s\n", strerror(errno));
            break;
        }
    }

    printf("[space-idle-daemon] Shutting down...\n");
    if (idle_notification) ext_idle_notification_v1_destroy(idle_notification);
    if (idle_notifier) ext_idle_notifier_v1_destroy(idle_notifier);
    if (seat) wl_seat_destroy(seat);
    if (registry) wl_registry_destroy(registry);
    if (display) {
        wl_display_flush(display);
        wl_display_disconnect(display);
    }

    return 0;
}
