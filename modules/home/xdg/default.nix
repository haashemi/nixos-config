{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.xdg;
in {
  options.hnx.xdg = with types; {
    updateUserDirs = mkEnableOption "Update XDG User directories from ~/ to ~/Home";
  };

  config = {
    xdg = {
      userDirs = mkIf cfg.updateUserDirs {
        enable = true;
        createDirectories = true;
        desktop = "${config.home.homeDirectory}/Home/Desktop";
        documents = "${config.home.homeDirectory}/Home/Documents";
        download = "${config.home.homeDirectory}/Home/Downloads";
        music = "${config.home.homeDirectory}/Home/Music";
        pictures = "${config.home.homeDirectory}/Home/Pictures";
        publicShare = "${config.home.homeDirectory}/Home/Public";
        templates = "${config.home.homeDirectory}/Home/Templates";
        videos = "${config.home.homeDirectory}/Home/Videos";
      };
    };
  };
}
