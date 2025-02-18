{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.desktop.hyprland;
in {
  options.hx.desktop.hyprland = {
    enable = mkEnableOption "Enable hyprland compositor";
  };

  config = mkIf (cfg.enable) {
    services = {
      displayManager = {
        sddm.enable = true;
        sddm.wayland.enable = true;
      };

      # Secret service
      gnome.gnome-keyring.enable = true;

      # Browsing samba shares (for xfce.thunar)
      gvfs = {
        enable = true;
        package = lib.mkForce pkgs.gnome.gvfs;
      };

      # Auto mount removable disks (for xfce.thunar)
      udisks2 = {
        enable = true;
        mountOnMedia = true;
      };
    };

    programs.hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      dunst # Notification daemon
      waybar # Statusbar
      polkit_gnome # Authentication agent
      rofi-wayland # Application launcher
      brightnessctl # Brightness controller

      #####################
      # Hyprland's packages
      hyprpaper

      ############
      # Screenshot
      grim
      slurp

      ###################
      # Clipboard manager
      cliphist
      wl-clipboard

      ###################
      # Wayland utilities
      playerctl # Used by mpris module

      ###################
      # File manager
      xfce.thunar # Filebrowser
      xfce.tumbler # Thumbnails for thunar
      feh # Image viewer
    ];

    # Not sure if this is actually needed with my dotfiles
    # https://nixos.wiki/wiki/Wayland#Electron_and_Chromium
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Authentication agents
    security.polkit.enable = true;
    systemd.user.services.hyprpolkitagent = {
      description = "hyprpolkitagent";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
