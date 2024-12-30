{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.desktop.wayland.swaync;
in
  with lib; {
    options.desktop.wayland.swaync.enable = mkEnableOption "swaync";

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        swaynotificationcenter
        libnotify
      ];

      services.swaync = {
        enable = true;
        style = ./style.css;
        settings = {
          positionX = "right";
          positionY = "bottom";
          control-center-positionX = "none";
          control-center-positionY = "bottom";
          control-center-margin-top = 8;
          control-center-margin-bottom = 8;
          control-center-margin-right = 8;
          control-center-margin-left = 8;
          control-center-width = 500;
          control-center-height = 600;
          fit-to-screen = false;
          layer = "overlay";
          cssPriority = "user";
          notification-icon-size = 64;
          notification-body-image-height = 100;
          notification-body-image-width = 200;
          timeout = 10;
          timeout-low = 5;
          timeout-critical = 0;
          notification-window-width = 500;
          keyboard-shortcuts = true;
          image-visibility = "when-available";
          transition-time = 200;
          hide-on-clear = true;
          hide-on-action = true;
          script-fail-notify = true;
          widgets = [
            "inhibitors"
            "title"
            "dnd"
            "notifications"
          ];
          widget-config = {
            inhibitors = {
              text = "Inhibitors";
              button-text = "Clear All";
              clear-all-button = true;
            };
            title = {
              text = "Notifications";
              clear-all-button = false;
              button-text = "Clear All";
            };
            dnd = {
              text = "Do Not Disturb";
            };
            label = {
              max-lines = 5;
              text = "Label Text";
            };
            mpris = {
              image-size = 96;
              image-radius = 12;
            };
          };
        };
      };
    };
  }
