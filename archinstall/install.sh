#!/bin/bash

export LC_MESSAGES=C
export LANG=C

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

# 1. System and user checks
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

if [ ! -f /etc/pacman.conf ]; then
    echo "File [/etc/pacman.conf] not found!"
    exit 1
fi

if [ -n "$SUDO_USER" ] && [ "$SUDO_USER" != "root" ]; then
    ACTUAL_USER="$SUDO_USER"
else
    ACTUAL_USER=$(logname 2>/dev/null)
fi

if [ -z "$ACTUAL_USER" ] || [ "$ACTUAL_USER" = "root" ]; then
    echo "ERROR: Could not determine a non-root target user. Run this script with sudo from your normal user account."
    exit 1
fi

ACTUAL_USER_HOME=$(getent passwd "$ACTUAL_USER" | cut -d: -f6)
if [ -z "$ACTUAL_USER_HOME" ] || [ ! -d "$ACTUAL_USER_HOME" ]; then
    echo "ERROR: Home directory for '$ACTUAL_USER' not found."
    exit 1
fi

REPO_DIR="$SCRIPT_DIR"
CONFIG_DIR="$ACTUAL_USER_HOME/.config"

if [ ! -d "$REPO_DIR/.config" ]; then
    echo "ERROR: '$REPO_DIR/.config' not found."
    exit 1
fi

# 2. Interactive selections (space-separated)
INSTALL_INTEL=0
INSTALL_AMD=0
INSTALL_NVIDIA=0
echo "GPU drivers: 1) Intel  2) AMD  3) Nvidia"
read -r -p "Enter choices separated by space (e.g. '1 2') [1 2]: " gpu_choices
for c in ${gpu_choices:-1 2}; do
    case "$c" in
        1) INSTALL_INTEL=1 ;;
        2) INSTALL_AMD=1 ;;
        3) INSTALL_NVIDIA=1 ;;
        *) echo "Invalid GPU choice: '$c'. Aborting."; exit 1 ;;
    esac
done

INSTALL_KDE=0
INSTALL_HYPRLAND=0
echo ""
echo "Desktop Environment: 1) KDE Plasma  2) Hyprland"
read -r -p "Enter choices separated by space (e.g. '1 2') [1 2]: " de_choices
for c in ${de_choices:-1 2}; do
    case "$c" in
        1) INSTALL_KDE=1 ;;
        2) INSTALL_HYPRLAND=1 ;;
        *) echo "Invalid DE choice: '$c'. Aborting."; exit 1 ;;
    esac
done

