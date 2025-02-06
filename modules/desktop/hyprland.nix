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
      hyprlock # Lock screen
      hypridle # Idle manager
      hyprpaper # Wallpaper manager
      polkit_gnome # Authentication agent
      rofi-wayland # Application launcher
      brightnessctl # Brightness controller

      ############
      # Screenshot
      grim
      slurp

      ###################
      # Clipboard manager
      cliphist
      wl-clipboard

      #######################
      # Common applications
      overskride # Bluetooth client
      pavucontrol # Sound control
      xfce.thunar # Filebrowser
    ];

    # Authentication agents
    security.polkit.enable = true;
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
