{
  pkgs,
  consts,
  ...
}: {
  # Enable SDDM as DE
  # TODO: Add sddm settings
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;

    autoLogin.enable = true;
    autoLogin.user = consts.username;
  };

  # Enable KDE Plasma 6 as DM
  services.desktopManager.plasma6.enable = true;

  # Remove some optional plasma6 packages.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
    okular
    kate
    khelpcenter
    baloo-widgets
    krdp
  ];
}
