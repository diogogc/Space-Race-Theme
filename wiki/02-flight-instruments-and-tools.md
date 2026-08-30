# 🛠️ 02. Flight Instruments, Dialogs & Tools Manual

The Space Race Theme includes a rich suite of native Python GTK3/Cairo avionics dialogs and interactive utilities.

---

## 🎛️ 1. Apollo Operations & Tools Console (`space-tools-dialog`)

**Hotkeys**: `SUPER + SHIFT + P` / Waybar Tools button / `space-tools-dialog`

```
┌────────────────────────────────────────────────────────────────────────┐
│ 🛠️ APOLLO MISSION CONTROL // OPERATIONS & TOOLS                       │
│ [ STATUS: NOMINAL ] | UTC: 15:42:00 | PROFILE: NASA                   │
├────────────────────────────────────────────────────────────────────────┤
│ [📸 CAPTURE]   [🛰️ EECOM]   [🛡️ RECOVERY]   [📡 DISPLAY]               │
├────────────────────────────────────────────────────────────────────────┤
│ (Active Tab View with Real-Time Telemetry & Action Grid)               │
└────────────────────────────────────────────────────────────────────────┘
```

The Tools Console features 4 modular avionics tabs:

### Tab 1: 📸 [C] AV & Mission Capture
- `[1]` **Area Screenshot**: Interactive rectangle selection (`space-capture area`) with auto-copy and auto-save to `~/Pictures/prints`.
- `[2]` **Fullscreen Screenshot**: Instant display capture (`space-capture full`).
- `[3]` **Screen Video Recorder**: Launch the embedded recorder menu (`space-tools-dialog rec`) with options for:
  - Capture Mode: Region (`slurp`) or Full Desktop
  - Audio Routing: Desktop sound toggle, Microphone voice toggle
  - Transient Overlays: On-screen keystroke display toggle
- `[4]` **Open Prints Directory**: Open `~/Pictures/prints` in default file manager.
- `[5]` **Open Videos Directory**: Open `~/Videos` in default file manager.

### Tab 2: 🛰️ [E] EECOM Subsystems & Vitals
- **Live Vitals Telemetry Card**: Health index score (100/100), AI Director status, TRIM timer state, failed units, orphan packages, pacnew configs, root disk space, and journal storage.
- **Action Matrix**:
  - `[1]` **🩺 Run Full Health Diagnostic**: `space-eecom --scan` in terminal console.
  - `[2]` **🔧 Guided Auto-Remediation Sequence**: `space-eecom --fix` (guided safe maintenance).
  - `[3]` **⚡ SSD / NVMe TRIM Discard Routine**: `space-eecom --trim`.
  - `[4]` **📦 Inspect & Purge Orphaned Packages**: `space-eecom --orphans`.
  - `[5]` **📝 Reconcile Pending .pacnew Configs**: `space-eecom --pacnew`.
  - `[6]` **🧹 Optimize Pacman Cache & Prune Old**: `space-eecom --clean-cache`.
  - `[7]` **📜 Audit & Vacuum Oversized Logs**: `space-eecom --vacuum-logs`.
  - `[8]` **🤖 Consult Apollo AI Flight Director**: `space-eecom --ai`.
  - `[9]` **📋 Export Health Audit to Sys-Mem**: `space-eecom --audit`.

### Tab 3: 🛡️ [S] System Recovery & Snapshots
- `[1]` **Btrfs Root Snapshot**: Create immediate timestamped read-only snapshot (`/@snapshots/manual-*`).
- `[2]` **AI Recovery Diagnostics**: Launch `space-ai-recovery` harness.
- `[3]` **Configure AI Engine**: Select engine (`agy`, `claude`, `aider`, `ollama`, `custom`).
- `[4]` **Rebuild Ramdisks**: Run `sudo mkinitcpio -P`.
- `[5]` **Clean Package Stack**: `paccache -r` and orphan purge.

### Tab 4: 📡 [D] Multi-Monitor Display Radar
- **Live Topology Radar**: Visualizes all active monitors with resolutions, scale factors, positions, and focused workspace.
- **Quick Presets**:
  - `[1]` Extend Right (Workstation default)
  - `[2]` Extend Left
  - `[3]` Mirror / Presentation Mode
  - `[4]` Primary Only (Battery saver)
  - `[5]` Docked Desktop (Clamshell mode)
  - `[6]` Auto-Detect & Reset

---

