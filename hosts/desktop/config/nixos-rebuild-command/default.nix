
{ ... }: 

{
    config.nixos-rebuild-command = "sudo nixos-rebuild switch --flake .#desktop";
}
