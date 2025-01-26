{
  pkgs,
  consts,
  ...
}: {
  imports = [./plasma.nix];

  home.username = consts.username;
  home.homeDirectory = "/home/${consts.username}";

  # home.file = {};
  # home.keyboard = {};

  programs = {
    alacritty = {
      enable = true;
      # https://alacritty.org/config-alacritty.html
      settings = {
        env = {
          TERM = "xterm-256color";
        };
        window = {
          dynamic_padding = true;
          decorations = "Transparent";
          opacity = 0.60;
          blur = true;
          startup_mode = "Maximized";
          decorations_theme_variant = "Dark";
        };
        # bell = {};
        selection = {
          save_to_clipboard = true;
        };
        cursor = {
          style = {blinking = "On";};
        };
        keyboard = {
          bindings = [
            {
              key = "N";
              mods = "Control|Shift";
              action = "CreateNewWindow";
            }
          ];
        };
      };
    };

    # bun = {
    #   enable = true;
    #   enableGitIntegration = true;
    #   settings = {
    #     telemetry = false;
    #   };
    # };

    gh-dash = {
      enable = true;
      # settings = {};
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    git = {
      enable = true;
      userName = "Ali Hashemi";
      userEmail = "mr.ali.haashemi@gmail.com";
      extraConfig = {
        core = {
          autocrlf = false;
          eol = "lf";
        };
      };
    };

    nh = {
      enable = true;
      flake = "/home/${consts.username}/nixos";
    };

    ranger = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };
  };

  # Enable KDE Connect
  services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
