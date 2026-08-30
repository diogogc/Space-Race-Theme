# 🚨 06. Troubleshooting & Recovery Runbook

Authoritative troubleshooting procedures and emergency recovery runbooks for the Space Race desktop environment.

---

## 🛡️ 1. Emergency Btrfs Snapshot Recovery

If a system update or driver installation causes system instability:

### Creating an Instant Recovery Snapshot
```bash
# Via space-tools-dialog
space-tools-dialog system -> Select [1] INSTANT BTRFS RECOVERY SNAPSHOT

# Via CLI
sudo btrfs subvolume snapshot -r / /@snapshots/root-manual-$(date +%Y%m%d-%H%M%S)
```

### Restoring from a Snapshot (Arch Live USB / Chroot)
```bash
# 1. Boot from Arch Live USB and mount Btrfs root
mount -o subvol=@,compress=zstd /dev/nvme0n1p2 /mnt
mount -o subvol=@snapshots,compress=zstd /dev/nvme0n1p2 /mnt/@snapshots

# 2. Rename broken subvolume and restore snapshot
mv /mnt/@ /mnt/@_broken
btrfs subvolume snapshot /mnt/@snapshots/root-manual-<timestamp> /mnt/@

# 3. Reboot into restored system
reboot
```

---

## 🔧 2. Autonomous Kernel Crash Watcher

The environment includes `kernel-fallback-collector.service`:
- **Watcher Function**: Automatically checks for kernel panics, OOM panics, or broken module trees on boot.
- **Log Dump**: Cached at `~/.cache/kernel-boot-failure-last.log`.
- **Vault Alert**: Creates active alert in `~/sys-mem/sys_mem/troubleshooting/active-kernel-failure-alert.md`.
- **Clearing Alerts**:
  ```bash
  space-ai-recovery --clean
  ```

---

## 🔄 3. Rebuilding Initial Ramdisks (`mkinitcpio`)

If kernel updates result in missing modules or Plymouth/initramfs boot errors:
```bash
# Rebuild all installed kernel images
sudo mkinitcpio -P
```

---

## 🖥️ 4. Hyprland & Wayland IPC Diagnostics

### Checking Hyprland Sockets
```bash
ls -la /tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/
```

### Live Reloading Configurations
```bash
hyprctl reload
killall -SIGUSR2 waybar
killall -SIGUSR2 hyprpaper
```

### Testing Theme Binary Execution
```bash
# Verify Python syntax and execution of all avionics tools
python3 -m py_compile ~/.local/bin/space-tools-dialog
python3 -m py_compile ~/.local/bin/space-theme-config
python3 -m py_compile ~/.local/bin/space-network-dialog
python3 -m py_compile ~/.local/bin/space-energy-dialog
python3 -m py_compile ~/.local/bin/space-capcom-dialog
```
