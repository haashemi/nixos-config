{ pkgs, consts, ... }:
{
  imports = [ ../modules/home-manager/programs.nix ];

  home = {
    username = consts.username;
    homeDirectory = "/home/${consts.username}";
  };

  home.packages = with pkgs; [
    nixd
    # nodejs
    # corepack
    # zed-editor

    nekoray
    # tidal-hifi
    google-chrome
    telegram-desktop
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
