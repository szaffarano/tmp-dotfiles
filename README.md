# Nix Based dotfiles

## Preconditions

### Arch

TODO: requirement for nix?

```sh
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
pushd yay-bin
makepkg -si
popd
rm -rf yay-bin
yay -Y --gendb
```

```sh
yay -S zsh
sudo chsh sebas -s /bin/zsh
```

### Bootstrap nix and home-manager

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon

mkdir ~/.config/nix && echo "experimental-features = nix-command flakes" | tee ~/.config/nix/nix.conf

nix build --no-link .#homeConfigurations.$USER.activationPackage

"$(nix path-info .#homeConfigurations.$USER.activationPackage)"/activate

# after above command, to update 

home-manager switch --flake .#$USER
```

### Wayland and sway

```sh
yay -Syu
yay -S wayland xorg-xwayland sway swaylock-effects polkit ly
yay -S xdg-desktop-portal xdg-desktop-portal-wlr
apt-get install dconf-service
apt-get install gsettings-desktop-schemas 
apt-get install gnome-themes-extra adwaita-icon-theme-full

bluez-cups bluez-meshd # or bluetooth metapackage
at-spi2-core
pulseaudio pulseaudio-module-bluetooth

sudo usermod -aG seat sebas # video for ubuntu
sudo systemctl enable seatd.service
sudo systemctl enable ly.service
sudo systemctl start seatd.service
```

## TODO

- [ ] Automate the bootstrap process
- [ ] Include scripts and statis configs not covered by home-manager
- [ ] Review old programs and configs to migrate to home-manager
- [ ] Add flakes for other environments
