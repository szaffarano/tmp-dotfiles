_:
{ config, lib, pkgs, ... }: {
  options.development.enable = lib.mkEnableOption "development";

  config = lib.mkIf config.development.enable {
    programs.java.enable = true;
    home = {
      packages = with pkgs; [
        # TODO: parameterize DataGrip
        # TODO: parameterize IC or IU
        jetbrains.idea-community

        poetry
        (python3.withPackages (ps: with ps; [ pip flake8 black ipython mypy ]))

        nodejs

        go

        nixfmt

        cargo
        clippy
        rust-analyzer
        rustc
        rustfmt
      ];
    };

  };
}
