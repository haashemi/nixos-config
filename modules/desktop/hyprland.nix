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
      rofi-wayland # Application launcher
      brightnessctl # Brightness controller
      hyprpolkitagent # Authentication agent

      ############
      # Screenshot
      grim
      slurp

      ###################
      # Clipboard manager
      cliphist
      wl-clipboard

      #######################
      # Theming
      nordic # GTK 3 theme
      nwg-look # GTK theme

      #######################
      # Common applications
      nautilus # File manager
      overskride # Bluetooth client TODO: Move it somewhere else
      pavucontrol # Sound control TODO: Move it somewhere else

      ###############################
      # TODO: Configure ir
      udiskie # Removable disk automounter
    ];

    # Authentication agents
    security.polkit.enable = true;
    systemd.user.services.hyprpolkitagent = {
      description = "Polkit authentication agent for Hyprland";
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
