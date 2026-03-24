{
  description = "NixOS Infrastructure";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    
    nixosConfigurations = {
      
      p52s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/p52s/configuration.nix
        ];
      };
    };
  };
}
