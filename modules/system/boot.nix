{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.system.boot;
in {
  options.hx.system.boot = {
    enable = lib.mkEnableOption "Enable the boot configurations";
    silent = mkEnableOption "Enable silent boot";
    plymouth = mkEnableOption "Enable plymouth splash";
  };

  # Plymouth:
  #   https://wiki.nixos.org/wiki/Plymouth
  #   https://wiki.archlinux.org/title/Plymouth
  # Silent boot:
  #   https://wiki.archlinux.org/title/Silent_boot
  # Kernel choice:
  #   https://wiki.archlinux.org/title/Kernel
  config = lib.mkIf (cfg.enable) {
    boot = {
      consoleLogLevel = lib.mkIf (cfg.silent || cfg.plymouth) 0;
      initrd.verbose = lib.mkIf (cfg.silent || cfg.plymouth) false;

      kernel.sysctl = lib.mkIf (cfg.silent || cfg.plymouth) {
        "kernel.printk" = "3 3 3 3";
      };

      kernelPackages = pkgs.linuxPackages_zen;

      kernelParams = lib.mkIf (cfg.silent || cfg.plymouth) [
        "quiet"
        "loglevel=0"
        "boot.shell_on_fail"
        "rd.udev.log_level=0"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot.enable = true;
        systemd-boot.editor = false;

        timeout = lib.mkIf (cfg.silent || cfg.plymouth) 0;
      };

      plymouth = lib.mkIf (cfg.plymouth) {
        enable = true;
        extraConfig = ''
          UseFirmwareBackground=true
        '';
      };
    };
  };
}
