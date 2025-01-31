{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.services.kdeconnect;
in {
  options.hnx.services.kdeconnect = with types; {
    enable = mkEnableOption "Enable KDE Connect";
  };

  config = mkIf cfg.enable {
    services.kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
  };
}
