{ config, lib, pkgs, ... }:

{
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = "10.100.0.1:53";
      upstreams.groups.default = [ "9.9.9.9" ];
      bootstrapDns = {
        upstream = "9.9.9.9";
        ips = [ "9.9.9.9" ];
      };

      blocking = {
        denylists = {
          ads = [ 
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/pro.plus.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/tif.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/fake-onlydomains.txt"
            "https://codeberg.org/hagezi/mirror2/raw/branch/main/dns-blocklists/wildcard/tif.txt"
            ];
          };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };
  
  networking.firewall.interfaces.wg0 = {
    allowedTCPPorts = [ 
      53
    ];
    allowedUDPPorts = [
      53
    ];
  };
}
