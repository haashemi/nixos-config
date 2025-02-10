{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.hardware.audio;
in {
  options.hx.hardware.audio = {
    enable = mkEnableOption "Enable default audio configurations";
  };

  # TODO: More experiments required
  # https://nixos.wiki/wiki/PipeWire
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
