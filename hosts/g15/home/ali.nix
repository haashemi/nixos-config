{
  impurity,
  pkgs,
  ...
}: {
  # TODO: dconf.settings = {};
  # TODO: editorconfig = { };
  # TODO: fonts.fontconfig = {};
  # TODO: gtk = {};

  home = {
    # TODO: link all config files with this.
    file = {
      ".config/zed/settings.json".source = impurity.link ../../../dotfiles/zed/settings.json;
    };

    username = "ali";
    homeDirectory = "/home/ali";

    # TODO: Maybe use this instead of nixos one?
    # keyboard = {
    #   layout = "";
    #   model = "";
    #   options = [];
    #   variant = "";
    # };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    };
  };

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
              # CTRL + SHIFT + N = New Window
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

    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
      viAlias = true;
      vimAlias = true;
    };

    nh = {
      enable = true;
      flake = "/home/ali/nixos";
    };

    ranger = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };
  };

  services = {
    kdeconnect = {
      enable = true;
      package = pkgs.kdePackages.kdeconnect-kde;
    };
  };

  systemd = {
    # Nicely reload system units when changing configs
    user.startServices = "sd-switch";
  };

  # TODO: wayland = {};
  # TODO: xdg = {};
  # TODO: xsession = {};
}
