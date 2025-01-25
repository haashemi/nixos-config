{
  pkgs,
  consts,
  ...
}: {
  home.username = consts.username;
  home.homeDirectory = "/home/${consts.username}";

  # home.file = {};
  # home.keyboard = {};

  programs = {
    alacritty = {
      enable = true;
      # https://alacritty.org/config-alacritty.html
      settings = {
        env.TERM = "xterm-256color";
        window.opacity = 0.65;
        window.blur = true;
        window.startup_mode = "Maximized";
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
    };

    nh = {
      enable = true;
      flake = "/home/${consts.username}/nixos";
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
