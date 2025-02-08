{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.programming;
in {
  options.hx.programming = {
    enable = mkEnableOption "Enable programming packages";
  };

  config = mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      # Utilities
      gh

      # Code editors
      vscode-fhs

      # Programming languages
      ## Major Languages
      ### Go
      go
      ### NodeJS
      pnpm
      nodejs
      ## Minor languages
      ### Nix
      nixd # Language server
      alejandra # Formatter
      ### Hyprland
      hyprls # Language server
    ];
  };
}
