{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "git+https://codeberg.org/danskjavel/nixos-config.git#${config.networking.hostName}";

    dates = "*:0/3";

    randomizedDelaySec = "20s";
  };
}
