{ inputs, outputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  services.geoclue2.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  nixos = {
    hostName = "pilsen";
    allowedUDPPorts = [ 22000 21027 ];
    audio.enable = true;
    bluetooth.enable = true;
    disableWakeupLid = true;
    quietboot.enable = true;
    desktop = {
      enable = true;
      sway.enable = true;
      greeter.enable = false;
    };
    system = {
      user = "sebas";
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGM8VrSbHicyD5mOAivseLz0khnvj4sDqkfnFyipqXCg cardno:19_255_309"
      ];
    };
  };

  system.stateVersion = "23.05";

  #####################################################################################
  # Legacy configs: check where to move them
  #####################################################################################

  zramSwap.enable = true;

  services.upower.enable = true;

  # TODO: parameterize
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c52b", ATTR{power/wakeup}="enabled"
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", ATTR{power/wakeup}="enabled"
  '';
}