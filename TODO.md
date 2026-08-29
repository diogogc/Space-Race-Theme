# 📋 Space Race Theme: Flight Deck Roadmap & Tasks

## 🚀 Upcoming Releases & Packaging (Backlog)

- [ ] **Arch User Repository (AUR) Package**:
  - [ ] Write `PKGBUILD` for `space-race-theme-git`.
  - [ ] Generate `.SRCINFO` with dependencies (`hyprland`, `waybar`, `ghostty`, `python-cairo`, `python-gobject`, `gtk3`).
  - [ ] Register and publish `space-race-theme-git` to `aur.archlinux.org`.
  - [ ] Test clean `makepkg -si` build in a clean chroot.
- [ ] **Nix Flake & NixOS Module**:
  - [ ] Package standalone derivation for NixOS / home-manager users.
- [ ] **Wayland Idle & Dynamic Power Saver Extensions**:
  - [ ] Integrate automatic screen brightness dimming before screensaver triggers.
- [ ] **Additional Mission Profiles**:
  - [ ] *Gemini IV Space Walk* (Monochrome Cyan & Electric Blue).
  - [ ] *Pioneer 10 Deep Space* (Retro Infrared & Vector Starcharts).

---

## ✅ Completed Flight Milestones

### v1.1.0 (Flight Operations & Phosphor Cursors)
- [x] Horizontal workspace slide kinematics (`slide` @ `easeOutQuint`).
- [x] Dynamic Fastfetch ASCII art profiles (Saturn V, IBM 360, MIT AGC DSKY, Vostok-1).
- [x] Discrete 44.1 kHz PCM audio suite with Quindar beeps, shutter clicks, and relay latch tones.
- [x] Retro phosphor Wayland cursor suites (`Space-Retro-Amber`, `Space-Retro-Green`, `Space-Retro-Mint`).
- [x] Apollo HUD Window Switcher (`space-switcher`).
- [x] Multi-Monitor Display Radar Console (`space-display`).
- [x] MDC-02 Main Power Bus & Energy Telemetry (`space-energy-dialog`).
- [x] Full visual showcase README and public GitHub release.

### v1.0.0 (Initial Mission Control Launch)
- [x] Apollo AGC DSKY Colossus 2A Application Launcher (`dsky-launcher`).
- [x] 8-Bit Retro Space Screensaver with 5 narrative flight scenes.
- [x] Core 4 mission profiles (NASA, CRT-Amber, CRT-Green, Kosmos-VFD).
- [x] Strict Zero-White-Background policy across all GTK3/Cairo consoles.
