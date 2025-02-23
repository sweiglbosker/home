{
  description = "Home Manager configuration of stefan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
    inputs@{ 
      nixpkgs, 
      home-manager, 
      nixgl,
      ... 
    }:
    let
      system = "x86_64-linux";
      overlays = [
        inputs.nixgl.overlays.default
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system overlays;
      };
      custom = import "custom.nix";
    in {
      packages.${system}.default = home-manager.defaultPackage.${system};
      homeConfigurations = {
          "stefan" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs;
            };
            modules = [ ./home.nix ];
          };
        };
    };
}
