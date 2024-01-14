{ pkgs }:

pkgs.writeShellScriptBin "work-commit-message" ''

issue_number=$(git rev-parse --abbrev-ref HEAD | grep -oE '[0-9]+' | head -n 1)
commit_prefix="AB#$issue_number: "
code_changes=$(git diff --minimal --cached | head -c 4100)

base_commit_message=$(${pkgs.shell_gpt}/bin/sgpt "Write a commit message in this format, do not show diffs of code:
Short summary (50 chars or less) of code changes
<newline>
Detailed explanation of the code changes (300 chars or less), wrap at 72 chars, Put in bullet point format

From these code changes: 

<START OF CODE CHANGES>

$code_changes

<END OF CODE CHANGES>

")

commit_message="$commit_prefix$base_commit_message"

printf "%s\n" "$commit_message"
''

