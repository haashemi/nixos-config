{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.gh;
in {
  options.hnx.programs.gh = {
    enable = mkEnableOption "Enable GitHub CLI";
  };

  config = {
    programs.gh = {
      enable = cfg.enable;
      gitCredentialHelper.enable = true;
    };
  };
}
