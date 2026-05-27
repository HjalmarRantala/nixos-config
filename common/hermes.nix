{ config, pkgs, lib, ... }:
{
  services.hermes-agent = {
    enable = true;
    container.enable = false;
    addToSystemPackages = true; 
    
    environmentFiles = [
      config.sops.secrets.hermes_env.path
    ];

    stateDir = "/home/hermes-runner/.hermes";
    workingDirectory = "/home/hermes-runner/workspace";

    settings = {
      model = {
        default = "gpt-5.4";
        provider = "openai-codex";
      };
      terminal.backend = "local";
      providers.openai-codex.enabled = true;
    };
  };

#  security.sudo.extraRules = [{
#    users = [ "hjalmar" ];
#    commands = [{
#      command = "/run/current-system/sw/bin/docker";
#      options = [ "NOPASSWD" ];
#    }];
#  }];

  users.users.hermes-runner = {
    isNormalUser = true;
    description = "Hermes Agent Runner";
    packages = with pkgs; [
      git
      gh
      codeberg-cli
      openssh
      nixfmt-rfc-style
      jq
      curl
      statix
    ];
  };

  systemd.services.hermes-agent.serviceConfig = {
    User = lib.mkForce "hermes-runner";
    Group = lib.mkForce "users";
    ProtectHome = lib.mkForce false; 
    ReadWritePaths = [ 
      "/home/hermes-runner" 
    ];
  };

  services.open-webui = {
    enable = true;
    port = 8080; 
    
    environment = {
      OPENAI_API_BASE_URL = "http://127.0.0.1:56121/v1"; 
      
      ENABLE_OLLAMA_API = "False"; 
      
      WEBUI_AUTH = "False"; 
    };
  };
}
