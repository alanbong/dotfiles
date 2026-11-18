# Dotfiles & Arch Linux Setup

Automated post-install script and personal dotfiles for **Arch Linux** supporting **KDE Plasma**, **Hyprland** (with **Noctalia** shell), and multi-GPU hardware profiles (Intel, AMD, Nvidia) managed via the **ly** display manager.

## Quick Start

### Arch ISO Wi-Fi Setup (Before Archinstall)


```bash
rfkill unblock wifi
iwctl
# Inside iwctl:
#   device list
#   station <INTERFACE> scan
#   station <INTERFACE> get-networks
#   station <INTERFACE> connect <SSID>
#   exit
```

### Verify Internet Access, Sync Clock and updat archinstall

```bash
ping -c 3 archlinux.org
timedatectl set-ntp true
timedatectl status
pacman -Sy --noconfirm archlinux-keyring archinstall
archinstall
```

## Before Running install.sh

```bash
sudo pacman -S --needed git
git clone <YOUR_REPO_URL> ~/dotfiles
cd ~/dotfiles
chmod +x ./install.sh
sudo ./install.sh
```

## Installer Prompt Flow (What You Will Be Asked)

The installer asks only three short questions:

GPU Drivers (space-separated, default: 1 2):

1. Intel
2. AMD
3. Nvidia

Desktop Environment (space-separated, default: 1 2):

1. KDE Plasma
2. Hyprland (with Noctalia shell)

## What Each Profile Installs & Configures

### Base Stack (Installed Always)

- Display Manager & Graphics: ly (TUI session switcher), mesa, lib32-mesa

- Shell & Terminal: fish, starship, kitty, fastfetch

- Core Apps: dolphin, kio-extras, ffmpegthumbs, archlinux-xdg-menu, ark, gwenview, kwrite, kcalc

- Audio & Bluetooth: pipewire, wireplumber, pipewire-pulse, pipewire-alsa, pavucontrol, playerctl, bluez, bluez-utils

- Gaming & Compatibility: steam, protonplus, wine, winetricks, protontricks

- Browsers & Media: firefox, google-chrome (via Chaotic-AUR), vlc, vlc-plugins-all

- Build & Archive Tools: base-devel, yay, go, 7zip, unzip, unrar, ntfs-3g, dosfstools, exfatprogs

### GPU Profiles

- Intel (1): 
  - vulkan-intel, lib32-vulkan-intel, intel-media-driver
- AMD (2):
  - vulkan-radeon, lib32-vulkan-radeon
- Nvidia (3):
  - nvidia-open-dkms, nvidia-utils, lib32-nvidia-utils, egl-wayland, libva-nvidia-driver
  - Writes options nvidia_drm modeset=1 fbdev=1 to /etc/modprobe.d/nvidia.conf.
  - Adds early KMS modules (nvidia nvidia_modeset nvidia_uvm nvidia_drm) to /etc/mkinitcpio.conf and rebuilds initramfs via mkinitcpio -P.
  - Enables enable_nvidia_optional = true in ~/.config/hypr/startup.lua (if Hyprland is selected).

(Note: Hybrid setups such as Intel iGPU + AMD eGPU use 1 2; AMD iGPU + Nvidia dGPU use 2 3.)

### Desktop Environment Profiles

- KDE Plasma (1):
  - Installs plasma-meta and xdg-desktop-portal-kde.
  - Deploys only shared terminal/shell configs (fish, starship.toml, kitty, fastfetch), keeping KDE's native GTK/Qt styling untouched.
- Hyprland (2):
  - Installs hyprland, noctalia, matugen, hyprlock, hypridle, wlsunset, grim, slurp, nwg-look, nwg-displays, qt6ct, adw-gtk-theme, polkit-kde-agent, gnome-keyring, and Wayland XDG portals.
  - Deploys all dotfiles (hypr, noctalia, gtk-3.0, gtk-4.0, fish, kitty, fastfetch, starship.toml) and sets executable permissions on ~/.config/hypr/Scripts.

- Both (1 2):
  - Installs both environments and deploys the full dotfile set; switch between KDE Plasma and Hyprland directly from ly on login.

### System Changes Summary

- /etc/pacman.conf — enables [multilib] and adds [chaotic-aur] (backup saved at /etc/pacman.conf.bak).
- /etc/modprobe.d/nvidia.conf & /etc/mkinitcpio.conf — configured if Nvidia (3) is selected.
- ~/.config/ — deploys selected dotfiles and sets org.kde.dolphin.desktop as the default file manager via xdg-mime.
- Systemd services enabled: ly@tty2.service (or ly.service), bluetooth, and power-profiles-daemon.

### Post-Install Verification Checklist
After rebooting and logging in via ly:
```bash
systemctl status bluetooth power-profiles-daemon
vulkaninfo --summary | grep -E "GPU|deviceName"
```
### Optional commands
For auto cleanup packman cache once per week (by default)
```bash
sudo systemctl enable --now paccache.timer
```

