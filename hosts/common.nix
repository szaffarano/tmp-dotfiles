{ config, pkgs, nixpkgs, lib, ... }: {

  fontconfig.enable = true;

  ansible.enable = true;
  bat.enable = true;
  btop.enable = true;
  development.enable = true;
  direnv.enable = true;
  fzf.enable = true;
  keepassxc.enable = true;
  neovim.enable = true;
  starship.enable = true;
  tmux.enable = true;
  zsh.enable = true;
  programs.jq.enable = true;
  programs.navi.enable = true;
  programs.nix-index.enable = true;
  ncspot.enable = true;

  home = {
    packages = with pkgs; [
      scc # analyze LOC and other code metrics
      sd # sed replacement
      bandwhich
      newsboat # rss feeds reader

      dig
      file
      fd
      icdiff
      du-dust
      tldr
      broot
      duf
      which
      gnumake
      comma
      gawk
      htop
      httpie
      openssl
      p7zip
      pandoc
      ripgrep
      sqlite
      tree
      unzip
      whois
      gopass
      pass
      yq
      nodePackages.json-diff
      usbutils
      lshw

      yubikey-personalization
      yubikey-personalization-gui

      (buku.override { withServer = true; })

      kubectx
      kubectl
      kustomize
      minikube

      slack
      zoom-us

      vault
      aws-vault
      awscli2
      aws-iam-authenticator

      (
        google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ]
      )

      rsync

      fontconfig
      font-awesome
      dejavu_fonts
      liberation_ttf
      ubuntu_font_family
      twemoji-color-font
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "FiraCode" "Hack" "DroidSansMono" "JetBrainsMono" "FantasqueSansMono" ];
      })
    ];
  };
  programs.zsh.profileExtra = ''
    export PATH="$PATH:$HOME/.nix-profile/bin"
    export PATH="$PATH:$HOME/.local/bin"
    export PATH="$PATH:$HOME/.bin"
    export AWS_VAULT_BACKEND="pass";
  '';
}
