{consts, ...}: {
  programs.nh = {
    enable = true;
    flake = "/home/${consts.username}/nixos";
  };
}
