{pkgs, ...}: {
  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    nordic
    nwg-look
  ];
}
