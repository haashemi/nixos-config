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

    programs = {
      hyprland = {
        enable = true;
        systemd.setPath.enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      waybar.enable = true;
      nm-applet.enable = true;
    };

    environment.systemPackages = with pkgs; [
      grim # Screenshot: Grab images from a Wayland compositor
      slurp # Screenshot: Select a region in a Wayland compositor
      dunst # Notification daemon
      udiskie # Removable disk automounter
      nautilus # File manager
      cliphist # Clipboard manager
      hyprpaper # Wayland wallpaper utility
      overskride # Bluetooth and Obex client
      wl-clipboard # Clipboard manager
      rofi-wayland # Window switcher / App runner
      brightnessctl # Device brightness controller
      hyprpolkitagent # Authentication agent
      playerctl # Waybar/MPRIS: media player controller
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
