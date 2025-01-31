{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.nh;
in {
  options.hnx.programs.nh = with types; {
    enable = mkEnableOption "Enable nh";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "/home/ali/nixos";
    };
  };
}
