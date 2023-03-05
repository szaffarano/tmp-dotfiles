_:
{ config, lib, pkgs, ... }: {
  options.ncspot.enable = lib.mkEnableOption "ncspot";

  config = lib.mkIf config.ncspot.enable {
    programs.ncspot = {
      enable = true;
      package = pkgs.ncspot.override { withALSA = false; };
      settings = {
        use_nerdfont = true;
        notify = true;

        theme = {
          background = "black";
          primary = "light white";
          secondary = "light black";
          title = "green";
          playing = "green";
          playing_selected = "light green";
          playing_bg = "black";
          highlight = "light white";
          highlight_bg = "#484848";
          error = "light white";
          error_bg = "red";
          statusbar = "black";
          statusbar_progress = "green";
          statusbar_bg = "green";
          cmdline = "light white";
          cmdline_bg = "black";
          search_match = "light red";
        };

      };
    };
  };
}
