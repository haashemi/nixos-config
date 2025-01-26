{pkgs, ...}: {
  boot = {
    # Clean boot screen [1/3]
    consoleLogLevel = 0;

    # Clean boot screen [2/3]
    initrd.verbose = false;

    # TODO: Learn more about bootspec.
    # It seems good to be enabled, idk.
    bootspec.enableValidation = true;

    # Basically the best linux kernel AFAIK.
    # https://wiki.archlinux.org/title/Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Clean boot screen [3/3]
    # https://wiki.archlinux.org/title/Silent_boot
    kernelParams = [
      "quiet"
      "loglevel=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
    ];

    # UEFI Boot settings
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
      systemd-boot.editor = false;

      timeout = 5;
    };
  };
}
