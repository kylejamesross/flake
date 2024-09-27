{...}: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      registrations = {
          "<leader>c" = "[C]ode";
          "<leader>d" = "[D]ocument";
          "<leader>r" = "[R]ename";
          "<leader>s" = "[S]earch";
          "<leader>w" = "[W]orkspace";
          "<leader>t" = "[T]oggle";
          "<leader>h" = "Git [H]unk";
      };
    };
  };
}
