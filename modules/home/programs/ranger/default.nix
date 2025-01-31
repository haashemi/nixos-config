{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.ranger;
in {
  options.hnx.programs.ranger = with types; {
    enable = mkEnableOption "Enable ranger";
  };

  config = mkIf cfg.enable {
    programs.ranger = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };
  };
}
