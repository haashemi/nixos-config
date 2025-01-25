{ pkgs, ... }:
{
  fonts = {
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
      nerd-fonts.droid-sans-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.roboto-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.sauce-code-pro
    ];

    fontconfig = {
      defaultFonts = {
        serif = [
          "DejaVu Serif"
          "Vazir"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Vazir"
        ];
        monospace = [
          "Input Mono"
          "Vazir Code"
        ];
      };
    };
  };
}
