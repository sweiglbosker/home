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
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    ida-pro-overlay = {
      url = "github:msanft/ida-pro-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      vicinae,
      nixgl,
      neovim-nightly,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        inputs.nixgl.overlays.default
        # inputs.neovim-nightly.overlays.default
        inputs.ida-pro-overlay.overlays.default
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system overlays;
      };
      inherit (pkgs) lib;
    in
    {
      nixosConfigurations = {
        form = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./form/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.stefan = import ./form/home.nix;
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit system inputs pkgs;
                };
              };
            }
          ];
        };
        fw = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./fw/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                users.stefan = import ./fw/home.nix;
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit system inputs pkgs;
                };
              };
            }
          ];
        };
      };
      homeConfigurations = {
        inherit inputs system pkgs;
        "void" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./void/home.nix ];
          extraSpecialArgs = {
            inherit system inputs pkgs;
          };
        };
      };
    };
}
