# 🛠️ 02. Flight Instruments, Dialogs & Tools Manual

The **Space Race Theme** provides an extensive, authentic suite of native Python GTK3/Cairo avionics instruments, telemetry daemons, and system dialogs designed with strict zero-white-background chassis adherence.

---

## 🎛️ 1. Apollo Operations & Tools Console (`space-tools-dialog`)

**Hotkeys**: `SUPER + SHIFT + P` / Waybar Tools button / `space-tools-dialog`

The Tools Console is a 4-in-1 tabbed avionics workstation unifying capture, system maintenance, recovery, and display topology.

```mermaid
graph LR
    A[space-tools-dialog] --> B["[C] AV & Capture"]
    A --> C["[E] EECOM Vitals"]
    A --> D["[S] System Recovery"]
    A --> E["[D] Display Radar"]

    B --> B1[Area / Full Screenshots]
    B --> B2[Screen Video Recorder]
    C --> C1[Live Vitals Card]
    C --> C2[9 Maintenance Actions]
    D --> D1[Btrfs Snapshots]
    D --> D2[AI Harness & Initramfs]
    E --> E1[Topology Visualizer]
    E --> E2[6 Display Presets]
```

### Tab 1: 📸 [C] AV & Mission Capture
<div align="center">
  <img src="assets/wiki_tools_capture.png" alt="AV & Mission Capture Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- `[1]` **Area Screenshot**: Interactive box selection (`space-capture area`) with shutter audio and auto-save to `~/Pictures/prints`.
- `[2]` **Fullscreen Screenshot**: Instant display capture (`space-capture full`).
- `[3]` **Screen Video Recorder**: Opens embedded recording options menu (`space-tools-dialog rec`).
- `[4]` **Open Prints Directory**: View captured screenshots in `~/Pictures/prints`.
- `[5]` **Open Videos Directory**: View recorded screen videos in `~/Videos`.

#### 🎥 Video Recording Configuration Sub-View
<div align="center">
  <img src="assets/wiki_tools_rec.png" alt="Video Recording Configuration View" width="90%" style="border-radius: 6px; border: 1px solid #ff333355;" />
</div>

- **Capture Region**: Toggle between `Region Selection (slurp)` and `Full Screen Display`.
- **Audio Routing**: Toggle desktop system sounds and microphone intercom audio independently.
- **Keystroke Overlay**: Security-conscious opt-in keystroke visualization.

---

### Tab 2: 🛰️ [E] EECOM Subsystems & Vitals
<div align="center">
  <img src="assets/wiki_tools_eecom.png" alt="EECOM Subsystems Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Live Telemetry & Health Vitals Card**: Real-time health score calculation (`100/100 [NOMINAL]`), AI Director engine status, TRIM timer state, failed systemd units, orphan packages count, pending `.pacnew` configs, root storage, and journal usage.
- **Interactive Action Matrix**:
  - `[1]` **🩺 Run Full Health Diagnostic**: `space-eecom --scan` in terminal console.
  - `[2]` **🔧 Guided Auto-Remediation Sequence**: `space-eecom --fix` (guided safe maintenance with item previews & confirmation before every step).
  - `[3]` **⚡ SSD / NVMe TRIM Discard Routine**: `space-eecom --trim`.
  - `[4]` **📦 Inspect & Purge Orphaned Packages**: `space-eecom --orphans`.
  - `[5]` **📝 Reconcile Pending .pacnew Configs**: `space-eecom --pacnew`.
  - `[6]` **🧹 Optimize Pacman Cache & Prune Old**: `space-eecom --clean-cache`.
  - `[7]` **📜 Audit & Vacuum Oversized Logs**: `space-eecom --vacuum-logs`.
  - `[8]` **🤖 Consult Apollo AI Flight Director**: `space-eecom --ai`.
  - `[9]` **📋 Export Health Audit to Sys-Mem**: `space-eecom --audit`.

---

### Tab 3: 🛡️ [S] System Recovery & Snapshots
<div align="center">
  <img src="assets/wiki_tools_system.png" alt="System Recovery Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- `[1]` **Btrfs Root Snapshot**: Creates timestamped read-only root snapshot (`/@snapshots/manual-*`).
