{ pkgs }:

pkgs.writeShellScriptBin "gacp" ''

${pkgs.git}/bin/git add -A

${pkgs.git}/bin/git commit -e -m "$(work-commit-message)"

if [ $? -eq 1 ]; then
    exit 1
fi

commit_message=$(${pkgs.git}/bin/git log -1 --pretty=%B)

title=$(echo "$commit_message" | head -n 1)
body=$(echo "$commit_message" | tail -n +2)

${pkgs.git}/bin/git push origin HEAD

pr_url=$(${pkgs.gh}/bin/gh pr create --title "$title" --body "$body" | tail -n 1)

echo "$title - $pr_url" | wl-copy

${pkgs.git}/bin/git web--browse "$pr_url"

''