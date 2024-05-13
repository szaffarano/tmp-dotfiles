{ config, lib, ... }:
{
  config = lib.mkIf config.nixos.custom.quietboot {
    console = {
      useXkbConfig = true;
      earlySetup = false;
    };

    boot = {
      plymouth = {
        enable = lib.mkDefault true;
        theme = lib.mkDefault "spinner";
      };
      loader.timeout = lib.mkDefault 3;
      kernelParams = lib.mkDefault [
        "quiet"
        "loglevel=3"
        "systemd.show_status=auto"
        "udev.log_level=3"
        "rd.udev.log_level=3"
        "vt.global_cursor_default=0"
      ];
      consoleLogLevel = lib.mkDefault 0;
      initrd.verbose = lib.mkDefault false;
    };
  };
}
