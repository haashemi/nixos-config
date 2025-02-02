{pkgs, ...}: let
  username = "ali";
in {
  environment.systemPackages = with pkgs; [
    grim # Screenshot: Grab images from a Wayland compositor
    slurp # Screenshot: Select a region in a Wayland compositor
    dunst # Notification daemon
    udiskie # Removable disk automounter
    cliphist # Clipboard manager
    hyprpaper # Wayland wallpaper utility
    overskride # Bluetooth and Obex client
    wl-clipboard # Clipboard manager
    rofi-wayland # Window switcher / App runner
    brightnessctl # Device brightness controller
    hyprpolkitagent # Authentication agent
    playerctl # Waybar/MPRIS: media player controller
  ];

  programs = {
    nm-applet.enable = true;
    hyprland = {
      enable = true;
      systemd.setPath.enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    waybar.enable = true;
  };

  services = {
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;

      autoLogin.enable = true;
      autoLogin.user = username;
    };
  };

  systemd = {
    user.services.hyprpolkitagent = {
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

  # Hyprland
  security = {
    polkit.enable = true;
  };
}
