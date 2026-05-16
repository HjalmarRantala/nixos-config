{ config, pkgs, ... }:
}
  programs.openclaw = {
    enable = true;
    
    config = {
      gateway = {
        mode = "local"; 
        auth.token = "dev-test-token"; # To be changed to secure key once initial setup is confirmed working
      };
      
      llm = {
        provider = "ollama";
        endpoint = "http://127.0.0.1:11434";
        model = "gemma4:26b"; 
      };
      
      memory.backend = "qmd";
    };

    bundledPlugins.summarize.enable = true;
    bundledPlugins.peekaboo.enable = true;

    instances.default = {
      enable = true;
      package = inputs.openclaw.packages.${pkgs.system}.default;
      
      stateDir = "/home/hjalmar/.openclaw";
      workspaceDir = "/home/hjalmar/.openclaw/workspace";
      
      systemd.enable = true; 
    };
  };
}
