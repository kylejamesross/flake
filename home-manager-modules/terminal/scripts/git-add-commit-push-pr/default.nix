{ pkgs }:

pkgs.writeShellScriptBin "gacp" ''

${pkgs.git}/bin/git add -A

${pkgs.git}/bin/git diff-index --quiet HEAD || ${pkgs.git}/bin/git commit -e -m "$(work-commit-message)"

if [ $? -eq 1 ]; then
    exit 1
fi

commit_message=$(${pkgs.git}/bin/git log -1 --pretty=%B)

title=$(echo "$commit_message" | head -n 1)
body=$(echo "$commit_message" | tail -n +2)

${pkgs.git}/bin/git push origin HEAD

base_branch=$(${pkgs.git}/bin/git rev-parse --abbrev-ref @{upstream} | ${pkgs.gnused}/bin/sed 's/origin\///')
head_branch=$(${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD)

pr_url=$(${pkgs.gh}/bin/gh pr create --title "$title" --body "$body" --head "$head_branch" --base "$base_branch" | tail -n 1)

if [ $? -eq 1 ]; then
    exit 1
fi

echo "$title - $pr_url" | wl-copy

${pkgs.git}/bin/git web--browse "$pr_url"

''
