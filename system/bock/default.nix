{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko

    ./hardware-configuration.nix
  ];

  nixos = {
    hostName = outputs.host.name;
    audio.enable = false;
    disableWakeupLid = false;
    quietboot.enable = true;
    system = {
      user = outputs.user.name;
      hashedPasswordFile = config.sops.secrets.sebas-password.path;
      authorizedKeys = outputs.user.authorizedKeys;
    };
  };

  virtualisation = {
    libvirtd.enable = false;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  sops.secrets = {
    sebas-password = {
      sopsFile = ./secrets.yaml;
      neededForUsers = true;
    };
  };

  system.stateVersion = "23.05";

  zramSwap.enable = true;
}
