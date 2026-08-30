# 🛰️ Apollo Space Race Theme: Flight Operations Wiki

<div align="center">

```
  ____   ____   _      ____  _____  _____       ____   ___    ____  _____ 
 / ___| |  _ \ / \    / ___|| ____|| ____|     |  _ \ / _ \  / ___|| ____|
 \___ \ | |_) / _ \  | |    |  _|  |  _| _____ | |_) / /_\ \| |    |  _|  
  ___) ||  __/ ___ \ | |___ | |___ | |__|_____||  _ <|  _  || |___ | |___ 
 |____/ |_| /_/   \_\ \____||_____||_____|     |_| \_\_| |_| \____||_____|
                     FLIGHT OPERATIONS WIKI & MANUAL
```

**Official Knowledge Base, Avionics Manual, System Architecture & How-To Guide**  
*For Arch Linux, Hyprland, Waybar, and Mission Control Utilities*

</div>

---

## 🧭 Wiki Index & Table of Contents

| Chapter | Topic | Description |
| :--- | :--- | :--- |
| **🎨 [01. Architecture & Design](01-architecture-and-design.md)** | Core Architecture | 4 Mission Profiles, Color Tokens, Quindar Sound Engine, Zero-White Mandate |
| **🛠️ [02. Flight Instruments Manual](02-flight-instruments-and-tools.md)** | Avionics & Dialogs | Comprehensive manual for all 12 GUI dialogs, sub-tabs & keybindings |
| **⚡ [03. EECOM Vitals & Maintenance](03-eecom-and-system-maintenance.md)** | Health & Remediation | Health scoring algorithm, SSD TRIM, orphan cleanup, .pacnew wizard & AI Director |
| **🔌 [04. Plugin System & Updates](04-plugin-system-and-updates.md)** | Plugin Ecosystem | Plugin manager, `space-theme-update` engine & custom plugin authoring |
| **📖 [05. Operational How-To Guides](05-how-to-guides.md)** | Recipes & Workflows | How-to guides for themes, wallpapers, multi-monitors, screensavers & persistent DNS |
| **🚨 [06. Troubleshooting & Recovery](06-troubleshooting-and-recovery.md)** | Emergency Runbook | Btrfs snapshot restoration, kernel crash collector, initramfs rebuilds & IPC debug |

---

## 📸 Flight Instruments & Subtabs Visual Showcase

### 1. 🛠️ Apollo Mission Operations & Tools Console (`space-tools-dialog`)
*Hotkeys: `SUPER + SHIFT + P` / Waybar Tools button*

#### 📸 Tab 1: [C] AV & Mission Capture
![AV & Mission Capture Tab](assets/wiki_tools_capture.png)

#### 🎥 Video Screen Recorder Configuration Sub-View
![Video Screen Recorder Configuration Sub-View](assets/wiki_tools_rec.png)

#### 🛰️ Tab 2: [E] EECOM Subsystems & Health Vitals
![EECOM Subsystems & Health Vitals Tab](assets/wiki_tools_eecom.png)

#### 🛡️ Tab 3: [S] System Recovery & Snapshots
![System Recovery & Snapshots Tab](assets/wiki_tools_system.png)

#### 📡 Tab 4: [D] Multi-Monitor Display Radar
![Multi-Monitor Display Radar Tab](assets/wiki_tools_display.png)

---

### 2. 🎨 Visual Avionics & Theme Configurator (`space-theme-config`)
*Hotkeys: `SUPER + ALT + T` / Click Theme pill on Waybar*

#### 🎨 Tab 1: [T] Mission Theme Profiles (NASA / CRT-Amber / CRT-Green / Kosmos-VFD)
![Theme Selector Tab](assets/wiki_config_theme.png)

#### 🌌 Tab 2: [W] Historical Wallpaper Gallery
![Historical Wallpaper Gallery Tab](assets/wiki_config_wallpaper.png)

#### 🛸 Tab 3: [S] 8-Bit Screensaver Settings & Security Lock
![Screensaver Settings Tab](assets/wiki_config_screensaver.png)

#### 📊 Tab 4: [M] Waybar Toolbar Module Visibility
![Waybar Modules Tab](assets/wiki_config_modules.png)

#### 📦 Tab 5: [P] Plugins & Subsystems Manager
![Plugins Manager Tab](assets/wiki_config_plugins.png)

---

### 3. 📡 Communications & S-Band Wi-Fi Radar (`space-network-dialog`)
*Hotkeys: `SUPER + SHIFT + N` / Click Wi-Fi module on Waybar*

#### 📡 S-Meter Analog Receiver & Wi-Fi Station Scanner
![S-Meter Receiver & Station Scanner](assets/wiki_network_main.png)

#### ⚡ RF Propagation Comm Diagnostics & Ground DNS Relays
![RF Comm Diagnostics and DNS Relays](assets/wiki_network_test.png)

#### 🛡️ Encrypted VPN Tunnel Dispatch
![Encrypted VPN Tunnel Dispatch](assets/wiki_network_vpn.png)

#### 📶 Bluetooth Avionics Subsystem
![Bluetooth Avionics Subsystem](assets/wiki_network_bluetooth.png)

---

### 4. ⚡ Apollo EECOM Terminal Diagnostics & Remediation (`space-eecom`)
*Command: `eecom` / `space-eecom --scan` / `space-eecom --menu`*

#### 🩺 Full Diagnostic Health Scan (`eecom --scan`)
![Full Diagnostic Health Scan](assets/wiki_eecom_tui.png)

#### 🛠️ Interactive Non-AI Maintenance Menu (`eecom --menu`)
![Interactive Non-AI Maintenance Menu](assets/wiki_eecom_menu.png)

---

### 5. 🎛️ Navigation, Telemetry & Power Consoles

#### 🎛️ Apollo AGC DSKY Application Launcher (`dsky-launcher` // `SUPER + Space`)
![Apollo AGC DSKY Application Launcher](assets/wiki_dsky_launcher.png)

#### 🪟 Apollo HUD Mission Window Switcher (`space-switcher` // `ALT + TAB`)
![Apollo HUD Mission Window Switcher](assets/wiki_space_switcher.png)

#### 📊 Hardware Telemetry & Task Abort Console (`space-telemetry-dialog` // `SUPER + SHIFT + C`)
![Hardware Telemetry & Task Abort Console](assets/wiki_telemetry_dialog.png)

#### 🔋 MDC-02 Main Power Bus Telemetry (`space-energy-dialog` // `SUPER + SHIFT + E`)
![MDC-02 Main Power Bus Telemetry](assets/wiki_energy_dialog.png)

#### 🎙️ CAPCOM Audio & Radio Intercom (`space-capcom-dialog` // `SUPER + SHIFT + V`)
![CAPCOM Audio & Radio Intercom](assets/wiki_capcom_dialog.png)

#### 🛰️ ISS Real-Time Orbital Tracker (`space-iss-dialog`)
![ISS Real-Time Orbital Tracker](assets/wiki_iss_dialog.png)

#### 🧭 Keybinding Flight Directory (`space-keybinds` // `SUPER + SHIFT + K`)
![Keybinding Flight Directory](assets/wiki_keybinds.png)

#### 🚨 Emergency Flight Abort Menu (`space-power-menu` // `SUPER + SHIFT + M`)
![Emergency Flight Abort Menu](assets/wiki_power_menu.png)

---

<div align="center">
  <sub>Apollo Space Race Theme • Engineered for Arch Linux & Hyprland • Zero-White-Background Standard</sub>
</div>
