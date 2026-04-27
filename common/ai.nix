{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    host = "0.0.0.0";   
    openFirewall = true;
    loadModels = [
      "gemma4:26b"
      "qwen3.5:9b"
    ];
    port = 11434;
  };
}
