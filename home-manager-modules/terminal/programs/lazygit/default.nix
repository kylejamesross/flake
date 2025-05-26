{...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      notARepository = "quit";
      os = {
        edit = "$EDITOR {{filename}}";
        displayStartupPopups = true;
      };
    };
  };
}
