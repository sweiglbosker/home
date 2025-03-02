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
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
    inputs@{ 
      self,
      nixpkgs, 
      home-manager, 
      nixgl,
      neovim-nightly,
      ... 
    }:
    let
      system = "x86_64-linux";
      overlays = [
        inputs.nixgl.overlays.default
        inputs.neovim-nightly.overlays.default
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system overlays;
      };
      inherit (pkgs) lib;
    in {
      packages.${system}.default = home-manager.defaultPackage.${system};
      homeConfigurations = {
        inherit inputs system pkgs;
        "stefan" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit system inputs pkgs;
          };
        modules = [ ./home.nix ];
        };
      };
    };
}
