#!/bin/bash
# A script for a new install of sway on debian minimal install.

# First updating the system.
echo "Updating system"
sudo apt update && sudo apt upgrade

# Installing important programs first
echo "Installing basic programs"
sudo apt install git stow zip unzip network-manager network-manager-gnome nwg-look thunar wlogout

# Installing sway
echo "Do you want to install SWAY? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "Installing Sway with dependencis."
    sudo apt install sway foot-themes waybar rofi alacritty dunst swaylock swayidle swaybg xdg-desktop-portal-wlr xwayland
elif [ "$answer" = "n" ]; then
    echo "Do not install Sway"
else
    echo "Answer 'y' or 'n'."
fi

# Install my dotfiles
echo "Do you want to install LibrePenguins dotfiles? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "Cloning my dotfiles"
    cd
    git clone https://github.com/LibrePenguin/dotfiles.git
    sudo apt install lsd curl
    cd
    curl -sS https://starship.rs/install.sh | sh
elif [ "$answer" = "n" ]; then
    echo "Dont want LibrePenguins dotfiles???? ok."
else
    echo "Answer yes or no please"
fi

# Install emacs
echo "Do you want to install Doom-emacs? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "First install emacs"
    sudo apt install emacs-gtk
    cd
    echo "Installing Doom"
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
    doom sync
elif [ "$answer" = "n" ]; then
    echo "Setting up emacs later"
else
    echo "Do nothing"
fi

# Install fonts
echo "Do you want to install styrmans fonts? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    sudo apt install fonts-jetbrains-mono fonts-hack
    echo "Remember to install nerd fonts if you nead it"
elif [ "$answer" = "n" ];then
    echo "No fonts installed"
else
    echo "OK"
fi

# Install flatpaks
echo "Do you want to set up flatpaks? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "Installing flatpak"
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "Installing some flatpaks"
    flatpak install flathub com.brave.Browser
    flatpak install flathub md.obsidian.Obsidian
elif [ "$answer" = "n" ]; then
    echo "Setup flatpak later"
else
    echo "OK"
fi

# Installing all sowtwere that i nead
echo "Do you want to install all the programs that LibrePenguin uses? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "Installing some debian packages"
    sudo apt install keepassxc calibre mpv htop
elif [ "$answer" = "n" ]; then
    echo "Do it later"
else
    echo "OK"
fi

# Setup Tailscale
echo "Do you want to install Tailscale? (y/n)"
read answer

if [ "$answer" = "y"  ]; then
    echo "Installing Tailscale"
    curl -fsSL https://tailscale.com/install.sh | sh
elif [ "$answer" = "n" ]; then
    echo "You can set it up later with the command: curl -fsSL https://tailscale.com/install.sh | sh"
fi


# Install a LoginManger
echo "Do you want to set up lightDM login manager? (y/n)"
read answer

if [ "$answer" = "y" ]; then
    echo "Installing lightdm"
    sudo apt install lightdm lightdm-gtk-greeter
    echo "Enable lightdm"
    sudo systemctl enable lightdm
    sudo systemctl start lightdm
    echo "You can now reboot your computer"

elif [ "$answer" = "n" ]; then
    echo "Setup lightdm later"
else
    echo "OK"
fi
