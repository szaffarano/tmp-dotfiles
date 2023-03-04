{ config, lib, pkgs, ... }: {
  options.slithery0.enable = lib.mkEnableOption "slithery0";

  config = lib.mkIf config.slithery0.enable {

    programs.waybar = {
      settings = [{
        "layer" = "top";
        "position" = "top";
        "height" = 35;
        "modules-left" = [ "sway/workspaces" "sway/scratchpad" ];
        "modules-center" = [ "sway/window" ];
        "modules-right" = [
          "pulseaudio"
          "custom/sep"
          "bluetooth"
          "custom/sep"
          "network"
          "custom/sep"
          "cpu"
          "custom/sep"
          "disk"
          "custom/sep"
          "memory"
          "custom/sep"
          "battery"
          "custom/sep"
          "idle_inhibitor"
          "custom/sep"
          "clock"
          "custom/sep"
          "tray"
        ];
        "sway/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = false;
          "format" = "{name}";
        };
        "sway/window" = {
          "format" = " {title} ";
          "max-length" = 60;
          "tooltip" = true;
        };
        pulseaudio = {
          format = " {icon} {volume}%";
          format-muted = " {volume}%";
          format-bluetooth = " {icon} {volume}%";
          format-icons = {
            headphones = " ";
            default = [ "" "" " " ];
          };
          on-click = "pavucontrol";
        };
        "sway/scratchpad" = {
          format = "{icon}";
          show-empty = false;
          format-icons = [ " " " " ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };
        bluetooth = {
          on-click = "blueberry";
          format = " {status}";
          format-device-preference = [ "Keychron K2" ];
          format-connected = " {device_alias}";
          format-connected-battery =
            " {device_alias} {device_battery_percentage}%";
          tooltip-format = ''
            {controller_alias}	{controller_address}
            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}
            {num_connections} connected
            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
        };
        "network" = {
          "interval" = "1";
          "format-wifi" = "{icon}  {essid} ({signalStrength}%)";
          "format-ethernet" = " {ifname}";
          "format-disconnected" = " Disconnected";
          "format-icons" = [ " " ];
          "max-length" = "10";
          "tooltip-format" = ''
            Interface: {ifname}
            Signal: {signalStrength}%
            IP: {ipaddr}'';
        };
        "cpu" = {
          "format" = " {usage}%";
          "on-click" = "kitty --title floating-terminal htop";
        };
        "memory" = {
          "interval" = 1;
          "format" = " {used:0.1f}/{total:0.1f}G";
        };
        "battery" = {
          "interval" = "60";
          "format" = "{icon} {capacity}%";
          "states" = {
            "warning" = "95";
            "critical" = "50";
          };
          "format-icons" = [ "" "" "" "" "" "" "" "" "" "" ];
        };
        idle_inhibitor = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "   ";
            "deactivated" = "   ";
          };
        };
        clock = {
          "format-alt" = " {:%Y-%m-%d, %A}";
          "format" = "󱑑 {:%I:%M %p}";
        };
        tray = {
          "icon-size" = 16;
          "spacing" = 10;
        };
        "custom/sep" = { "format" = "  "; };
        disk = {
          format = " {free}";
          interval = "30";
        };
      }];
      style = builtins.readFile ./style.css;
    };
  };
}
