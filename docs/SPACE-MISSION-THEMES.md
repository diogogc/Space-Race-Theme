---
title: Space Mission Control Desktop Theme System
date: 2026-08-25
last_modified: 2026-08-25
tags:
  - system
  - theme
  - hyprland
  - waybar
  - kitty
status: active
---

# 🚀 Space Mission Control Desktop Theme System

> [!NOTE]
> Dynamic multi-profile desktop theming system for Arch Linux running Hyprland, Waybar, and Kitty. Inspired by the Apollo space race era, vintage mainframe CRT terminals, and Soviet Kosmos instrumentation.

---

## 🎨 Theme Profiles

1. **`nasa` (Flight Operations)**
   - *Palette*: Matte console slate (`#14171d`), DSKY amber accents (`#ffb000`), telemetry phosphor green (`#2ef788`), flight white (`#e2e8f0`).
   - *Hyprland*: 2px border, 4px rounding, subtle instrument bezel shadow.
   - *Waybar*: Clean modular flight badges, seamless borderless bar.

2. **`crt-amber` (Mainframe Phosphor Amber CRT)**
   - *Palette*: Pitch black (`#0b0c0e`), 590nm phosphor amber glow (`#ffb000`, `#ff9e00`).
   - *Wallpaper*: Authentic high-resolution historical photograph of the **DEC VT220 Terminal Console & Keyboard** (with real DEC PDP-11 Blinkenlights and IBM 3278 mainframe consoles archived in theme folder).
   - *Hyprland*: 0px razor-sharp CRT rounding, amber glow borders, 0.94 opacity.
   - *Waybar*: Amber glowing text shadows, seamless borderless bar.

3. **`crt-green` (DEC VT100 / P1 Phosphor Green CRT)**
   - *Palette*: Pitch black (`#0a0e0a`), 525nm matrix green glow (`#33ff33`).
   - *Wallpaper*: Authentic archival photograph scan (**NASA Lewis Research Center / Bell Labs, 1962**) showing engineers performing final cleanroom assembly and checkout testing on the **Telstar Satellite** test stand.
   - *Hyprland*: 0px razor-sharp CRT rounding, green glow borders.
   - *Waybar*: Phosphor green glowing text shadows, seamless borderless bar.

4. **`kosmos-vfd` (Soviet Space Program / Vostok-Soyuz)**
   - *Palette*: Industrial dark teal (`#142421`), VFD cyan/mint glow (`#48e5c2`), Bakelite dial cream (`#f4eedb`).
   - *Hyprland*: 3px rounding, VFD cyan active borders.
   - *Waybar*: Soviet console styling with VFD glow badges and seamless borderless bar.

---

## 🕹️ Controls & Interaction

- **Keybinding**: `SUPER + SHIFT + T` cycles to the next theme profile on the fly.
- **Waybar Widget**: Click the `[ 🚀 APOLLO-1969 ]` widget on the top left of the bar to cycle themes. Right-click cycles backwards.
- **CLI Switcher**:
  ```bash
  ~/.local/bin/space-theme-switch next
  ~/.local/bin/space-theme-switch prev
  ~/.local/bin/space-theme-switch nasa
  ~/.local/bin/space-theme-switch crt-amber
  ~/.local/bin/space-theme-switch crt-green
  ~/.local/bin/space-theme-switch kosmos-vfd
  ```

---

## 🛰️ Telemetry Modules (`Waybar`)

