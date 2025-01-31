{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.mpv;
in {
  options.hnx.programs.mpv = with types; {
    enable = mkEnableOption "Enable MPV";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
