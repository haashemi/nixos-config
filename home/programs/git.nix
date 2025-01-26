{...}: {
  programs.git = {
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
}
