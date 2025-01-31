{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hnx.programs.alacritty;
in {
  options.hnx.programs.alacritty = with types; {
    enable = mkEnableOption "Enable Alacritty";
  };

  config = mkIf cfg.enable {
    # https://alacritty.org/config-alacritty.html
    programs.alacritty = {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        window = {
          dynamic_padding = true;
          decorations = "None";
          opacity = 0.60;
          blur = true;
          startup_mode = "Maximized";
          decorations_theme_variant = "Dark";
        };
        selection = {
          save_to_clipboard = true;
        };
        cursor = {
          style = {
            blinking = "On";
          };
        };
        keyboard = {
          bindings = [
            {
              key = "N";
              mods = "Control|Shift";
              action = "CreateNewWindow";
            }
            {
              # F11 = Toggle Fullscreen
              key = "F11";
              action = "ToggleFullscreen";
            }
          ];
        };
      };
    };
  };
}
