{
  description = "My NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    agenix,
    home-manager,
    ...
  } @ inputs: let
    baseline = [
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      ./nixos/modules/server.nix
    ];
  in {
    nixosConfigurations = {
      blade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules =
          baseline
          ++ [
            {networking.hostName = "blade";}
            {home-manager = {extraSpecialArgs = {inherit inputs;};};}
            ./nixos/desktop.nix
            ./nixos/hosts/blade
          ];
      };

      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules =
          baseline
          ++ [
            {networking.hostName = "nixos";}
            {home-manager = {extraSpecialArgs = {inherit inputs;};};}
            ./nixos/desktop.nix
            ./nixos/hosts/nzxt-h1/hardware-configuration.nix # Include the results of the hardware scan.
          ];
      };

      repo = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules =
          baseline
          ++ [
            {networking.hostName = "repo";}
            ./machines/repo/configuration.nix
            ./nixos/modules/users/snock.nix
            ./nixos/hosts/repo
            ./users/snock.nix
            ./users/machine.nix
          ];
      };

      preview = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules =
          baseline
          ++ [
            {networking.hostName = "preview";}
            ./machines/preview/configuration.nix
            ./nixos/modules/users/snock.nix
            ./nixos/modules/users/machine.nix
          ];
      };

      studio = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules =
          baseline
          ++ [
            {networking.hostName = "studio";}
            ./machines/studio/configuration.nix
            ./nixos/modules/users/snock.nix
            ./nixos/modules/users/machine.nix
          ];
      };

      coworker = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          baseline
          ++ [
            {networking.hostName = "coworker";}
            ./machines/coworker/configuration.nix
            ./nixos/modules/users/snock.nix
            ./nixos/modules/users/machine.nix
          ];
      };
    };
  };
}
