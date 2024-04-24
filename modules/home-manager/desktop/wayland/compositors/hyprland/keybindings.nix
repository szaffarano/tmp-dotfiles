{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.wayland.compositors.hyprland;
  workspaces = [
    "0"
    "1"
    "2"
    "3"
    "4"
    "5"
    "6"
    "7"
    "8"
    "9"
    "F1"
    "F2"
    "F3"
    "F4"
    "F5"
    "F6"
    "F7"
    "F8"
    "F9"
    "F10"
    "F11"
    "F12"
  ];
  directions = rec {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    h = left;
    l = right;
    k = up;
    j = down;
  };
in
with lib;
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind =
        [
          "$mod, Return, exec, $terminal"
          "$mod_SHIFT, Q, killactive"
          "$mod, F, fullscreen"

          "$mod,f,fullscreen,1"
          "$mod SHIFT,f,fullscreen,0"
          "$mod,space,togglefloating"

          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"

          "$mod, o, exec, pypr toggle orgmode"
          "$mod, m, exec, pypr toggle musicPlayer"
          "$mod, p, exec, pypr toggle slack"
        ]

        ++ (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
        ++ (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)

        ++ (mapAttrsToList (key: direction: "$mod,${key},movefocus,${direction}") directions)
        ++ (mapAttrsToList (key: direction: "$modSHIFT,${key},swapwindow,${direction}") directions)

        ++ (optionals config.desktop.wayland.swaync.enable (
          let
            swayNcClient = "${pkgs.swaynotificationcenter}/bin/swaync-client";
          in
          [
            "CTRL_ALT,SPACE,exec, ${swayNcClient} --hide-latest"
            "CTRL_SHIFT,SPACE,exec, ${swayNcClient} --close-all"
          ]
        ))
        ++ (optionals config.desktop.tools.copyq.enable [ "CTRL_ALT,v,exec,copyq toggle" ])
        ++ (optionals config.desktop.tools.keepassxc.enable (
          let
            passwordManager = "${pkgs.keepassxc}/bin/keepassxc";
          in
          [ "SUPER_SHIFT,w,exec,${passwordManager}" ]
        ))
        ++ (optionals config.services.mako.enable (
          let
            makoctl = "${config.services.mako.package}/bin/makoctl";
          in
          [ "SUPER,w,exec,${makoctl} dismiss" ]
        ))
        ++ (optionals config.programs.wofi.enable (
          let
            wofi = "${config.programs.wofi.package}/bin/wofi";
            wofiPowerMenu = "wofi-power-menu";
          in
          [
            "SUPER,x,exec,${wofi} -S drun"
            "SUPER,d,exec,${wofi} -S run"
            "SUPER,backspace,exec,${wofiPowerMenu}"
          ]
        ));
    };
  };
}
