{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./plymouth.nix
    ./silent.nix
  ];

  options.hx.boot = {
    enableModifications = lib.mkEnableOption "Enable default boot configurations";
  };

  config = lib.mkIf (config.hx.boot.enableModifications) {
    # Kernel choice:  https://wiki.archlinux.org/title/Kernel
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot.enable = true;
        systemd-boot.editor = false;
      };
    };
  };
}
