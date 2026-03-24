{
  description = "Hjalmars NixOS GitOps Infrastruktur";

  inputs = {
    # Välj din NixOS-version. 24.05 är stabil, men du kan ändra till nixos-unstable.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    
    # --- Framtida inputs ---
    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    
    nixosConfigurations = {
      
      # Maskin 1: Din huvudserver
      # Byggs med kommandot: nixos-rebuild switch --flake .#server
      p52s = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # specialArgs skickar vidare 'inputs' så att dina moduler 
        # (t.ex. sops-nix) kan användas inuti dina filer senare.
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/p52s/configuration.nix
        ];
      };

      # Maskin 2: Din Raspberry Pi
      # Byggs med kommandot: nixos-rebuild switch --flake .#rpi-smart-tv
#      rpi-smart-tv = nixpkgs.lib.nixosSystem {
#        system = "aarch64-linux"; # Notera ARM-arkitekturen!
#        specialArgs = { inherit inputs; };
#        modules = [
#          ./hosts/rpi-smart-tv/configuration.nix
#        ];
#      };
#
#    };
#  };
}
