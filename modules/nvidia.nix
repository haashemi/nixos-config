{
  lib,
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
          # TODO: Set these from the host!
          amdgpuBusId = "PCI:6:0:0";
          nvidiaBusId = "PCI:1:0:0";

          # Not sure which one is better.
          sync.enable = true;
          # offload = {
          #   enable = true;
          #   enableOffloadCmd = true;
          # };
        };
      };

      # TODO: Maybe move it to a `docker.nix`-like file?
      nvidia-container-toolkit = {
        enable = true;
      };
    };

    services.xserver = {
      videoDrivers = ["nvidia"];
    };
  };
}
