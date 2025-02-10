{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.hx.asusLinux;
in {
  options.hx.asusLinux = {
    enableAll = mkEnableOption "Enable all asusLinux services";
    asusd = mkEnableOption "Enable asusd service";
    supergfxd = mkEnableOption "Enable supergfxd service";
  };

  # https://asus-linux.org/guides/nixos/
  config = {
    services = {
      asusd = mkIf (cfg.asusd || cfg.enableAll) {
        enable = true;
        enableUserService = true;
      };

      supergfxd = mkIf (cfg.supergfxd || cfg.enableAll) {
        enable = true;
      };
    };
  };
}
