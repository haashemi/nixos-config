{
  pkgs,
  consts,
  ...
}: {
  # TODO:
  # dconf.settings = {};

  # TODO:
  # editorconfig = {
  #   enable = true;
  #   settings = {};
  # };

  # TODO: Is it useful?
  # fonts.fontconfig = {};

  # TODO: Should I?
  # gtk = {};

  home = {
    # TODO: link all config files with this.
    # file = {};

    username = consts.username;
    homeDirectory = "/home/${consts.username}";

    # TODO: Maybe use this instead of nixos one?
    # keyboard = {
    #   layout = "";
    #   model = "";
    #   options = [];
    #   variant = "";
    # };

    # TODO: Maybe use this instead of nixos one?
    # language = {
    #   address = "";
    #   base = "";
    #   collate = "";
    #   ctype = "";
    #   measurement = "";
    #   messages = "";
    #   monetary = "";
    #   name = "";
    #   numeric = "";
    #   paper = "";
    #   telephone = "";
    #   time = "";
    # };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
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
          style = {blinking = "On";};
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
      flake = "/home/${consts.username}/nixos";
    };

    ranger = {
      enable = true;
      settings = {
        show_hidden = true;
      };
    };
  };

  # TODO: Should I?
  # qt = {
  #   enable = true;
  # };

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

  # TODO:
  # wayland
  # xdg
  # xsession
}
