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
  };
  services.open-webui = {
    enable = true;
    port = 3000;     
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      HOST = "0.0.0.0";
    };
  };

  networking.firewall.allowedTCPPorts = [ 
    3000 
    11434
  ];
}
