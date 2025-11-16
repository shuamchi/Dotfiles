cd /tmp
sudo pacman -Syu \
adobe-source-code-pro-fonts \
android-tools \
base \
base-devel \
bash-completion \
blueman \
bluez \
bluez-utils \
brightnessctl \
dunst \
efibootmgr \
fastfetch \
firefox \
foot \
fzf \
git \
grub \
hypridle \
hyprland \
hyprlock \
hyprpaper \
hyprpolkitagent \
imagemagick \
imv \
intel-gpu-tools \
intel-media-driver \
intel-ucode \
jq \
libva-utils \
libvdpau-va-gl \
linux-firmware \
linux-firmware-intel \
linux-lts \
lxappearance \
man-db \
mpv \
mpv-mpris \
nano \
network-manager-applet \
networkmanager \
noto-fonts \
noto-fonts-emoji \
otf-font-awesome \
pamixer \
pavucontrol \
pipewire \
pipewire-alsa \
pipewire-jack \
pipewire-pulse \
qt6ct \
rofi \
rtkit \
sof-firmware \
sudo \
telegram-desktop \
thunar \
ttf-droid \
ttf-fantasque-nerd \
ttf-fira-code \
ttf-go-nerd \
ttf-jetbrains-mono \
ttf-jetbrains-mono-nerd \
tumbler \
waybar \
wireplumber \
wlsunset \
xdg-desktop-portal-hyprland \
xorg-xdpyinfo \
yt-dlp 

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S wlogout \
ttf-victor-mono \
catppuccin-gtk-theme-mocha \
catppuccin-qt5ct-git 

