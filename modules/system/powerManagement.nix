{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.system.powerManagement;
in {
  options.hx.system.powerManagement = {
    enable = mkEnableOption "Enable power management";
  };

  # Battery Optimizations: https://nixos.wiki/wiki/Laptop
  config = mkIf (cfg.enable) {
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };

    services = {
      tlp = {
        enable = true;
      };
    };
  };
}
