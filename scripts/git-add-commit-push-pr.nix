
{ pkgs }:

pkgs.writeShellScriptBin "gcp" ''

commit_message=$(work-commit-message)

title=$(echo "$commit_message" | head -n 1)
body=$(echo "$commit_message" | tail -n +2)

git add .
git commit -m "$commit_message"

git push origin HEAD

pr_url=$(${pkgs.gh}/bin/gh pr create --web --title "$title" --body "$body" -b origin/main -h HEAD | tail -n 1)
echo "$title: $pr_url" | wl-copy
git web--browse "$pr_url"

''

