{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.hardware.nvidia;
in {
  options.hx.hardware.nvidia = {
    enable = mkEnableOption "Enable nvidia configurations";
    enableToolkit = mkEnableOption "Enable nvidia-container toolkit";
  };

  # https://nixos.wiki/wiki/Nvidia
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
          sync.enable = true;
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
