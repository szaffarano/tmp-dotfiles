{
  config,
  lib,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sebas";
  home.homeDirectory = "/home/sebas";

  fonts.fontconfig.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    git
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

    # c
    gcc

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
    swaylock-effects
    fontconfig
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "JetBrainsMono"];})
    rofi

    firefox
    chromium
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.mcfly = {
    enable = true;
    keyScheme = "vim";
    fuzzySearchFactor = 3;
  };

  programs.starship = {
    enable = true;
  };

  services.gpg-agent = import gpg/gpg-agent.nix {};
  programs.tmux = import tmux/tmux.nix {pkgs = pkgs;};
  programs.zsh = import zsh/zsh.nix {
    config = config;
    pkgs = pkgs;
    lib = lib;
  };
  programs.git = import git/git.nix {pkgs = pkgs;};
  programs.gpg = import gpg/gpg.nix {pkgs = pkgs;};
  programs.neovim = import nvim/neovim.nix {
    lib = lib;
    pkgs = pkgs;
  };
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
  programs.alacritty.enable = true;
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 13;
    };
  };
  programs.nix-index.enable = true;
  xsession.enable = true;
  xsession.windowManager.command = "sway";

  wayland.windowManager.sway = import sway/sway.nix {
    lib = lib;
    config = config;
  };
}
