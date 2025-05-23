{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { nixpkgs, nixpkgs-unstable, ... } @ inputs: 
  {

    nixosConfigurations.lunar = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      
      modules = [
        ./configuration.nix

        ({config, pkgs, ...} : {
          environment.systemPackages = with pkgs; [

            nixpkgs-unstable.legacyPackages.x86_64-linux.zig
            nixpkgs-unstable.legacyPackages.x86_64-linux.go
            nixpkgs-unstable.legacyPackages.x86_64-linux.github-desktop
          
          ];
        })
      ];
    };

  };
}
