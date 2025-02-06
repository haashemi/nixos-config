{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.themes;
in {
  options.hx.themes = {
    enable = mkEnableOption "Enable theme configurations";
  };

  config = mkIf (cfg.enable) {
    qt = {
      enable = true;
      style = "adwaita-dark";
      platformTheme = "qt5ct";
    };

    environment.systemPackages = with pkgs; [
      nordic
      nwg-look
    ];
  };
}
