
{ pkgs }:

pkgs.writeShellScriptBin "gcp" ''

commit_message=$(work-commit-message)

git add .
git commit -m "$commit_message"

git push origin HEAD

pr_url=$(${pkgs.hub}/bin/hub pull-request -m "$commit_message" -b origin/main -h HEAD)

echo "$pr_url" | wl-copy

echo "Pull request created: $pr_url"
echo "PR title and link copied to clipboard."
''

