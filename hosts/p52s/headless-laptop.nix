{ config, lib, pkgs, modulesPath, ... }:

{
  services.logind = {
    settings.Login = {
      HandleLidSwitch="ignore";
      HandleLidSwitchExternalPower="ignore";
      HandleLidSwitchDocked="ignore";
    };
  };
  systemd.targets.sleep.enable = false;
  services.upower = {
    enable = true;
    ignoreLid = true;
  };
}