# 3. Package list
PACKAGES=(
    # Display manager & base graphics
    ly                          # Lightweight TUI display manager (session switcher)
    mesa                        # Open-source OpenGL/Vulkan graphics stack
    lib32-mesa                  # 32-bit Mesa libraries (required for Steam and 32-bit games)

    # System services & utilities
    xdg-user-dirs               # Creates standard user folders (Documents, Downloads, etc.)
    power-profiles-daemon       # D-Bus service for switching CPU/system power profiles
    upower                      # Battery status and power management daemon
    pavucontrol                 # GUI volume mixer and audio device switcher
    playerctl                   # CLI media player controller (MPRIS protocol)
    unrar                       # RAR archive extraction utility
    unzip                       # ZIP archive extraction utility
    7zip                        # 7z archive manager and extractor
    ntfs-3g                     # NTFS filesystem userspace driver and utilities
    dosfstools                  # FAT12/FAT16/FAT32 filesystem utilities
    exfatprogs                  # exFAT filesystem utilities

    # Shell & terminal
    fish                        # Friendly interactive shell
    starship                    # Fast, customizable cross-shell prompt
    kitty                       # GPU-accelerated Wayland terminal emulator
    kitty-shell-integration     # Shell integration scripts for Kitty
    kitty-terminfo              # Terminfo database entries for Kitty
    fastfetch                   # Fast CLI system information tool

    # AUR & build tools
    base-devel                  # Core build tools for compiling packages (makepkg, gcc, make)
    yay                         # AUR helper written in Go
    go                          # Go compiler (dependency for building yay/Go AUR packages)

    # Core GUI applications
    dolphin                     # KDE file manager
    kio-extras                  # Additional KIO protocols (MTP, SMB, SFTP, file thumbnails)
    ffmpegthumbs                # Video thumbnail generator for Dolphin
    archlinux-xdg-menu          # XDG application menu definitions (fixes "Open With" in Dolphin)
    ark                         # KDE archive manager GUI
    gwenview                    # KDE image viewer
    kwrite                      # Lightweight KDE text editor
    kcalc                       # KDE calculator

    # Audio stack
    pipewire                    # Low-latency audio/video router and server
    wireplumber                 # Session and policy manager for PipeWire
    pipewire-pulse              # PulseAudio compatibility layer for PipeWire
    pipewire-alsa               # ALSA routing configuration for PipeWire

    # Gaming & compatibility
    steam                       # Valve digital distribution platform and Proton runner
    protonplus                  # GUI manager for Proton-GE and compatibility tools
    wine                        # Compatibility layer for running Windows applications
    winetricks                  # Helper script for installing Windows runtimes in Wine
    protontricks                # Winetricks wrapper for Steam Proton prefixes

    # Media player
    vlc                         # Cross-platform media player
    vlc-plugins-all             # Full set of audio/video codecs and plugins for VLC

    # Bluetooth
    bluez                       # Official Linux Bluetooth protocol stack
    bluez-utils                 # CLI utilities for Bluetooth management (bluetoothctl)

    # Browsers
    firefox                     # Mozilla Firefox web browser
    google-chrome               # Google Chrome web browser (from Chaotic-AUR)

    # Shared icons, cursors & fonts
    bibata-cursor-theme         # Material-based XCursor theme
    papirus-icon-theme          # Papirus icon theme
    papirus-folders             # CLI tool to change Papirus folder colors
    noto-fonts-emoji            # Google Noto color emoji font
    ttf-dejavu                  # DejaVu TrueType font family
    ttf-symbola                 # Unicode symbol font for missing glyphs and icons
)

if [ "$INSTALL_INTEL" -eq 1 ]; then
    PACKAGES+=(
        vulkan-intel            # Open-source Vulkan driver for Intel GPUs
        lib32-vulkan-intel      # 32-bit Intel Vulkan driver (for Steam/Proton)
        intel-media-driver      # Hardware video acceleration (VA-API) for Intel Broadwell+
    )
fi

if [ "$INSTALL_AMD" -eq 1 ]; then
    PACKAGES+=(
        vulkan-radeon           # Open-source RADV Vulkan driver for AMD GPUs
        lib32-vulkan-radeon     # 32-bit AMD Vulkan driver (for Steam/Proton)
    )
fi

if [ "$INSTALL_NVIDIA" -eq 1 ]; then
    PACKAGES+=(
        nvidia-open-dkms        # Open-source kernel modules for Nvidia (RTX 20-series and newer)
        nvidia-utils            # Nvidia userspace drivers, OpenGL/Vulkan libraries, nvidia-smi
        lib32-nvidia-utils      # 32-bit Nvidia libraries (for Steam/Proton)
        egl-wayland             # Wayland external platform library for Nvidia EGL streams
        libva-nvidia-driver     # VA-API hardware video decoding wrapper using NVDEC
    )
fi

if [ "$INSTALL_KDE" -eq 1 ]; then
    PACKAGES+=(
        plasma-meta             # Core KDE Plasma desktop environment meta-package
        xdg-desktop-portal-kde  # Native KDE file dialogs, screen sharing, and portals
    )
fi

