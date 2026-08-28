---
title: "8-Bit Arch Spacecraft Orbital Screensaver"
date: 2026-08-27
last_modified: 2026-08-27
tags:
  - system
  - config
  - screensaver
  - hyprland
  - theme
  - pixel-art
status: active
aliases:
  - "Space Screensaver"
  - "Arch Orbital Screensaver"
---

# 8-Bit Arch Spacecraft Orbital Screensaver

> [!NOTE]
> Custom retro 8-bit pixel-art screensaver displaying the Arch Linux chevron spacecraft orbiting an Earth-like planet at an authentic 23.0° inclination with depth occlusion, nearest-neighbor upscaling, and instant input-wake triggers.

## Context & Purpose
The space mission control theme includes an 8-bit screensaver featuring the Arch Linux logo stylized as an orbital reconnaissance spacecraft orbiting an Earth-like planet with dynamic atmospheric lighting, ion engine particle trails, and orbital perspective scaling.

## Key Files & Locations
- **Screensaver Executable**: [`~/.local/bin/space-screensaver`](file:///home/diogo/.local/bin/space-screensaver)
- **Configuration Utility**: [`~/.local/bin/space-screensaver-config`](file:///home/diogo/.local/bin/space-screensaver-config)
- **Idle Daemon Service**: [`~/.local/bin/space-idle-daemon`](file:///home/diogo/.local/bin/space-idle-daemon)
- **Configuration File**: `~/.config/space-screensaver/config.json`
- **Desktop Entries (DSKY Group: 07 UTILITY)**:
  - Screensaver: [`~/.local/share/applications/space-screensaver.desktop`](file:///home/diogo/.local/share/applications/space-screensaver.desktop)
  - Configuration Utility: [`~/.local/share/applications/space-screensaver-config.desktop`](file:///home/diogo/.local/share/applications/space-screensaver-config.desktop)
- **Hyprland Keybinding**: `SUPER + SHIFT + O` in [`~/.config/hypr/hyprland.lua`](file:///home/diogo/.config/hypr/hyprland.lua)
- **Hyprland Window Rules**: `space-screensaver-fullscreen` and `space-screensaver-config-float` in [`~/.config/hypr/hyprland.lua`](file:///home/diogo/.config/hypr/hyprland.lua)

## Multi-Scene Architecture & Transitions
1. **Scene 1: Arch Linux Orbital Recon**:
   - Arch chevron spacecraft in official colors (`#1793d1` / `#33aadd`) orbiting an Earth-like planet with FBM swirling clouds at an authentic 23.0° CCW inclination.
2. **Scene 2: Authentic 2D Pixel-Art NASA Meatball Insignia**:
   - Exact $128 \times 128$ pixel art matrix matching the official Reddit 8-bit NASA Meatball design.
   - **Solid NASA Blue Disc (`#2d5caa`)**: Crisp flat circle.
   - **Authentic Star Constellations & Twinkling**: Exact 2D white pixel star clusters.
   - **Supersonic Red Vector (`#e62b14`)**: Authentic 2D red chevron wing sweeping across the disc.
   - **White Orbit Ellipse & Satellite Track**: Exact 2D pixel ellipse looping across the emblem.
   - **Classic Slab-Serif "NASA" Typography**: Iconic 2D pixel serif lettering across the center.
3. **Scene 3: Classic 1979 Atari Lunar Lander & Apollo 11 Mission**:
   - **Gliding Entry & Deceleration Burn**: Lander glides in across the lunar plain from left to right, pitches back ~18° with main engine braking, decelerates smoothly over the pad, and softly touches down.
   - **Apollo 11 1202 & 1201 Program Alarms**: Simulated DSKY AGC alarm triggers with flashing amber/yellow HUD indicators and Mission Control voice status (`"1202 IS GO FOR LANDING"` / `"GO ON THAT ALARM"`).
   - **Touchdown & Contact Light**: Settles smoothly onto the natural lunar plain with dust cloud and contact light activation.
   - **Astronaut EVA & Flag Ceremony**: Both 8-bit astronauts egress from the ladder and walk to the same side (right) toward the deployment site. When together, the American Flag is erected and both astronauts render a standing salute.
   - **Crew Ingress & Return to Cabin**: Both astronauts turn around (facing left), moonwalk back across the surface to the lander ladder, and climb back inside the cabin before liftoff.
   - **Two-Stage Ascent Liftoff**: Lower gold descent stage remains on the lunar surface as a permanent monument; upper Ascent Stage ignites, climbs straight upright, then inclines/pitches to the right and accelerates with lateral velocity into lunar orbit rendezvous with CSM Columbia!
   - **Vintage Arcade Telemetry & Radio Transcripts**: Real-time altitude, speeds, fuel, and Apollo 11 historical voice lines.
4. **Scene 4: Authentic 2D Pixel-Art Soviet Space Program & Interkosmos Insignia**:
   - Exact $128 \times 128$ pixel art matrix matching the classic Soviet Space Program / Interkosmos emblem.
   - **Soviet Crimson Red Star (`#dc1e1e`)**: Geometric 5-pointed star with gold border and Hammer & Sickle emblem.
   - **Golden Wheat Wreath & Laurel Frame (`#f5c72e`)**: Embossed emblem medal rim.
   - **Earth Horizon & Cyan Atmosphere Glow (`#33e6c0`)**: Curved planetary limb with VFD phosphor glow.
   - **Ascending R-7 / Vostok Rocket & Flame Arc**: Soaring launch vehicle with animated pulsing orange thrust.
   - **White Orbit Ellipse & Sputnik Satellite**: Looping orbital trajectory with 4-antenna Sputnik satellite.
   - **Bold Cyrillic "С С С Р" Typography**: Centered white lettering inside lower crimson ribbon.
   - **Vintage VFD Cyrillic Telemetry HUD**: Live Soviet Space Program status headers (*"ПРОГРАММА: ИНТЕРКОСМОС // ПОЕХАЛИ!"*).
5. **Scene 5: Vostok 1 Yuri Gagarin Mission (April 12, 1961)**:
   - Complete 6-phase narrative recreating the first human spaceflight in the style of Scene 3 (Apollo Lunar Lander):
     - **0.0–6.0s (Baikonur Liftoff)**: Baikonur Site No. 1 launch pad, retracting gantry arms, flame trench deflector smoke, engine blast particles, and iconic radio transcripts (*"ПОЕХАЛИ!"*).
     - **6.0–18.0s (Seamless Atmospheric Ascent to Orbit)**: Realistic multi-tier atmospheric climb where the sky smoothly transitions from daylight cyan $\to$ stratospheric indigo $\to$ vacuum starry black, while the Earth horizon dynamically scales from a flat horizon below into the curved orbital limb. Includes upper-atmosphere 4-booster *Korolev Cross* staging ($T+118\text{s}$), Blok-E ignition, and payload fairing jettison revealing the Vostok-1 craft.
     - **18.0–26.0s (Earth Orbit Observation)**: Vostok 1 spherical descent module (*Shararik*) + biconical instrument module gliding smoothly over curved Earth limb with high-detail procedural coastlines (Eurasia, Mediterranean, Urals, Siberia) and calibrated delicate cloud vortices (~22% cover) allowing rich continents to shine through (*"Я вижу Землю! Она так прекрасна!"*).
     - **26.0–33.0s (Retro-Fire & Hypersonic Re-entry Wake)**: TDU-1 retro braking burn ($-155\text{ m/s}$), service module separation, and authentic **retrograde re-entry** with the blunt ablative heat shield base facing directly forward into oncoming airflow, featuring a detached bow-shock compression layer, dual shoulder aerodynamic boundary streamers, and dynamic ablative burning spark flecks shedding into the wake vortex.
     - **33.0–40.0s (High-Altitude Ejection & Dual Parachutes)**: Capsule hatch ejection at $7\text{ km}$; dual parachute descent through daylight troposphere with tiered, shaded 8-bit cumulus clouds featuring the capsule's orange/white striped canopy and Cosmonaut Gagarin's personal white parachute in orange SK-1 suit and CCCP helmet.
     - **40.0–48.0s (Saratov Field Touchdown & Recovery)**: Scorched capsule resting in the Volga meadow, Gagarin standing and rendering a crisp military victory salute, 2 Soviet recovery ground personnel in olive uniform running to meet him, Soviet command Gaz-69 vehicle parked on the hill with red standard, and an approaching Mil Mi-4 helicopter with animated rotor disk, braking flare, downwash grass particles, and navigation strobe lights.
6. **Transition Engine (Fade-In / Fade-Out)**:
   - Automatically cycles across scenes every **2 minutes** (120s) with smooth black fade.
   - **Smooth Black Fade**: Seamless fade-out to black ($\alpha: 1.0 \to 0.0$) followed by a smooth fade-in to the next mission scene ($\alpha: 0.0 \to 1.0$).
   - **Instant Cycle Keybinds**: Press `[TAB]`, `[SPACE]`, or `[N]` to trigger the fade transition immediately for testing.
5. **Configuration Utility & Zero-White-Background Architecture**:
   - **DSKY Segmented Option Chips**: Bypasses system GTK light dropdowns by utilizing native monospace segmented selector chips for idle timeout, password lock on wake, and mission scene rotation.
   - **Zero-White-Background Policy Enforcement**: Complete chassis, panels, cards, and buttons use deep space chassis (`#0a0d12`) and theme accents (`#ffb000` NASA / `#ff9e00` CRT Amber / `#33ff33` CRT Green / `#00f0d0` Kosmos VFD).
   - **Keyboard Navigation**: Pressing **`[ESC]`** or **`[Q]`** immediately closes the configuration dialog; pressing **`[ENTER]`** applies and saves settings.
6. **Input Handling & Wake**:
   - Any key (`[ESC]`, `[Q]`, `[ENTER]`) or mouse movement exits the screensaver immediately.

## Troubleshooting & Geometry Calibration
- **Issue (Occlusion Intersect)**: Initial orbit ellipse semi-minor axis ($b = 64.5\text{px}$) was larger than the planet radius ($r = 52\text{px}$), causing the back arc of the orbit to pass above the top limb rather than behind the globe.
- **Resolution**: Scaled the planetary radius to $62\text{px}$ and tuned the orbital semi-major axis to $115\text{px}$ with a $12^\circ$ orbital perspective pitch. Now $\approx 25\%$ of the orbit trajectory ($58^\circ \le \theta \le 122^\circ$) directly intersects and passes completely behind the Earth disk with full depth masking and thruster trail occlusion.
- **Issue (Background Animation Desync on Scene Transition)**: Scenes were receiving global application uptime rather than active per-scene playback time, causing narrative scenes (like the Lunar Lander descent and liftoff) to start mid-sequence when switching scenes.
- **Resolution**: Implemented per-scene lifecycle management with `on_enter()` resets and localized `t_cur = max(0.0, now - self.scene_start_time)` playback clocks so each narrative mission starts cleanly from $t = 0.0$ upon transition.
- **Issue (Light Popup Menus in GTK Configuration Dialog)**: Default GTK ComboBox menus inherited system Adwaita white popups.
- **Resolution**: Replaced GTK ComboBoxes with custom DSKY segmented chip selectors and toggle buttons built directly into the dark chassis, eliminating all light-themed popups and ensuring 100% adherence to the zero-white-background policy.
- **Issue (Screensaver Instant Dismiss on Wayland Fullscreen Map)**: When `space-screensaver` launched, GTK initially mapped the window at default geometry before Hyprland transitioned it to fullscreen ($1366 \times 768$). The pointer motion event from the geometry jump was registered as movement, exceeding the $30\text{px}$ delta threshold and immediately closing the screensaver in $<20\text{ms}$.
- **Resolution**: Added a $1.2\text{s}$ window map grace period during which the baseline reference pointer position is continuously refreshed until geometry settles, preventing false-positive motion triggers.
- **Issue (Idle Daemon Signalling and Signal Handling)**:
  1. `pkill -x space-idle-daemon` failed because Linux kernel `comm` truncates to 15 characters (`space-idle-daem`), preventing `SIGUSR1` reload signals from reaching the daemon.
  2. `wl_display_dispatch()` returned $-1$ on `EINTR` when signals arrived, causing the daemon loop to break and terminate prematurely.
  3. `signal(SIGCHLD, SIG_IGN)` broke `waitpid()` tracking in the monitor thread.
- **Resolution**: Updated `space-screensaver-config` to use `killall -USR1 space-idle-daemon`, added `EINTR` loop continuation and proper `SIGCHLD` `sigaction` reaping in `space-idle-daemon.c`, and recompiled the binary.

## Related Notes
- [[Index]]
- [[configs/space-mission-themes|Space Mission Themes]]
- [[configs/dsky-app-launcher|DSKY App Launcher]]
