{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.hardware.bluetooth;
in {
  options.hx.hardware.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth";
  };

  # TODO: More experiments required
  # https://nixos.wiki/wiki/Bluetooth
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          # Enable A2DP Sink
          Enable = "Source,Sink,Media,Socket";
          # Showing battery charge of bluetooth devices
          Experimental = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # Bluetooth GUI client
      overskride
    ];
  };
}
