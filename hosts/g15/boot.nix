{pkgs, ...}: {
  # Plymouth:       https://wiki.archlinux.org/title/Plymouth
  # Silent boot:    https://wiki.archlinux.org/title/Silent_boot
  # Kernel choice:  https://wiki.archlinux.org/title/Kernel
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;

    # TODO: Learn more about bootspec.
    # It seems good to be enabled, idk.
    bootspec.enableValidation = true;

    kernel.sysctl = {
      "kernel.printk" = "3 3 3 3";
    };

    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "quiet"
      "splash"
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

      timeout = 0;
    };

    plymouth = {
      enable = true;
      extraConfig = ''
        UseFirmwareBackground=true
      '';
    };
  };
}
