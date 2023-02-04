{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git
    ./gpg
    ./nvim
    ./sway
    ./tmux.nix
    ./zsh.nix
  ];

  home = {
    username = "sebas";
    homeDirectory = "/home/sebas";
    stateVersion = "22.11";
    packages = with pkgs; [
      entr
      exa
      fzf
      bat
      ripgrep
      fd
      jq
      htop
      tmux
      glow
      icdiff
      zoxide
      du-dust
      tldr
      broot
      duf
      which
      gnumake
      unzip

      comma # runs software without installing it

      # python
      python3
      poetry
      mypy
      black

      nodejs

      go

      # nix
      alejandra

      # rust
      rustc
      clippy
      cargo
      rustfmt
      rust-analyzer

      # sway
      fontconfig
      font-awesome
      dejavu_fonts
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "JetBrainsMono"];})
      rofi
      swayidle
      wl-clipboard
      wofi
      mako
      wlr-randr
      kanshi

      ncspot

      firefox
      chromium
      keepassxc
      flameshot
      speedcrunch
      anki
      calibre
      gnome-themes-extra
      gnome.adwaita-icon-theme
      grim #screenshot
      slurp #screenshot
      imagemagick
      pandoc
      pavucontrol
      qview
      tdesktop
      weechat
      wl-clipboard
      xdg-utils
      zip
    ];
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    mcfly = {
      enable = true;
      keyScheme = "vim";
      fuzzySearchFactor = 5;
    };
    kitty = {
      enable = true;
      font = {
        name = "JetBrains Mono";
        size = 13;
      };
    };
  };
}