- `[2]` **AI Recovery Diagnostics**: Dispatches `space-ai-recovery` harness.
- `[3]` **Configure AI Engine**: Select engine (`agy`, `claude`, `aider`, `ollama`, `custom`).
- `[4]` **Rebuild Ramdisks**: Runs `sudo mkinitcpio -P` for all kernels.
- `[5]` **Clean Package Stack**: Runs `paccache -r` and orphan purge.

---

### Tab 4: 📡 [D] Multi-Monitor Display Radar
<div align="center">
  <img src="assets/wiki_tools_display.png" alt="Display Radar Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Live Topology Radar**: Displays detected monitors, resolutions, refresh rates, positions, and active workspaces.
- **1-Click Topology Presets**:
  - `[1]` Extend Right (Workstation default)
  - `[2]` Extend Left
  - `[3]` Mirror / Presentation Mode
  - `[4]` Primary Only (Battery saver)
  - `[5]` Docked Desktop (Clamshell mode)
  - `[6]` Auto-Detect & Reset

---

## 🎨 2. Visual Avionics & Theme Configurator (`space-theme-config`)

**Hotkeys**: `SUPER + ALT + T` / `space-theme-config`

```mermaid
graph LR
    A[space-theme-config] --> B["[T] Themes"]
    A --> C["[W] Wallpapers"]
    A --> D["[S] Screensaver"]
    A --> E["[M] Waybar Modules"]
    A --> F["[P] Plugins Manager"]
```

### 1. Themes Selector Tab (`[T]`)
<div align="center">
  <img src="assets/wiki_config_theme.png" alt="Theme Selector Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Live visual switching across NASA, CRT-Amber, CRT-Green, and Kosmos-VFD profiles.

### 2. Wallpaper Gallery Tab (`[W]`)
<div align="center">
  <img src="assets/wiki_config_wallpaper.png" alt="Wallpaper Gallery Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Browse and apply authentic historical archival scans and photographs matching the active profile.

### 3. Screensaver Settings Tab (`[S]`)
<div align="center">
  <img src="assets/wiki_config_screensaver.png" alt="Screensaver Settings Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Configure idle timeouts (1m to 30m), scene modes, and Lock-on-Wake security enforcement.

### 4. Waybar Modules Tab (`[M]`)
<div align="center">
  <img src="assets/wiki_config_modules.png" alt="Waybar Modules Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Toggle individual Waybar pills (MET, CPU/MEM, Power Bus, S-Band Wi-Fi, CAPCOM Audio).

### 5. Plugins Manager Tab (`[P]`)
<div align="center">
  <img src="assets/wiki_config_plugins.png" alt="Plugins Manager Tab" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Install, enable, disable, and update standalone plugins (`eecom`, `space-update`, `iss-tracker`, etc.).

---

## 🎛️ 3. Apollo AGC DSKY Application Launcher (`dsky-launcher`)

**Hotkeys**: `SUPER + Space` / `SUPER + R` / `dsky-launcher`

<div align="center">
  <img src="assets/wiki_dsky_launcher.png" alt="Apollo AGC DSKY Launcher" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- Authentic MIT Apollo Guidance Computer interface with 8 mission filter groups (`Internet`, `Code`, `Terminal`, `Media`, `Graphics`, `System`, `Science`, `All`).
- Real-time search filter and instant execution on `Enter`.

---

## 🪟 4. Apollo HUD Mission Window Switcher (`space-switcher`)

**Hotkeys**: `ALT + TAB` / `SUPER + TAB` / `space-switcher`

<div align="center">
  <img src="assets/wiki_space_switcher.png" alt="Apollo HUD Window Switcher" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

Wayland Alt-Tab window switcher modal with live workspace badges, icons, and titles.

---

## 📡 5. Communications & S-Band Wi-Fi Radar (`space-network-dialog`)

**Hotkeys**: `SUPER + SHIFT + N` / Click Waybar Wi-Fi module

