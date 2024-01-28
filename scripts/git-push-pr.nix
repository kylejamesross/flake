

{ pkgs }:

pkgs.writeShellScriptBin "gp" ''

commit_message=$(git log -1 --pretty=%B)

title=$(echo "$commit_message" | head -n 1)
body=$(echo "$commit_message" | tail -n +2)

git push origin HEAD

pr_url=$(${pkgs.gh}/bin/gh pr create --title "$title" --body "$body" | tail -n 1)

echo "$title - $pr_url" | wl-copy

git web--browse "$pr_url"

''

