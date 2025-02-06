{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.nvidia;
in {
  options.hx.nvidia = {
    enable = mkEnableOption "Enable nvidia configurations";
    enableToolkit = mkEnableOption "Enable nvidia-container toolkit";
  };

  config = mkIf (cfg.enable) {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = false; # IMO, It's useless!
        package = config.boot.kernelPackages.nvidiaPackages.latest;

        prime = {
          amdgpuBusId = "PCI:6:0:0";
          nvidiaBusId = "PCI:1:0:0";

          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };

      nvidia-container-toolkit = {
        enable = true;
      };
    };

    services.xserver = {
      videoDrivers = ["nvidia"];
    };
  };
}
