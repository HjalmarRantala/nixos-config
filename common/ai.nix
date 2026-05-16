{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    host = "0.0.0.0";   
    openFirewall = true;
    loadModels = [
      "gemma4:26b"
    ];
    port = 11434;
    syncModels = true;
  };
  networking.firewall.allowedTCPPorts = [ 
    11434
  ];
}
