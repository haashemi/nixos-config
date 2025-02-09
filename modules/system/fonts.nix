{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.hx.system.fonts;
in {
  options.hx.system.fonts = {
    enable = mkEnableOption "Enable font configurations";
  };

  # Original source:
  #   https://github.com/ASafaeirad/NixSkill/blob/ce0f84cc3984a39628b22441ea42bf6f0950bae6/hosts/common/fonts.nix
  config = mkIf (cfg.enable) {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        liberation_ttf
        fira-code
        fira-code-symbols
        courier-prime
        terminus_font
        cascadia-code
        input-fonts
        oxygenfonts
        freefont_ttf
        intel-one-mono

        # Icons
        font-awesome_5
        noto-fonts
        noto-fonts-emoji
        mplus-outline-fonts.githubRelease

        # Persian fonts
        ir-standard-fonts
        vazir-fonts
        vazir-code-font
        shabnam-fonts

        nerd-fonts.fira-code
        nerd-fonts.code-new-roman
        nerd-fonts.droid-sans-mono
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.hack
        nerd-fonts.meslo-lg
        nerd-fonts.roboto-mono
        nerd-fonts.ubuntu-mono
        nerd-fonts.sauce-code-pro
        nerd-fonts.jetbrains-mono
        nerd-fonts.zed-mono
      ];

      fontDir = {
        enable = true;
      };

      fontconfig = {
        defaultFonts = {
          # emoji = [];
          monospace = [
            "Input Mono"
            "Vazir Code"
          ];
          sansSerif = [
            "DejaVu Sans"
            "Vazir"
          ];
          serif = [
            "DejaVu Serif"
            "Vazir"
          ];
        };
      };
    };
  };
}
