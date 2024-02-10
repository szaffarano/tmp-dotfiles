{ self, nixpkgs, ... }@inputs:
config:
let
  configFile = ../users/${config.user.name}/${config.host.name}.nix;
  outputs = (self.outputs // { user = config.user; });
in
inputs.home-manager.lib.homeManagerConfiguration {
  modules = builtins.attrValues outputs.homeManagerModules ++ [
    configFile
    inputs.nix-colors.homeManagerModule
    inputs.nix-index-database.hmModules.nix-index
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nur.nixosModules.nur
  ];

  pkgs = import inputs.nixpkgs {
    system = config.host.arch;
  };

  extraSpecialArgs = { inherit inputs outputs; };
}
