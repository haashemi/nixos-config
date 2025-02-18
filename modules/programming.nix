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
      sqlc
      goose
      go-task

      # Code editors
      vscode

      # Programming languages
      ## Go
      go
      ## NodeJS
      pnpm
      nodejs
      ## Nix
      nixd
      alejandra
      ## Hyprland
      hyprls

      # Hmmmm...
      postgresql_16
    ];
  };
}
