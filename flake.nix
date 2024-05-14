{
  description = "Sebas's home-manager configurations";

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://szaffarano.cachix.org"
    ];

    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "szaffarano.cachix.org-1:T4qYO8SxoCddCRetQDQFUDc+tuBZyL7HuGcisMj4wiM="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    nix-colors.url = "github:misterio77/nix-colors";

    wofi-tools = {
      url = "github:szaffarano/wofi-power-menu";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , ...
    }@inputs:
    let
      inherit (self) outputs;

      localLib = import ./lib inputs;
      lib = nixpkgs.lib // home-manager.lib // localLib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      # inherit lib;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs inputs; });

      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        # pilsen = lib.mkNixOS pilsen;
        # bock = lib.mkNixOS bock;
        # weisse = lib.mkNixOS weisse;
        zaffarano-elastic = nixpkgs.lib.nixosSystem {
          modules = [ ./system/zaffarano-elastic ];
          specialArgs = {
            inherit inputs outputs localLib;
          };
        };
      };

      darwinConfigurations = {
        "szaffarano@macbook" = lib.mkDarwin "szaffarano" "macbook" "aarch64-darwin";
      };
    };
}
