{ ... }:

{
    programs.lazygit = {
        enable = true;
        settings = {
            os = {
                edit = "if [ -n \"$TMUX\" ]; then tmux neww -S -n '' nvim --server $(pwd) --remote {{filename}}; else nvim --server $(pwd) {{filename}}; fi";
            };
            promptToReturnFromSubprocess = false;
        };
    };
}
