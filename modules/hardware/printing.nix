{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.hardware.printing;
in {
  options.hx.hardware.printing = {
    enable = mkEnableOption "Enable Printing";
  };

  # https://nixos.wiki/wiki/Printing
  config = mkIf cfg.enable {
    services.printing = {
      enable = true;

      drivers = with pkgs; [
        # For: HP LaserJet Pro m12a
        foo2zjs
      ];
    };

    hardware.printers = {
      ensureDefaultPrinter = "HP_LaserJet_Pro_M12a";

      ensurePrinters = [
        {
          name = "HP_LaserJet_Pro_M12a";
          description = "HP LaserJet Pro M12a";
          deviceUri = "usb://HP/LaserJet%20Pro%20M12a?serial=0000000005P048HGPR1a";
          location = "Local Printer";
          # Model found using 'lpinfo -m'
          model = "HP-LaserJet_Pro_M12a.ppd.gz";
          # Options found using 'lpoptions -l'
          ppdOptions = {
            PageSize = "A4";
          };
        }
      ];
    };
  };
}
