{ config, pkgs, ... }:

{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true; 
    
    environmentFiles = [
      config.sops.secrets.hermes_env.path
    ];

    container = {
      enable = true;
      hostUsers = [ "hjalmar" ]; 
    };

    settings.model.default = "openai-codex";
  };
}