## 🎛️ 2. Apollo AGC DSKY Application Launcher (`dsky-launcher`)

**Hotkeys**: `SUPER + Space` / `SUPER + R` / `dsky-launcher`

- **AGC Colossus Interface**: Authentic MIT Apollo Guidance Computer aesthetic.
- **8 Mission Categories**:
  - `[0] ALL`: Complete flight applications index
  - `[1] INTERNET`: Web browsers, communication clients
  - `[2] CODE`: IDEs, text editors, Git tools
  - `[3] TERMINAL`: Ghostty, Kitty, consoles
  - `[4] MEDIA`: Audio players, video editors, image viewers
  - `[5] GRAPHICS`: GIMP, Inkscape, 3D suites
  - `[6] SYSTEM`: Configuration, disks, sysadmin tools
  - `[7] SCIENCE`: Calculators, telemetry trackers, math
- **Keyboard Shortcuts**: Number keys `0`-`7` jump to category, `V` cycles mission themes, `F` searches apps, `Enter` executes.

---

## 🪟 3. Apollo HUD Mission Window Switcher (`space-switcher`)

**Hotkeys**: `ALT + TAB` / `SUPER + TAB` / `space-switcher`

- Seamless Wayland alt-tab modal overlay.
- Lists active windows with workspace chips, application icons, and window titles.
- Fully navigable with `Tab` / `Shift+Tab`, `j` / `k`, arrow keys, or mouse hover.

---

## 🎨 4. Visual Avionics & Theme Configurator (`space-theme-config`)

**Hotkeys**: `SUPER + ALT + T` / `space-theme-config`

Features 5 interactive management tabs:
1. **Themes Tab**: Select active mission profile (`nasa`, `crt-amber`, `crt-green`, `kosmos-vfd`).
2. **Wallpaper Gallery**: Browse, preview, and select historical wallpapers.
3. **Screensaver Settings**: Set timeout minutes, scene mode, and lock-on-wake toggle.
4. **Waybar Modules**: Toggle visibility of individual status bar pills.
5. **Plugins Tab**: Install, enable, disable, and update standalone theme plugins (`eecom`, `space-update`, `iss-tracker`).

---

## 📡 5. Communications & S-Band Wi-Fi Radar (`space-network-dialog`)

**Hotkeys**: `SUPER + SHIFT + N` / Click Waybar Wi-Fi module

- **Analog S-Meter Dial**: Cairo-rendered RF signal gauge calibrated in S-Units (`S1`-`S9+30dB`).
- **Station Scanner**: Discovered Wi-Fi networks with signal rating and encryption badges.
- **RF Comm Diagnostics**: Ping latency, packet loss, download/upload bandwidth testing.
- **Persistent DNS Selector**: One-click DNS engagement (Cloudflare, Quad9, Google, AdGuard, DHCP).
- **VPN Dispatch**: Manage WireGuard and OpenVPN connections.

---

## ⚡ 6. MDC-02 Main Power Bus & Energy Telemetry (`space-energy-dialog`)

**Hotkeys**: `SUPER + SHIFT + E` / Click Waybar Battery module

- **Apollo Edgewise Needle Meters**:
  - `DC MAIN BUS A`: Fuel cell / battery capacity scale.
  - `DC BUS VOLTS`: Real-time operating voltage readout.
  - `DC MAIN BUS B`: Power flow discharge rate in Watts.
- **Flight Power Modes**: Emergency (Power Save), Coasting (Balanced), Orbit Maneuver (Performance).
- **Console Brightness**: Hardware backlight adjustment slider.

---

## 🎙️ 7. CAPCOM Audio & Radio Intercom (`space-capcom-dialog`)

**Hotkeys**: `SUPER + SHIFT + V` / Click Waybar Audio module

- Dual real-time VU audio meters with peak hold bars.
- WirePlumber default input/output sink selectors.
- Volume sliders with Quindar audio telemetry test tone generator.

---

## 🕹️ 8. 8-Bit Retro Space Screensaver (`space-screensaver`)

**Hotkeys**: `SUPER + SHIFT + O` / `space-screensaver`

- Nearest-neighbor 480x270 retro pixel animation engine.
- 5 historical scenes:
  1. *Arch Linux Deep Space Reconnaissance*
  2. *NASA Meatball Space Station Orbit*
  3. *Apollo 11 Eagle Lunar Descent & Landing*
  4. *Interkosmos Orbital Matrix*
  5. *Vostok 1 Yuri Gagarin Orbital Mission*
