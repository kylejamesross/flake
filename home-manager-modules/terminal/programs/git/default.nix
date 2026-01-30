{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kyle Ross";
        email = "github@kylejamesross.com";
      };
      alias = {
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
        wa = "!f() { git worktree add ../$1 -b $1 $2;  }; f";
        wr = "worktree remove";
      };
      web.browser = "firefox";
      browser.firefox.cmd = "firefox";
      init.defaultBranch = "main";
      difftool = {
        prompt = false;
        nvimdiff.cmd = "nvim -d $LOCAL $REMOTE -c '$wincmd w' -c 'wincmd L'";
      };
      mergetool = {
        keepBackup = false;
        prompt = false;
        nvimdiff4.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
      };
      extraConfig = {
        core = {
          editor = "nvim";
        };
        pull.rebase = false;
        push.autoSetupRemote = true;
        diff.tool = "nvimdiff";
        merge.tool = "nvimdiff4";
        pager = {
          branch = false;
          log = false;
        };
      };
    };

    includes = [
      {
        condition = "gitdir:~/source/phoenix-digitization-widgets/**";
        contents = {
          user = {
            name = "Kyle Ross";
            email = "KRoss@phxtech.com";
          };
        };
      }
    ];
  };
}
