{
  pkgs,
  consts,
  ...
}: {
  imports = [
    ./programs/alacritty.nix
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/nh.nix
    ./programs/ranger.nix
  ];

  home.username = consts.username;
  home.homeDirectory = "/home/${consts.username}";

  # home.file = {};
  # home.keyboard = {};

  # Enable KDE Connect
  services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