if [ "$INSTALL_HYPRLAND" -eq 1 ]; then
    PACKAGES+=(
        hyprland                    # Dynamic tiling Wayland compositor
        hyprland-protocols          # Wayland protocol extensions for Hyprland
        xdg-desktop-portal-hyprland # Screen capture (OBS/Discord) and system portals for Hyprland
        xdg-desktop-portal-gtk      # GTK file chooser dialogs and theme portal backend
        polkit-kde-agent            # GUI authentication agent for privilege escalation prompts
        gnome-keyring               # Secret service daemon for storing passwords and tokens
        noctalia                    # Desktop shell built on Quickshell (bar, launcher, widgets)
        matugen                     # Material You color palette generator from wallpapers
        stb                         # Single-file public domain libraries (Noctalia dependency)
        imagemagick                 # CLI image manipulation and wallpaper processing
        qt6-base                    # Core Qt6 framework libraries (used by Quickshell/Noctalia)
        qt6-websockets              # Qt6 WebSocket module (used by Noctalia widgets)
        hyprlock                    # GPU-accelerated Wayland screen locker for Hyprland
        hypridle                    # Idle management daemon (auto-lock / DPMS screen off)
        wlsunset                    # Day/night gamma adjustment (blue light filter) for Wayland
        grim                        # Wayland screenshot capture utility
        slurp                       # Interactive screen region selection tool for Wayland
        nwg-look                    # GTK3/GTK4 theme, icon, and cursor configurator
        nwg-displays                # GUI monitor layout, refresh rate, and scaling configurator
        qt6ct                       # Qt6 application style/theme configurator outside KDE
        adw-gtk-theme               # Libadwaita port theme for consistent GTK3 styling
    )
fi

# --- 4. Functions ---

ensure_user_home_permissions() {
    sudo -u "$ACTUAL_USER" mkdir -p \
        "$ACTUAL_USER_HOME/.config" \
        "$ACTUAL_USER_HOME/.local/share" \
        "$ACTUAL_USER_HOME/.local/state"

    chown -R "$ACTUAL_USER:$ACTUAL_USER" \
        "$ACTUAL_USER_HOME/.config" \
        "$ACTUAL_USER_HOME/.local"
    chown "$ACTUAL_USER:$ACTUAL_USER" "$ACTUAL_USER_HOME"
}

setup_chaotic_aur() {
    if grep -Eq '^[[:space:]]*#[[:space:]]*\[multilib\]' /etc/pacman.conf; then
        sed -i '/^[[:space:]]*#[[:space:]]*\[multilib\]/,/^[[:space:]]*#[[:space:]]*Include/ s/^[[:space:]]*#[[:space:]]*//' /etc/pacman.conf
    fi

    if ! grep -q '^DisableDownloadTimeout' /etc/pacman.conf; then
        sed -i '/^\[options\]/a DisableDownloadTimeout' /etc/pacman.conf
    fi

    if ! grep -q '^\[chaotic-aur\]' /etc/pacman.conf; then
        cp -n /etc/pacman.conf /etc/pacman.conf.bak

        pacman -Sy --noconfirm --needed reflector pacman-contrib || return 1

        cp -n /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
        reflector --protocol https --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

        pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || return 1
        pacman-key --lsign-key 3056513887B78AEB || return 1

        pacman -U --noconfirm \
            'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
            'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' || return 1

        if [ -f /etc/pacman.d/chaotic-mirrorlist ]; then
            cp -n /etc/pacman.d/chaotic-mirrorlist /etc/pacman.d/chaotic-mirrorlist.bak
            rankmirrors -n 5 /etc/pacman.d/chaotic-mirrorlist.bak > /etc/pacman.d/chaotic-mirrorlist
        fi

        printf '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n' >> /etc/pacman.conf
    fi
}


