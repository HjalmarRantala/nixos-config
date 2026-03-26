{ config, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    flake = "git+ssh://git@codeberg.org/danskjavel/nixos-config.git#${config.networking.hostName}";

    dates = "*:0/3";

    randomizedDelaySec = "20s";
  };
  systemd.services.nixos-upgrade.environment = {
      GIT_SSH_COMMAND = "ssh -i /run/secrets/deploy_key -o IdentitiesOnly=yes";
  };
}
