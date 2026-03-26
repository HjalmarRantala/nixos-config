{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "git+https://codeberg.org/ditt-användarnamn/nixos-config.git#p52s"; 
    
    dates = "*:0/3"; 
    
    randomizedDelaySec = "20s"; 
  };
}
