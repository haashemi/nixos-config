{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.power;
in {
  options.hx.power = {
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
