

{ pkgs }:

pkgs.writeShellScriptBin "gcp" ''

${pkgs.git}/bin/git commit -e -m "$(work-commit-message)"

commit_message=$(${pkgs.git}/bin/git log -1 --pretty=%B)

title=$(echo "$commit_message" | head -n 1)
body=$(echo "$commit_message" | tail -n +2)

${pkgs.git}/bin/git push origin HEAD

pr_url=$(${pkgs.gh}/bin/gh pr create --title "$title" --body "$body" | tail -n 1)

echo "$title - $pr_url" | wl-copy

${pkgs.git}/bin/git web--browse "$pr_url"

''

