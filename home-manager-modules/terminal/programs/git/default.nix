{ ... }:

{
    programs.git = {
        enable = true;
        userName = "Kyle Ross";
        userEmail = "github@kylejamesross.com";
        aliases = {
            a = "add -A";
            c = "commit";
            co = "checkout";
            b = "branch";
            mc = "merge --continue";
            lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
            ac = "!git add -A && git commit -m";
            po = "push origin";
            ph = "push origin HEAD";
            wl = "worktree list";
            wa = "worktree add";
            wr = "worktree remove";
        };
        extraConfig = {
            core = {
                editor = "nvim";
                autoctlf = "input";
                eol = "lf";
            };
            pull.rebase = false;
            push.autoSetupRemote = true;
            pager = {
                branch = false;
                log = false;
            };
            web.browser = "firefox";
            browser.firefox.cmd = "firefox";
            init.defaultBranch = "main";
        };
    };
}
