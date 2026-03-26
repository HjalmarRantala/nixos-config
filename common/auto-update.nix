{ config, lib, pkgs, ... }:

{
  services.webhook = {
    enable = true;
    port = 9000;
    hooks = {
      update-p52s = {
        execute-command = "/home/hjalmar/nixos-config/rebuild.sh"; 
        
        trigger-rule = {
          match = {
            type = "payload-hash-sha1";
            secret = "byt-ut-detta-mot-ett-starkt-lösenord";
            parameter = {
              source = "header";
              name = "X-Gitea-Signature"; 
            };
          };
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [
    9000
  ];
}