### 1. S-Meter Analog Receiver & Wi-Fi Station Scanner
<div align="center">
  <img src="assets/wiki_network_main.png" alt="Communications & S-Band Wi-Fi Radar" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Analog S-Meter Dial**: Cairo-rendered RF signal gauge calibrated in discrete S-Units (`S1`-`S9+30dB`).
- **Station Scanner**: Discovered Wi-Fi networks with signal rating and encryption badges.

### 2. RF Propagation Comm Diagnostics & Ground DNS Relays
<div align="center">
  <img src="assets/wiki_network_test.png" alt="RF Comm Diagnostics and DNS Relays" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Speed & Latency Telemetry**: Round-trip propagation ping latency, packet loss, download speed, and upload throughput.
- **Persistent DNS Selector**: One-click DNS engagement (Cloudflare, Quad9, Google, AdGuard, DHCP) across all network profiles.

### 3. Encrypted VPN Tunnel Dispatch & Bluetooth Manager
<div align="center">
  <img src="assets/wiki_network_vpn.png" alt="VPN Tunnel Dispatch" width="48%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
  <img src="assets/wiki_network_bluetooth.png" alt="Bluetooth Subsystem" width="48%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **VPN Hub**: OpenVPN and WireGuard encrypted connection dispatch and configuration editor.
- **Bluetooth Avionics**: Nearby device discovery, pair, trust, and connection toggles.

---

## ⚡ 6. MDC-02 Main Power Bus & Energy Telemetry (`space-energy-dialog`)

**Hotkeys**: `SUPER + SHIFT + E` / Click Waybar Battery module

<div align="center">
  <img src="assets/wiki_energy_dialog.png" alt="MDC-02 Main Power Bus Telemetry" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Apollo Edgewise Needle Meters**: `DC MAIN BUS A` (Capacity %), `DC BUS VOLTS` (VDC Potential), and `DC MAIN BUS B` (Discharge Watts).
- **Flight Power Modes**: Emergency (Power Save), Coasting (Balanced), Orbit Maneuver (Performance).
- **Console Brightness**: Hardware backlight adjustment slider.

---

## 📊 7. Hardware Telemetry & Task Abort Console (`space-telemetry-dialog`)

**Hotkeys**: `SUPER + SHIFT + C` / Click Waybar Telemetry module

<div align="center">
  <img src="assets/wiki_telemetry_dialog.png" alt="Hardware Telemetry Console" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- Segmented LED CPU utilization meter and per-core thread indicators.
- AGC memory allocation meter and filesystem data recorders.
- Interactive process task monitor with instant filtering and SIGTERM/SIGKILL abort confirmation.

---

## 🎙️ 8. CAPCOM Audio & Radio Intercom (`space-capcom-dialog`)

**Hotkeys**: `SUPER + SHIFT + V` / Click Waybar Audio module

<div align="center">
  <img src="assets/wiki_capcom_dialog.png" alt="CAPCOM Audio Intercom" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- Dual real-time VU audio meters with peak hold bars.
- WirePlumber default input/output sink selectors and Quindar audio test tones.

---

## 🛰️ 9. ISS Real-Time Orbital Tracker (`space-iss-dialog`)

**Hotkeys**: Waybar ISS pill / `space-iss-dialog`

<div align="center">
  <img src="assets/wiki_iss_dialog.png" alt="ISS Real-Time Orbital Tracker" width="90%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- Live ISS orbital tracking coordinates, altitude, velocity, and astronaut crew roster.

---

## 🧭 10. Keybinding Flight Directory & Abort Menu

<div align="center">
  <img src="assets/wiki_keybinds.png" alt="Keybinding Flight Guide" width="48%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
  <img src="assets/wiki_power_menu.png" alt="Flight Abort Power Menu" width="48%" style="border-radius: 6px; border: 1px solid #ffb00055;" />
</div>

- **Keybinding Directory (`space-keybinds`)**: Searchable flight control cheatsheet (`SUPER + SHIFT + K`).
- **Emergency Flight Abort (`space-power-menu`)**: Clean session logout, reboot, shutdown, lock (`SUPER + SHIFT + M` / `ESC`).
