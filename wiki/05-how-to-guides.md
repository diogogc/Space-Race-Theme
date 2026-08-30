# 📖 05. Operational How-To Guides & Recipes

Step-by-step procedures for managing, styling, and customizing the Space Race desktop environment.

---

## 🌌 1. How to Switch & Customize Themes

### Fast Switching
- **Keyboard**: Press `SUPER + SHIFT + T` to cycle through profiles.
- **Waybar**: Left-click the `[ 🚀 APOLLO-1969 ]` badge on the top-left of the status bar. Right-click cycles backwards.
- **CLI**:
  ```bash
  space-theme-switch next
  space-theme-switch nasa
  space-theme-switch crt-amber
  space-theme-switch crt-green
  space-theme-switch kosmos-vfd
  ```

### Visual Configurator Modal
- Press `SUPER + ALT + T` to open `space-theme-config`.
- Use arrow keys (`j`/`k`) or number keys `1`-`4` to select and preview profiles.

---

## 🖼️ 2. How to Manage Historical Wallpapers

### Cycling In-Theme Wallpapers
- Press `SUPER + ALT + W` to cycle through curated historical photographs matching the active profile.
- Or open `space-theme-config` and switch to the **`[W] WALLPAPER`** tab.

### Adding Custom Wallpapers
1. Copy authentic archival high-resolution image files into:
   - `~/Space-Race-Theme/wallpapers/nasa/`
   - `~/Space-Race-Theme/wallpapers/crt-amber/`
   - `~/Space-Race-Theme/wallpapers/crt-green/`
   - `~/Space-Race-Theme/wallpapers/kosmos-vfd/`
2. Run `space-wallpaper refresh` to update the active cache.

---

## 🖥️ 3. How to Configure Multi-Monitor Display Topology

1. Open Display Radar via `SUPER + SHIFT + R` or `space-tools-dialog display`.
2. Select a preset:
   - `[1] EXTEND RIGHT`: External monitor placed to the right of primary.
   - `[2] EXTEND LEFT`: External monitor placed to the left.
   - `[3] MIRROR`: Clone primary display to projector/external screen.
   - `[4] PRIMARY ONLY`: Disable external displays.
   - `[5] DOCKED`: Clamshell mode (internal laptop screen off, external screen on).
   - `[6] AUTO-DETECT`: Reset to default Hyprland preferred topology.
3. Presets are saved persistently to `~/.config/hypr/monitors.conf`.

---

## 🕹️ 4. How to Configure the 8-Bit Screensaver

1. Open `space-theme-config` (`SUPER + ALT + T`) and switch to the **`[S] SCREENSAVER`** tab.
2. Select idle timeout duration: `1 min`, `2 min`, `5 min`, `10 min`, `15 min`, `30 min`, or `Never`.
3. Select scene mode:
   - `Random Rotation`: Cycles all 5 spaceflight simulation scenes.
   - `Individual Scene`: Lock to Apollo 11, Yuri Gagarin, Interkosmos, or NASA Recon.
4. Toggle **Lock on Wake**: Automatically engages `hyprlock` when moving the mouse to dismiss screensaver.

---

## 🌐 5. How to Set Persistent DNS Across All Network Interfaces

1. Open Communications Radar via `SUPER + SHIFT + N`.
2. Click **`[ COMM TEST & DNS ]`** (hotkey `T` / `C`).
3. Click **`[ ENGAGE & PERSIST ]`** on any provider (Cloudflare `1.1.1.1`, Quad9 `9.9.9.9`, Google `8.8.8.8`, AdGuard `94.140.14.14`, or Custom IP).
4. The DNS preference is saved persistently to `~/.config/space-theme/dns_preference.json` and applied automatically across all wired ethernet and Wi-Fi profiles.
