{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.system.audio;
in {
  options.hx.system.audio = {
    enable = mkEnableOption "Enable default audio configurations";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alsa-utils
      pavucontrol
    ];

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
  };
}
