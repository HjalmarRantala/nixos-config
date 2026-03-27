{ config, lib, pkgs, ... }:

{
services.prometheus = {
    enable = true;
    port = 9090;
    
    exporters.node = {
      enable = true;
      port = 9100;
      enabledCollectors = [ "systemd" ];
    };
    
    scrapeConfigs = [
      {
        job_name = "p52s-system";
        static_configs = [{ targets = [ "127.0.0.1:9100" ]; }];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = 3000;
        http_addr = "0.0.0.0"; 
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 3000 ];
}