deploy_configs() {
    local config_source="$REPO_DIR/.config"
    local backup_ts
    local item name target

    if [ ! -d "$config_source" ]; then
        echo "Error: '$config_source' not found."
        return 1
    fi

    sudo -u "$ACTUAL_USER" mkdir -p "$CONFIG_DIR"
    backup_ts=$(date +%s)

    for item in "$config_source"/*; do
        name=$(basename "$item")

        # Skip Hyprland/Noctalia/GTK overrides if Hyprland was not selected
        if [ "$INSTALL_HYPRLAND" -eq 0 ]; then
            case "$name" in
                hypr|noctalia|gtk-3.0|gtk-4.0)
                    continue
                    ;;
            esac
        fi

        target="$CONFIG_DIR/$name"

        if [ -e "$target" ] && [ ! -L "$target" ]; then
            mv "$target" "$target.bak.$backup_ts"
        fi

        cp -rf "$item" "$target"
    done

    chown -R "$ACTUAL_USER:$ACTUAL_USER" "$CONFIG_DIR"
    echo "Configuration files deployed."
}

set_permissions() {
    if [ "$INSTALL_HYPRLAND" -ne 1 ]; then
        return 0
    fi

    local scripts_path="$ACTUAL_USER_HOME/.config/hypr/Scripts"
    if [ -d "$scripts_path" ]; then
        find "$scripts_path" -type f -exec chmod +x {} +
    fi
}

set_default_file_manager() {
    sudo -u "$ACTUAL_USER" mkdir -p "$CONFIG_DIR"
    sudo -u "$ACTUAL_USER" xdg-mime default org.kde.dolphin.desktop inode/directory application/x-gnome-saved-search
}

configure_nvidia() {
    if [ "$INSTALL_NVIDIA" -ne 1 ]; then
        return 0
    fi

    echo "Configuring Nvidia DRM KMS and early module loading..."
    mkdir -p /etc/modprobe.d
    printf 'options nvidia_drm modeset=1 fbdev=1\n' > /etc/modprobe.d/nvidia.conf

    if [ -f /etc/mkinitcpio.conf ] && ! grep -Eq '^MODULES=.*nvidia_drm' /etc/mkinitcpio.conf; then
        cp -n /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
        sed -i -E 's/^MODULES=\(([^)]*)\)/MODULES=(\1 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
        sed -i -E 's/^MODULES=\([[:space:]]+/MODULES=(/' /etc/mkinitcpio.conf
        mkinitcpio -P
    fi

    if [ "$INSTALL_HYPRLAND" -eq 1 ]; then
        local startup_file="$ACTUAL_USER_HOME/.config/hypr/startup.lua"
        if [ -f "$startup_file" ] && grep -qF 'local enable_nvidia_optional = false' "$startup_file"; then
            sed -i 's|^local enable_nvidia_optional = false$|local enable_nvidia_optional = true|' "$startup_file"
        fi
    fi
}

# --- 5. Main Installation Flow ---

echo ""
echo "Starting dotfiles and packages installation..."
ensure_user_home_permissions

if ! setup_chaotic_aur; then
    echo "ERROR: Failed to set up the Chaotic-AUR repository. Aborting installation."
    exit 1
fi


echo "Updating system and installing packages via pacman..."
if ! pacman -Syu --noconfirm --needed "${PACKAGES[@]}"; then
    echo "ERROR: Failed to install packages. Aborting installation."
    exit 1
fi

sudo -u "$ACTUAL_USER" xdg-user-dirs-update
deploy_configs
set_permissions
set_default_file_manager
configure_nvidia

echo "Enabling system services..."
if systemctl list-unit-files 'ly@.service' >/dev/null 2>&1 && grep -q 'ly@' <(systemctl list-unit-files 'ly*'); then
    systemctl enable ly@tty2.service
else
    systemctl enable ly.service
fi
systemctl enable bluetooth
systemctl enable power-profiles-daemon

echo "--------------------------------------------------------"
echo "Installation complete! You can select your session in ly after reboot."
echo "--------------------------------------------------------"

read -r -p "Reboot now? (y/N): " reboot_choice
if [[ "$reboot_choice" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    reboot
fi
