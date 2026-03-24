{ config, lib, pkgs, ... }:

{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.default.rp_filter" = 0;
    "net.ipv4.conf.wg0.rp_filter" = 0;
  };


  # Wireguard configuration
  networking = {
    wireguard.enable = true;
    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.100.0.1/24" ];
        listenPort = 51820;
        privateKeyFile = "/etc/wireguard/private-key";
        peers = [
          { # t480
            publicKey = "lK5CItrUwRmIXPaPOTwQYU5E++mIbufu8Na9xFmXY2M=";
            allowedIPs = [ "10.100.0.2/32" ]; 
          }
#          {
#            publicKey = "q3/xHjYyYzGkfHreVSpnu01k7IcWtee/6+XZ+wD1qk4=";
#            allowedIPs = [ "10.100.0.3/32" ];
#          }
        ];
      };
    };
    firewall.allowedUDPPorts = [ 
      51820
    ];
    firewall.extraCommands = ''
      iptables -A INPUT -i wg0 -j ACCEPT
      iptables -I OUTPUT 1 -o wg0 -j ACCEPT
    '';
  };
}
