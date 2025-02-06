{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.boot.silent;
in {
  options.hx.boot.silent = {
    enable = mkEnableOption "Enable silent boot";
  };

  config = lib.mkIf (cfg.enable) {
    # https://wiki.archlinux.org/title/Silent_boot
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;

      kernel.sysctl = {
        "kernel.printk" = "3 3 3 3";
      };

      kernelParams = [
        "quiet"
        "loglevel=0"
        "boot.shell_on_fail"
        "rd.udev.log_level=0"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];

      loader = {
        timeout = 0;
      };
    };
  };
}
