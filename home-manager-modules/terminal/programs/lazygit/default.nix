{ ... }:

{
    programs.lazygit = {
        enable = true;
        settings = {
            promptToReturnFromSubprocess = false;
            os = {
                edit = "$EDITOR {{filename}}";
            };
        };
    };
}