- **Mission Elapsed Time (`MET`)**: [`~/.local/bin/space-met`](file:///home/diogo/.local/bin/space-met)
  - Calculates mission uptime formatted as `MET +HH:MM:SS` along with live UTC time.
- **Hardware Telemetry & Flight Task Subsystem**: [`~/.local/bin/space-telemetry`](file:///home/diogo/.local/bin/space-telemetry) & [`~/.local/bin/space-telemetry-dialog`](file:///home/diogo/.local/bin/space-telemetry-dialog)
  - Real-time CPU usage, CPU temperature via `/sys/class/hwmon/`, and RAM usage formatted on Waybar as `[CPU: 12% 42°C | MEM: 23%]`.
  - **Click on Bar (Left/Right)** or **Keybinding (`SUPER + SHIFT + C`)**: Opens the **Apollo System Hardware Telemetry & Task Dispatch Console** (`space-telemetry-dialog`):
    - ⚡ **Processor Core Utilization Meter**: Cairo horizontal segmented LED bar meter, current CPU frequency (GHz), and thermal core readout (°C).
    - 🚀 **Multi-Core Thread Bus Grid**: Per-core live telemetry bar indicators (C0–CN).
    - 💾 **AGC Memory Core Allocation**: Segmented memory meter (Active application RAM / Page & Buffer Caches / Available RAM), swap usage telemetry, and load averages.
    - 💽 **Telemetry Data Recorder Volumes**: Root `/` and `/home` filesystem storage telemetry.
    - 📋 **Active Flight Tasks & Process Monitor**: Live process monitor with instant text filtering (`F` / `/`), sort toggles (CPU% / MEM%), process abort controls (`SIGTERM` / `SIGKILL` with Apollo confirmation modal), cache trimming (`T`), and Htop terminal launcher (`H`).
- **Power Telemetry & Energy Subsystem**: [`~/.local/bin/space-power-telemetry`](file:///home/diogo/.local/bin/space-power-telemetry) & [`~/.local/bin/space-energy-dialog`](file:///home/diogo/.local/bin/space-energy-dialog)
  - Formatted on Waybar as clean minimal telemetry: `PWR-BUS: 100%` or `PWR-BUS: 85%`.
  - **Click on Bar (Left/Right)**: Opens the interactive **Apollo Command Module Power Telemetry Console** (`space-energy-dialog`):
    - **Apollo MDC-02 Vertical Edgewise Needle Indicators (Cairo Rendered)**:
      - 🚀 **DC MAIN BUS A (Fuel Cell Capacity %)**: Vertical scale (0–100%) with colored range zones (Red emergency 0–25%, Amber caution 25–50%, Green nominal 50–100%) and a moving mechanical horizontal needle pointer.
      - ⚡ **DC BUS VOLTS (Bus Potential V)**: Vertical voltage scale (0–20V) with nominal flight bus range (Green 11.4–14.5V, Yellow/Red limits) and live VDC digital readout.
      - 🔋 **DC MAIN BUS B (Power Rate Watts)**: Vertical power flow rate meter (0–50W / AC Bus) with mechanical vertical needle indicator.
    - **Flight Power Mode Switcher**:
      - `[01: EMERGENCY]` (Low-Power Drift / Power Saver)
      - `[02: COASTING]` (Nominal Orbital Flight / Balanced)
      - `[03: ORBIT MANEUVER]` (Full Thrust Engaged / Performance)
      - Quick `[ ⚡ CYCLE STAGE (TAB) ]` button & hotkeys (`1-3`, `Tab`, `c`).
    - **Console Illumination**: Live hardware display brightness slider integrated via `systemd-logind` Session DBus (`intel_backlight`).
    - **Design Policy**: Zero white backgrounds — pure dark matte chassis (`#0a0d12`), pitch black inlay tracks (`#030406`), and phosphor glows.
- **Network & Comms Subsystem**: [`~/.local/bin/space-network-dialog`](file:///home/diogo/.local/bin/space-network-dialog) & [`~/.local/bin/space-network-telemetry`](file:///home/diogo/.local/bin/space-network-telemetry)
  - **Waybar Integration**: Displays live S-Meter readouts formatted as `RF: S9` or `RF: S9+20dB` (or `ETH OK`). Clicking launches the interactive **Apollo Comms & Telemetry Console**.
  - **Keybinding**: `SUPER + SHIFT + N` opens the Comms console anywhere.
  - **Features**:
    - 📡 **Vintage Communications Receiver S-Meter**: Authentic Cairo-rendered signal strength meter calibrated in discrete S-Units (`S1` to `S9`, 6 dB per S-unit) with a dedicated redline zone for decibels over S9 (`+10dB`, `+20dB`, `+30dB`), digital S-unit readout (`S9 (-49 dBm)`), and carrier lock telemetry.
    - 📶 **S-Meter Station Scanner**: Discovered Wi-Fi stations list displays live S-Meter ratings (`S9+20dB`, `S7`, `S4`) with color-coded signal badges and dBm readouts.
    - 🌐 **Uplink Telemetry Status**: Active connection parameters (SSID/Wired, IP address, Gateway, DNS, RF band 2.4/5GHz, channel, bitrate, MAC address).
    - 📻 **Carrier Radio Toggle**: Quick toggle for Wi-Fi radio ON/OFF (`[ 📡 RADIO: ON / OFF ]`, hotkey `W`).
    - 🕵️ **Hidden Carrier Registration**: Dedicated modal (`[ HIDDEN SSID ]`, hotkey `H`) to connect to non-broadcasting SSIDs.
    - ⚡ **Comm Test & Bandwidth Telemetry**: Interactive RF diagnostic console (`[ COMM TEST & DNS ]`, hotkey `T` / `C`) measuring round-trip propagation ping latency, packet loss, download speed, and upload speed.
    - 🌐 **Ground Station DNS Relay Selector**: 1-click DNS switcher with live latency ping testing against major providers (Cloudflare, Google, Quad9, AdGuard, OpenDNS, DHCP Automatic, and custom IP input).
    - 🛡️ **Secure Tunnel & VPN Dispatch (`vpnconfig`)**: Interactive VPN panel (`[ VPN CONFIG ]`, hotkey `V`) with active encrypted tunnel status, list of configured OpenVPN/WireGuard profiles with 1-click engage/disengage, `.ovpn`/`.conf` file importer, and editor integration.
    - 📡 **VHF Short-Range EVA & Bluetooth Subsystem**: Dedicated Bluetooth console (`[ BLUETOOTH ]`, hotkey `B`) with controller status (`hci0`), power toggle (`[ POWER: ON / OFF ]`), 2.4 GHz ISM peripheral scanner (`[ SCAN DEVICES ]`), 1-click connect/disconnect, battery telemetry, and Blueman GUI integration.
    - ⚙️ **NM Connection Configuration**: Quick access button to launch NetworkManager connection editor (`[ NM-CONFIG ]`, hotkey `E`).
- **CAPCOM Audio & Intercom Subsystem**: [`~/.local/bin/space-capcom-dialog`](file:///home/diogo/.local/bin/space-capcom-dialog)
  - **Waybar Integration**: Clicking the `pulseaudio` volume module on Waybar (`VOL XX%`) opens the **Apollo CAPCOM Audio & Intercom Console** (Right-click toggles quick mute).
  - **Keybinding**: `SUPER + SHIFT + V` / `SUPER + SHIFT + A` opens the CAPCOM console anywhere.
  - **Launcher**: Searchable in DSKY Launcher (`SUPER + SPACE` / `SUPER + R`) under `CAPCOM Audio & Intercom Console`.
  - **Features**:
    - 🎙️ **Dual Cairo Segmented VU Meters**: Master Cabin Intercom (RX) volume meter and CAPCOM Comm (TX) microphone sensitivity meter.
    - 🎚️ **Precision Sliders & Mute Toggles**: Independent output/input level control with instant mute toggles.
    - ⚡ **Preset Level Dispatch**: `[ SILENCE ]`, `[ CABIN 30% ]`, `[ NOMINAL 70% ]`, `[ FULL 100% ]`.
    - 🔔 **Quindar Audio Test Tone**: Built-in 2524 Hz Apollo test tone generator (`[ TEST QUINDAR TONE ]`, hotkey `T`).
    - 🔀 **WirePlumber Endpoint Routing**: 1-click output sink & input source device selector.

---

## 🖼️ Authentic Historical Period Wallpapers (`~/Pictures/Wallpapers/historical/`)
Each mission profile uses authentic high-resolution public domain photographs from the Space Race era (NASA & Soviet state archives):
- **NASA (Flight Operations)**: `~/Pictures/Wallpapers/nasa.jpg`
  - *Default*: Apollo 11 Mission Operations Control Room (MOCR) celebration upon lunar landing success.
  - *Archive Alternatives*:
    - Gene Kranz at his MOCR console (`nasa_gene_kranz_console.jpg`)
    - Saturn V launch at Pad 39A (`nasa_saturn_v_launch.jpg`)
    - Apollo 8 iconic Earthrise (`nasa_earthrise_apollo8.jpg`)
    - Gemini 4 first American spacewalk - Ed White (`nasa_gemini4_spacewalk.jpg`)
    - Buzz Aldrin on the Moon surface with LM reflection (`nasa_apollo11_aldrin_moon.jpg`)
- **CRT-Amber (Mainframe / Tracking Operations)**: `~/Pictures/Wallpapers/crt-amber.jpg`
  - Authentic 1960s IBM System/360 Model 91 mainframe console with glowing panel lights and CRT scope (`crt_amber_ibm_system360.jpg`).
- **CRT-Green (DEC VT100 / MIT Instrumentation Lab)**: `~/Pictures/Wallpapers/crt-green.jpg`
  - Authentic Apollo Guidance Computer (AGC) and DSKY interface hardware at the Smithsonian National Air and Space Museum (`crt_green_apollo_agc.jpg` & `crt_green_apollo_dsky_chm.jpg`).
- **Kosmos-VFD (Soviet Space Program)**: `~/Pictures/Wallpapers/kosmos-vfd.jpg`
  - *Default*: **Sputnik 1 Replica at the Smithsonian National Air and Space Museum** (`sputnik_1_nasm_smithsonian.jpg`, 5568x3712).
  - *Alternatives*:
    - Sputnik 1 1957 historic flight photo (`sputnik_1_satellite_1957.jpg`, 3000x1911)
    - Soyuz 19 (ASTP) in Earth orbit (`soyuz_19_in_orbit_astp.jpg`, 4096x3234)
    - Soyuz TMA-6 approaching in orbit (`soyuz_tma6_earth_orbit.jpg`, 2936x2000)
    - Sputnik 1 high-resolution space model (`sputnik_1_space_model.jpg`, 2964x2096)
    - Yuri Gagarin 1961 portrait in flight helmet (`soviet_gagarin_1961.jpg`)
    - Voskhod / Vostok IMP "Globus" orbital navigation instrument (`soviet_globus_instrument.jpg`).

*Hyprpaper v0.8+ Setup*: Configured in [`~/.config/hypr/hyprpaper.conf`](file:///home/diogo/.config/hypr/hyprpaper.conf) with the v0.8 block syntax (`wallpaper { monitor = ... }`) and `misc.force_default_wallpaper = 0` in [`~/.config/hypr/hyprland.lua`](file:///home/diogo/.config/hypr/hyprland.lua), completely eliminating default wallpaper resets on boot.

---

## 🌓 System-Wide Dark Theme Standard (Third-Party & Web Apps)
Third-party applications (Firefox, Chrome, VS Code, Electron, Spotify, LibreOffice, Dolphin, Flatpaks, GTK3/4, Qt6) recognize dark mode via 4 synchronized configuration layers:
1. **FreeDesktop / XDG Appearance Portal (`color-scheme: prefer-dark`)**:
   - `gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'`
2. **GTK3 & GTK4 Settings (`~/.config/gtk-3.0/settings.ini` & `~/.config/gtk-4.0/settings.ini`)**:
   - `gtk-application-prefer-dark-theme=1` & `gtk-theme-name=Adwaita-dark`
3. **KDE / Qt Color Scheme (`~/.config/kdeglobals`)**:
   - `[Colors:Window]` & `[Colors:View]` dark background palette generated dynamically by `space-theme-switch`.
4. **Hyprland Environment (`~/.config/hypr/hyprland.lua`)**:
   - `GTK_THEME=Adwaita-dark` & `COLOR_SCHEME=prefer-dark`

---

## 🔒 Themed Lockscreen (`hyprlock`)
- **Config**: [`~/.config/hypr/hyprlock.conf`](file:///home/diogo/.config/hypr/hyprlock.conf)
- **Keybinding**: `SUPER + L`
- **Design & Features**:
  - Blurred dynamic background synced with the active profile's authentic historical wallpaper.
  - Top Annunciator: `🚀 NASA / APOLLO MISSION CONTROL // SECURE FLIGHT TELEMETRY TERMINAL`.
  - Telemetry Banner: Live Mission Elapsed Time (`MET +XXh YYm`) & status indicator.
  - Giant High-Visibility Mission Clock: `HH:MM:SS UTC` and local station time.
  - DSKY Passcode Field: Apollo Verb 21 password prompt with glowing amber/green indicators and `1202 ALARM: INVALID ACCESS KEY` failure messaging.

---

## 🚪 System Startup & Login Screen (`SDDM`)
- **Theme Location**: `~/.config/themes/sddm-space-race/`
- **Installer Script**: [`~/.local/bin/space-sddm-install`](file:///home/diogo/.local/bin/space-sddm-install) (`sudo ~/.local/bin/space-sddm-install`)
- **Design & Features**:
  - Full Apollo MOCR Houston Flight Control aesthetic with UTC/local telemetry clocks.
  - Retro operator authentication card, session selector, and themed power controls (`ABORT / POWER OFF`, `RE-IGNITION / REBOOT`, `ORBITAL SLEEP / SUSPEND`).

---

## 🛑 Power & Telemetry Abort System (`space-power-menu`)
- **Script**: [`~/.local/bin/space-power-menu`](file:///home/diogo/.local/bin/space-power-menu)
- **Waybar Integration**: Themed `[ ⏻ OPP ]` flight operations badge on the right side of Waybar.
  - Left-Click: Opens interactive Apollo Flight Operations Menu (`SUPER + SHIFT + M`).
  - Right-Click: Instant screen lock (`hyprlock`).
- **Keybindings**: `SUPER + SHIFT + M` or `SUPER + Escape`
- **Actions & Controls**:
  - `[1] / [s]`: **MISSION ABORT // SHUTDOWN** (`systemctl poweroff`)
  - `[2] / [r]`: **STAGE RE-IGNITION // REBOOT** (`systemctl reboot`)
  - `[3] / [u]`: **ORBITAL STANDBY // SUSPEND** (`systemctl suspend`)
  - `[4] / [l]`: **FLIGHT LOCK // SECURE CONSOLE** (`hyprlock`)
  - `[5] / [e]`: **MISSION LOGOUT // DISPATCH EXIT** (`hyprctl dispatch exit`)
  - `[ESC] / [q]`: Cancel / return to flight.

---

## 🔔 Themed Notifications (`Dunst`)
- **Configs**: `~/.config/themes/<theme>/dunstrc` synced to `~/.config/dunst/dunstrc` on theme switch.
- **Flight-Deck Styling**:
  - *Low Urgency*: Muted console slate telemetry notices.
  - *Normal Urgency*: Active theme amber/cyan/green bordered flight dispatch messages.
  - *Critical Urgency*: High-visibility alert cards with red alarm borders for critical telemetry.

---

## 📁 Key File Locations

- **Theme Root**: `~/.config/themes/`
- **Historical Wallpapers**: `~/Pictures/Wallpapers/historical/`
- **Hyprland Config**: [`~/.config/hypr/hyprland.lua`](file:///home/diogo/.config/hypr/hyprland.lua) (loads `theme-current.lua`, binds `SUPER + L`, `SUPER + SHIFT + M`, `SUPER + Escape`)
- **Hyprpaper Config**: [`~/.config/hypr/hyprpaper.conf`](file:///home/diogo/.config/hypr/hyprpaper.conf)
- **Hyprlock Config**: [`~/.config/hypr/hyprlock.conf`](file:///home/diogo/.config/hypr/hyprlock.conf)
- **Power & Abort Menu**: [`~/.local/bin/space-power-menu`](file:///home/diogo/.local/bin/space-power-menu)
- **Power Telemetry Dialog**: [`~/.local/bin/space-energy-dialog`](file:///home/diogo/.local/bin/space-energy-dialog)
- **Network & Comms Telemetry Dialog**: [`~/.local/bin/space-network-dialog`](file:///home/diogo/.local/bin/space-network-dialog)
- **Dunst Notification Configs**: `~/.config/dunst/dunstrc`
- **SDDM Space Theme**: `~/.config/themes/sddm-space-race/`
- **Waybar Config & Style**: [`~/.config/waybar/config.jsonc`](file:///home/diogo/.config/waybar/config.jsonc), [`~/.config/waybar/style.css`](file:///home/diogo/.config/waybar/style.css)
- **Kitty Theme**: [`~/.config/kitty/current-theme.conf`](file:///home/diogo/.config/kitty/current-theme.conf)
- **Application Launcher (DSKY)**: [`~/.local/bin/dsky-launcher`](file:///home/diogo/.local/bin/dsky-launcher)

## 📋 Planned Enhancements (Roadmap)
- [ ] **Unified Quick Settings Dropdown Panel**: Group Audio, Energy, and Network settings into an Apollo telemetry styled dropdown panel.
- [x] **Themed System Notifications (`Dunst`)**: Annunciator matrix / telemetry alert popups and flight log notification center.
- [ ] **Themed File Manager (GTK / Qt & Terminal FM)**: Space console styling for file managers (Thunar / Nautilus / Yazi).
- [x] **Themed Lockscreen (`hyprlock`)**: Vintage telemetry console / DSKY layout with MET, UTC clock, and glowing phosphor accents.
- [x] **System Login Screen (SDDM / Display Manager)**: Matching retro space mission control login greeter and installer.
- [x] **System Power Controls (Shutdown / Reboot / Suspend / Lock)**: Themed power action triggers with dedicated `space-power-menu` modal and Waybar emergency `⏻ [ABORT]` module.
- [ ] **Screensaver / Idle Animation**: Vintage radar sweep, AGC Colossus guidance code scroll, or orbital telemetry wireframe.
- *Detailed tracker*: [[TODO|System & Theme Development TODO]].

---

## 🛡️ Security Hardening & Release Audit (Public Release Readiness)

- **Process & Shell Safety**:
  - Replaced all raw `shell=True` subprocess calls with direct Linux API lookups (e.g. `/proc/uptime`, `/proc/stat`) or safe parameter arrays with `start_new_session=True`.
  - Replaced pipe subprocesses in bandwidth testers with in-memory byte buffers to eliminate orphan pipe leaks.
- **Input Sanitization & Directory Traversal Defense**:
  - Strict key whitelisting and `os.path.basename` enforcement in audio dispatcher ([`space-quindar`](file:///home/diogo/.local/bin/space-quindar)).
  - Quote escaping and command sanitization in the Unix socket daemon ([`hyprland-ipc-bridge`](file:///home/diogo/.local/bin/hyprland-ipc-bridge)).
- **Multi-User Isolation & Privilege Safety**:
  - Dynamically resolved runtime paths and UID-scoped telemetry stat files (`space_telemetry_cpu_$UID.stat`).
  - Generalized installers ([`space-boot-install`](file:///home/diogo/.local/bin/space-boot-install), [`space-sddm-install`](file:///home/diogo/.local/bin/space-sddm-install)) to use `$SUDO_USER` passwd lookups instead of hardcoded home directories.
- **Memory & Resource Lifecycle**:
  - Full-write error handling (`write_all`) and bounds checking in C IPC daemons.
  - Safe disposal and bounded arrays across Cairo particle engines and GTK UI refresh loops.
  - Verified zero hardcoded credentials, tokens, or private secrets across all configurations.

## Related Notes
- [[Index]]
- [[TODO|Task & Feature Roadmap]]
- [[system/arch-hyprland]]
- [[configs/space-orbital-screensaver]]


