{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    polypane.url = "github:mrtrimble/polypane-flake";
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
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = {
    self,
    nixpkgs,
    agenix,
    polypane,
    home-manager,
    ...
  } @ inputs: let
    baseline = [
      agenix.nixosModules.default
      home-manager.nixosModules.home-manager
      ./nixos/modules/server.nix
      ./nixos/modules/docker.nix
    ];
  in {
    # Reusable user modules for external flakes (e.g. studio infra).
    # Each bundles the home-manager NixOS module so consumers only need
    # this flake as input.
    nixosModules = {
      user-snock.imports = [
        home-manager.nixosModules.home-manager
        ./nixos/modules/users/snock.nix
      ];
      user-machine.imports = [
        home-manager.nixosModules.home-manager
        ./nixos/modules/users/machine.nix
      ];
      user-nr.imports = [
        home-manager.nixosModules.home-manager
        ./nixos/modules/users/nr.nix
      ];
      default = self.nixosModules.user-snock;
    };

    nixosConfigurations = {
      blade = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules =
          baseline
          ++ [
            {networking.hostName = "blade";}
            {home-manager = {extraSpecialArgs = {inherit inputs;};};}
            ./nixos/hosts/blade/configuration.nix
            ./nixos/desktop.nix
            ./nixos/modules/greetd.nix
            ./nixos/modules/de/gnome.nix
            { hardware.keyboard.qmk.enable = true; }
            # System modules
            ./nixos/modules/nvidia.nix
            ./nixos/modules/audio.nix
            ./nixos/modules/bluetooth.nix
            ./nixos/modules/fonts.nix
            ./nixos/modules/tailscale.nix
            ./nixos/modules/1password.nix
            ./nixos/modules/caddy.nix
            ./nixos/modules/hosts.nix
            ./nixos/modules/postgres.nix

            ./nixos/modules/users/nr.nix
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
