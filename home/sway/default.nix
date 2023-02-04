{
  config,
  pkgs,
  lib,
  ...
}: let
  fontConf = {
    names = ["JetBrainsMono Nerd Font Mono" "DejaVuSansMono" "FontAwesome 6 Free"];
    style = "Bold Semi-Condensed";
    size = 11.0;
  };
in {
  imports = [
    ./i3status-rs.nix
  ];
  wayland.windowManager.sway = let
    lockCmd = lib.concatStrings [
      "swaylock "
      " --screenshots"
      " --clock"
      " --indicator"
      " --indicator-radius 60"
      " --indicator-thickness 7"
      " --effect-blur 7x5"
      " --effect-vignette 0.5:0.5"
      " --ring-color bb00cc"
      " --key-hl-color 880033"
      " -K"
      " --line-color 00000000"
      " --inside-color 00000088"
      " --separator-color 00000000"
      " --grace 2"
      " --fade-in 0.2"
    ];
  in {
    enable = true;
    package = null;
    swaynag.enable = true;
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show drun";
      fonts = fontConf;
      workspaceAutoBackAndForth = true;

      window = {
        titlebar = false;
        hideEdgeBorders = "both";
      };

      floating.criteria = [
        {class = "^Pavucontrol$";}
        {class = "^Arandr$";}
        {class = "^copyq$";}
        {class = "^Keybase$";}
        {class = "^JetBrains Toolbox$";}
        {title = "tracker - .*";}
        {
          class = "jetbrains-idea-ce";
          title = "Welcome to IntelliJ IDEA";
        }
        {
          class = "jetbrains-datagrip";
          title = "Welcome to DataGrip";
        }
        {
          class = "jetbrains-idea";
          title = "win0";
        }
        {
          class = "Anki";
          title = "Profiles";
        }
        {
          class = "Anki";
          title = "Add";
        }
        {
          class = "Anki";
          title = "^Browse.*";
        }
        {app_id = "org.keepassxc.KeePassXC";}
        {class = "Blueman-manager";}
        {class = "flameshot";}
      ];

      startup = [
        {command = "/tmp/m";}
        {command = "kanshi";}
        {command = "keepassxc";}
        {command = "speedcrunch";}
        {
          command = ''
            swayidle -w \
               timeout 300 "${lockCmd}" \
               timeout 120 'swaymsg "output * dpms off"' \
               resume 'swaymsg "output * dpms on"' \
               before-sleep "${lockCmd}"
          '';
        }
        {command = "firefox";}
      ];

      assigns = {
        "1" = [{app_id = "firefox";}];
      };

      input = {
        "type:keyboard" = {
          xkb_layout = "us,us";
          xkb_variant = "altgr-intl,dvorak-intl";
          xkb_options = "grp:rctrl_toggle";
        };
        "type:touchpad" = {
          click_method = "clickfinger";
          tap = "enabled";
        };
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

      window.commands = [
        {
          command = "inhibit_idle fullscreen";
          criteria.app_id = "firefox";
        }
        {
          command = "move to scratchpad";
          criteria.app_id = "org.speedcrunch.";
        }
      ];

      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        inherit
          (config.wayland.windowManager.sway.config)
          left
          down
          up
          right
          menu
          terminal
          ;
      in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${menu}";
          "${mod}+q" = "exec --no-startup-id rofi -show window";
          "${mod}+F2" = "exec --no-startup-id rofi -show run";

          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";

          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "Shift+Print" = "exec flameshot full -p $screenshots";
          "Print" = "exec flameshot gui";

          "${mod}+backslash" = "split h";
          "${mod}+minus" = "split v";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+a" = "focus parent";
          "${mod}+c" = "focus child";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+BackSpace" = ''mode "system:  [r]eboot  [p]oweroff  [l]ogout"'';

          "${mod}+r" = "mode resize";

          "${mod}+Ctrl+BackSpace" = "exec ${lockCmd}";
          "Ctrl+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss";
          "Ctrl+Shift+Space" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

          "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";

          "${mod}+Control_L+Left" = "move workspace to output left";
          "${mod}+Control_L+Right" = "move workspace to output left";

          "${mod}+Shift+s" = ''[app_id="org.speedcrunch."] scratchpad show'';
        };

      modes = {
        "system:  [r]eboot  [p]oweroff  [l]ogout" = {
          r = "exec reboot";
          p = "exec poweroff";
          l = "exit";
          Return = "mode default";
          Escape = "mode default";
        };
        resize = {
          "h" = "resize shrink width";
          "l" = "resize grow width";
          "j" = "resize shrink height";
          "k" = "resize grow height";
          Return = "mode default";
          Escape = "mode default";
        };
      };
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font Mono:size=13";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };
      docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
          }
        ];
      };
    };
  };
}
