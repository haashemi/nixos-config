{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.desktop.plasma6;
in {
  options.hx.desktop.plasma6 = {
    enable = mkEnableOption "Enable KDE Plasma 6 desktop environment";
  };

  config = mkIf (cfg.enable) {
    services = {
      desktopManager.plasma6.enable = true;

      displayManager = {
        sddm.enable = true;
        sddm.wayland.enable = true;
      };
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      okular
      kate
      khelpcenter
      baloo-widgets
      krdp
    ];
  };
}
