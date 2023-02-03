{
  config,
  pkgs,
  lib,
  ...
}: let
  fontConf = {
    names = ["JetBrains Mono" "DejaVuSansMono" "FontAwesome 6 Free"];
    style = "Bold Semi-Condensed";
    size = 11.0;
  };
in {
  imports = [
    ./i3status-rs.nix
  ];
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    swaynag.enable = true;
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show drun";
      fonts = fontConf;

      startup = [
        {command = "firefox";}
      ];

      assigns = {
      };

      bars = [
        {
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          command = "swaybar";
          position = "top";
          fonts = fontConf;
          trayOutput = "*";
        }
      ];
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
      in
        lib.mkOptionDefault {
          "${mod}+q" = "exec --no-startup-id rofi -show window";
          "${mod}+F2" = "exec --no-startup-id rofi -show run";
        };
    };
  };
}
