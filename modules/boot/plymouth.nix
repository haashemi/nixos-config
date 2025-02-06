{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.boot.plymouth;
in {
  options.hx.boot.plymouth = {
    enable = mkEnableOption "Enable plymouth splash";
  };

  config = mkIf (cfg.enable) {
    # https://wiki.archlinux.org/title/Plymouth
    boot.plymouth = {
      enable = true;
      extraConfig = ''
        UseFirmwareBackground=true
      '';
    };
  };
}
