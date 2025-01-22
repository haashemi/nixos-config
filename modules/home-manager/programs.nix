{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font.size = 12;
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # programs.aria2.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;

    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };

  programs.btop.enable = true;

  # programs.bun = {
  #   enable = true;
  #   enableGitIntegration = true;
  #   settings = {
  #     telemetry = false;
  #   };
  # };

  programs.fish.enable = true;

  # programs.gh

  programs.git = {
    enable = true;
    userName = "Ali Hashemi";
    userEmail = "mr.ali.haashemi@gmail.com";
  };

  programs.go = {
    enable = true;
    goPrivate = [
      "github.com/haashemi/*"
      "github.com/LlamaNite/*"
    ];
  };

  # programs.hexchat

  programs.home-manager.enable = true;
  programs.htop.enable = true;
  # programs.mpv.enable = true;

  # programs.oh-my-posh

  # programs.tmate.enable = true;

  # programs.tmux = {
  #   enable = true;
  #   mouse = true;
  # };

  programs.vscode.enable = true;
}
