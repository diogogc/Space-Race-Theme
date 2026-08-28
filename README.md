# 🛸 Space-Race-Theme: Mission Control Desktop Environment

> **Cohesive, retro-futuristic Linux Wayland desktop environment inspired by the historic 1960s Space Race.**
> Engineered for **Hyprland**, **Waybar**, **Kitty**, **Dunst**, **Hyprlock**, and custom **Cairo/GTK** flight control telemetry dialogs with a strict **Zero-White-Background** policy.

---

## 🌌 Mission Control Profiles

The environment features four authentic retro flight-deck profiles switchable in real-time (`space-theme-switch` or DSKY key `[V]`):

| Profile | Era & Inspiration | Primary Palette | Key Characteristics |
| :--- | :--- | :--- | :--- |
| **🚀 NASA** | Apollo Houston MOCR (1969) | Amber Gold (`#ffb000`), Obsidian Chassis (`#0a0d12`) | Segmented mission elapsed time, annunciator alerts, Quindar telemetry tones. |
| **💾 CRT-Amber** | IBM System/360 Model 91 (1964) | Phosphor Amber (`#ff9e00`), Deep Carbon (`#060709`) | Zero-radius industrial mainframe terminal styling, vintage hardware aesthetics. |
| **📟 CRT-Green** | DEC VT100 / MIT AGC DSKY (1966) | Phosphor Green (`#33ff33`), Deep Forest (`#040704`) | MIT Instrumentation Lab guidance computer aesthetic with Verb/Noun prompts. |
| **🛰️ Kosmos-VFD** | Soviet Space Program / OKB-1 (1961) | Mint Phosphor (`#00f0d0`), Cosmic Crimson (`#dc1e1e`) | VFD vacuum fluorescent display styling, Cyrillic status telemetry (*ПОЕХАЛИ!*). |

---

## ✨ Features & Architecture

### 1. 🎛️ DSKY Mission Application Launcher (`dsky-launcher`)
- Apollo Display and Keyboard (DSKY) interface inspired by AGC Colossus 2A.
- Filter applications by 8 dedicated mission groups (`01 FLIGHT`, `02 COMMS`, `03 SYSTEM`, `04 ORBIT`, `05 MEDIA`, `06 NET`, `07 UTILITY`, `08 TELEMETRY`).
- Real-time Verb/Noun navigation (`VERB 37 NOUN 01`), quick search, and live theme preview.

### 2. 🕹️ 8-Bit Retro Space Multi-Scene Screensaver (`space-screensaver`)
- **Virtual Resolution**: Nearest-neighbor $480 \times 270$ retro pixel scaling.
- **5 Authentic Narrative Flight Scenes**:
  1. **Arch Linux Orbital Recon**: 3D orbital mechanics at $23^\circ$ inclination around Earth with dynamic cloud patterns and ion exhaust.
  2. **NASA Meatball Insignia**: Authentic $128 \times 128$ pixel art matrix matching the official NASA emblem with animated stars.
  3. **Apollo 11 Moon Landing**: Gliding descent, AGC 1202/1201 alarms, touchdown, astronaut egress, same-side walk, flag planting & salute, walkback ingress, and two-stage ascent liftoff (upright vertical climb $\to$ gravity turn to orbit).
  4. **Soviet Interkosmos Emblem**: $128 \times 128$ pixel art matrix with Red Star, Hammer & Sickle, Sputnik orbit loop, and golden wheat wreath.
  5. **Vostok 1 Yuri Gagarin Mission**: 6-phase historic simulation of the first human spaceflight (Baikonur liftoff, atmospheric ascent $\to$ orbit, Earth horizon observation, retrograde TDU-1 re-entry, $7\text{ km}$ ejection & dual parachutes, Volga meadow touchdown & recovery).
- **Idle Daemon (`space-idle-daemon`)**: Lightweight native Wayland idle monitor using `ext-idle-notify-v1` with configurable timeout and lockscreen triggers.

### 3. 📡 Live Mission Control Telemetry Dialogs
- **Comms & Network Dispatcher (`space-network-dialog`)**: Real-time Wi-Fi/Ethernet telemetry, in-memory bandwidth tester, radio silence mode, and flight logs.
- **Power & Abort Systems (`space-power-menu` / `space-energy-dialog`)**: ACPI power telemetry, battery discharge graphs, thermal matrix, and emergency flight abort controls (`SUPER + SHIFT + M`).
- **Audio Routing & Quindar Beeps (`space-capcom-dialog` / `space-quindar`)**: Volume dispatch, WirePlumber device switching, and authentic 2524 Hz Apollo test tones.
- **ISS Orbital Tracker (`space-iss-dialog`)**: Real-time coordinates, crew complement, and ground pass telemetry for the International Space Station.

---

## ⌨️ Keybinding Cheatsheet

| Keybinding | Action / Command | Description |
| :--- | :--- | :--- |
| `SUPER + Space` | `dsky-launcher` | Apollo DSKY Mission Application Launcher |
| `SUPER + V` | `space-theme-switch` | Flight Theme Selector Modal |
| `SUPER + SHIFT + O` | `space-screensaver` | 8-Bit Retro Multi-Scene Screensaver |
| `SUPER + SHIFT + P` | `space-screensaver-config` | Screensaver & Lockscreen Settings |
| `SUPER + SHIFT + M` | `space-power-menu` | Emergency Flight Operations / Abort Menu |
| `SUPER + L` | `hyprlock` | DSKY PASSCODE Secure Lockscreen |
| `SUPER + Return` | `kitty` | Space Mission Terminal |
| `SUPER + Q` | `killactive` | Close Active Flight Window |

---

## 🚀 Installation & Setup

### Prerequisites (Arch Linux)
```bash
sudo pacman -S hyprland waybar kitty dunst hyprlock hyprpaper fastfetch                python-gobject python-cairo gtk3 wayland-protocols base-devel
```

### Installation Options

#### 1. Live Workspace Symlink (Recommended for Developers)
```bash
git clone https://github.com/diogogc/Space-Race-Theme.git ~/Space-Race-Theme
cd ~/Space-Race-Theme
./install.sh --link
```

#### 2. Full Static Install
```bash
git clone https://github.com/diogogc/Space-Race-Theme.git
cd Space-Race-Theme
./install.sh
```

---

## 🔒 Security & Quality Standards
- **Zero-White-Background Policy**: Complete elimination of light flashes and white backgrounds across all dialogs, popups, and windows.
- **Subprocess & IPC Hardening**: Direct `/proc` and Unix socket interfaces with sanitized inputs and memory bounds checking.
- **High-DPI & Scaling**: Cairo pixel rendering engine with crisp nearest-neighbor integer scaling.

---

## 📄 License
Released under the [MIT License](LICENSE).
