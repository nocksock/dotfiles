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
      inputs.quickshell.follows = "quickshell";  # Use same quickshell version
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.blade = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        home-manager.nixosModules.home-manager
        { networking.hostName = "blade"; }
        { home-manager = { extraSpecialArgs = { inherit inputs; }; }; }
        ./nixos/configuration.nix
        ./nixos/machines/razer-blade/hardware-configuration.nix
        ./nixos/machines/razer-blade/configuration.nix
      ];
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = inputs;
      modules = [
        home-manager.nixosModules.home-manager
        { networking.hostName = "nixos"; }
        { home-manager = { extraSpecialArgs = { inherit inputs; }; }; }
        ./nixos/configuration.nix
        ./nixos/hardware-configuration.nix # Include the results of the hardware scan.
      ];
    };
  };
}
