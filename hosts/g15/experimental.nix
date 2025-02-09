{winapps, ...}: {
  # Experiment: QEMU/KVM: Literally the best way of virtualization
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  # Experiment: WinApps: Windows applications on Linux
  environment.systemPackages = [
    winapps.winapps
    winapps.winapps-launcher
  ];
}
