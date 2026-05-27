{ config, pkgs, lib, ... }:

{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true; 
    
    environmentFiles = [
      config.sops.secrets.hermes_env.path
    ];

    stateDir = "/home/hermes-runner/.hermes";
    workingDirectory = "/home/hermes-runner/workspace";

    container = {
      enable = true;
      hostUsers = [ "hjalmar" ]; 
    };

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
    openssh.authorizedKeys.keys = [];
  };

  systemd.services.hermes-agent.serviceConfig = {
    User = lib.mkForce "hermes-runner";
    Group = lib.mkForce "users";
    ProtectHome = lib.mkForce "read-only"; 
    ReadWritePaths = [ 
      "/home/hermes-runner" 
    ];
  };
}
