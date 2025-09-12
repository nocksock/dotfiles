{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...}: {
        # For `nix run .` later
        defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

        homeConfigurations = {
            "your.username" = home-manager.lib.homeManagerConfiguration {
                # Note: I am sure this could be done better with flake-utils or something
                pkgs = import nixpkgs { system = "x86_64-darwin"; };

                modules = [ ./home.nix ]; # Defined later
            };
        };
    };
}
