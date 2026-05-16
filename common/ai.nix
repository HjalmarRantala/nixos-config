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
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "16384"; 
      OLLAMA_NUM_PARALLEL = "1";
      OLLAMA_MAX_LOADED_MODELS = "1";
    };
  };
  networking.firewall.allowedTCPPorts = [ 
    11434
  ];
}
