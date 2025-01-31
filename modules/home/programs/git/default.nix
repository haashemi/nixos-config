{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.git;
in {
  options.hnx = {
    fullName = mkOpt str "" "Your full name";
    email = mkOpt str "" "Your email";
    programs.git = with types; {
      enable = mkEnableOption "Enable Git";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = config.hnx.fullName;
      userEmail = config.hnx.email;
      extraConfig = {
        core = {
          autocrlf = false;
          eol = "lf";
        };
      };
    };
  };
}
