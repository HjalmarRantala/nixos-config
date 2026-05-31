{ config, pkgs, ... }:

let
  hermesUser = "hermes-runner";
  hermesGroup = "users";
  hermesHome = "/home/${hermesUser}";
  hermesWorkspace = "${hermesHome}/workspace";

  hermesPackages = with pkgs; [
    git
    gh
    codeberg-cli
    openssh
    nixfmt-rfc-style
    jq
    curl
    statix
  ];
in
{
  services.hermes-agent = {
    enable = true;
    container.enable = false;
    addToSystemPackages = true;

    user = hermesUser;
    group = hermesGroup;
    createUser = false;

    stateDir = hermesHome;

    workingDirectory = hermesWorkspace;
    extraPackages = hermesPackages;

    environmentFiles = [
      config.sops.secrets.hermes_env.path
    ];

    settings = {
      model = {
        default = "gpt-5.4";
        provider = "openai-codex";
      };

      terminal = {
        backend = "local";
        cwd = hermesWorkspace;
      };

      providers.openai-codex.enabled = true;
    };

    environment = {
      API_SERVER_ENABLED = "true";
      API_SERVER_PORT = "56121";
      API_SERVER_HOST = "127.0.0.1";
      API_SERVER_MODEL_NAME = "hermes-codex";
      API_SERVER_KEY = "dummy_key_to_bypass_webui_checks";
    };
  };

  users.users.${hermesUser} = {
    isNormalUser = true;
    description = "Hermes Agent Runner";
    group = hermesGroup;
    home = hermesHome;
    createHome = true;
    packages = hermesPackages;
  };

  systemd.tmpfiles.rules = [
    "d /home/hermes-runner 0755 hermes-runner users -"
    "Z /home/hermes-runner 0755 hermes-runner users -"

    "d /home/hermes-runner/.hermes 0750 hermes-runner users -"
    "Z /home/hermes-runner/.hermes 0750 hermes-runner users -"

    "d /home/hermes-runner/workspace 0755 hermes-runner users -"
    "Z /home/hermes-runner/workspace 0755 hermes-runner users -"
  ];

  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0";

    environment = {
      OPENAI_API_BASE_URL = "http://127.0.0.1:56121/v1";
      OPENAI_API_KEY = "dummy_key_to_bypass_webui_checks";
      ENABLE_OLLAMA_API = "False";
      WEBUI_AUTH = "False";
    };
  };

  networking.firewall.allowedTCPPorts = [
    8080
  ];
}
