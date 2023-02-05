{ ... }: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        icons = "awesome";
        theme = "semi-native";
        blocks = [
          {
            block = "music";
            player = "ncspot";
          }
          {
            block = "disk_space";
            unit = "GB";
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used_percents}";
            format_swap = "{swap_used_percents}";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          {
            block = "battery";
            interval = 10;
            format = "{percentage} {time}";
          }
          {
            block = "keyboard_layout";
            driver = "sway";
            format = "{layout}";
            mappings = {
              "English (intl., with AltGr dead keys)" = "En";
              "English (Dvorak, intl., with dead keys)" = "En[Dvorak]";
            };
          }
          {
            block = "net";
            format = "{ssid} {signal_strength}";
            interval = 5;
          }
          {
            block = "sound";
            step_width = 3;
          }
          {
            block = "time";
            interval = 60;
            format = "%a %d/%m %R";
          }
        ];
      };
    };
  };
}
