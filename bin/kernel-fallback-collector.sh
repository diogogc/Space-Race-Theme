#!/usr/bin/env bash
# ==============================================================================
# 🚀 Apollo Telemetry Subsystem: Kernel Fallback & Crash Collector (Hardened)
# ==============================================================================
# Purpose: Detects when the system has booted into the LTS fallback kernel or
#          experienced a boot failure, caches failure telemetry into a secure
#          log file (0600 permissions, sanitized), and raises an active warning
#          flag in sys-mem for AGY / Space AI Recovery.
# ==============================================================================

set -euo pipefail

# Secure umask: Ensure dump files are created with private permissions (0600)
umask 077

LOG_DUMP="${HOME}/.cache/kernel-boot-failure-last.log"
VAULT_ALERT="${HOME}/sys-mem/sys_mem/troubleshooting/active-kernel-failure-alert.md"
CURRENT_KERNEL="$(uname -r)"

# Only trigger if running under an LTS kernel or if manually forced
if [[ "$CURRENT_KERNEL" != *"lts"* ]] && [[ "${1:-}" != "--force" ]]; then
    exit 0
fi

mkdir -p "$(dirname "$LOG_DUMP")"
mkdir -p "$(dirname "$VAULT_ALERT")"
TIMESTAMP="$(date -Iseconds)"

# Security Sanitizer: Redact potential sensitive tokens, passwords, and authorization keys
sanitize_stream() {
    sed -E \
        -e 's/(password|passwd|secret|token|api[_-]?key|auth|bearer)[=:][ ]*[^ ,;"]+/\1=[REDACTED]/gI' \
        -e 's/([0-9a-fA-F]{32,64})/[HASH_REDACTED]/g'
}

echo "=== [APOLLO TELEMETRY] Kernel Fallback Detected at ${TIMESTAMP} ===" > "$LOG_DUMP"
chmod 600 "$LOG_DUMP"
echo "Running Kernel: ${CURRENT_KERNEL}" >> "$LOG_DUMP"
echo "Previous Boot Journal Telemetry (Sanitized):" >> "$LOG_DUMP"
echo "--------------------------------------------------" >> "$LOG_DUMP"

# Collect previous boot kernel messages & errors (sanitized)
journalctl -b -1 -k --no-pager -n 250 2>&1 | sanitize_stream >> "$LOG_DUMP" || true
echo -e "\n--- Systemd Error Priority Logs (-b -1 -p 3) ---" >> "$LOG_DUMP"
journalctl -b -1 -p 3 -xb --no-pager -n 100 2>&1 | sanitize_stream >> "$LOG_DUMP" || true

# Collect DKMS module status
echo -e "\n--- DKMS Module Status ---" >> "$LOG_DUMP"
dkms status 2>&1 >> "$LOG_DUMP" || echo "DKMS not active or no modules registered" >> "$LOG_DUMP"

# Collect recent Pacman transactions
echo -e "\n--- Recent Pacman Transactions (last 60 lines) ---" >> "$LOG_DUMP"
tail -n 60 /var/log/pacman.log 2>&1 | sanitize_stream >> "$LOG_DUMP" || true

# Create / Update active warning flag in sys-mem vault
cat <<EOF > "$VAULT_ALERT"
---
title: "⚠️ ACTIVE WARNING: Kernel Boot Failure & Fallback to LTS"
date: $(date +%Y-%m-%d)
last_modified: $(date +%Y-%m-%d)
status: active-warning
tags:
  - troubleshooting
  - kernel-failure
  - unanalyzed
dump_file: ${LOG_DUMP}
---

# ⚠️ Kernel Boot Failure & LTS Fallback Alert

> [!WARNING]
> The system booted under fallback kernel **\`${CURRENT_KERNEL}\`** at **${TIMESTAMP}**.
> Diagnostic failure logs have been saved securely to [\`${LOG_DUMP}\`](file://${LOG_DUMP}) (mode 0600).

## 📊 Summary of Event
- **Active Kernel**: \`${CURRENT_KERNEL}\`
- **Telemetry Dump**: \`${LOG_DUMP}\`
- **Recorded**: \`${TIMESTAMP}\`

## 🛠️ Next Steps for AI Recovery
1. Launch \`space-ai-recovery\` (or \`agy-kernel-repair\`) to start a diagnostic session.
2. The AI agent will read the pre-compiled dump from \`${LOG_DUMP}\` and diagnose the crash.
3. Once the root cause is fixed (e.g. initramfs rebuilt, kernel package rolled back), run:
   \`\`\`bash
   space-ai-recovery --clean
   \`\`\`
EOF

# Send desktop notification if Wayland/DBus session is active
if command -v notify-send >/dev/null 2>&1; then
    notify-send -u critical -a "Apollo Flight Controller" \
        "⚠️ Kernel Fallback Active" \
        "Booted into ${CURRENT_KERNEL}. Telemetry cached in sys-mem. Run 'space-ai-recovery' to diagnose." || true
fi

echo "[APOLLO TELEMETRY] Telemetry securely cached to ${LOG_DUMP} (mode 0600) and sys-mem alert created."
