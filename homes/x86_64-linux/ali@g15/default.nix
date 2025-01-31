{lib, ...}:
with lib; {
  home.username = "ali";
  home.homeDirectory = "/home/ali";

  # TODO: dconf.settings = {};
  # TODO: editorconfig = { };
  # TODO: fonts.fontconfig = {};
  # TODO: gtk = {};

  # home.file = {
  #   ".config/zed/settings.json".source = impurity.link ../../../dotfiles/zed/settings.json;
  # };

  # TODO: Maybe use this instead of nixos one?
  # keyboard = {
  #   layout = "";
  #   model = "";
  #   options = [];
  #   variant = "";
  # };

  # My custom modules
  lib.hnx = {
    fullName = "Ali Hashemi";
    email = "mr.ali.haashemi@gmail.com";

    programs.alacritty = enabled;
    programs.gh = enabled;
    programs.git = enabled;
    programs.mpv = enabled;
    programs.neovim = enabled;
    programs.nh = enabled;
    programs.ranger = enabled;

    services.kdeconnect.enable = true;

    xdg.updateUserDirs = true;
  };

  systemd = {
    # Nicely reload system units when changing configs
    user.startServices = "sd-switch";
  };

  # TODO: wayland = {};

  # TODO: xsession = {};

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
