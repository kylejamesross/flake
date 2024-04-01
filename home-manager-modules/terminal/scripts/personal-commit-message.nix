{ pkgs }:

pkgs.writeShellScriptBin "personal-commit-message" ''

code_changes=$(${pkgs.git}/bin/git diff --minimal --cached | head -c 4100)

commit_message=$(${pkgs.shell_gpt}/bin/sgpt --no-cache "Write a commit message in this format, do not show diffs of code:
Short summary (50 chars or less) of code changes
<newline>
Detailed explanation of the code changes (300 chars or less), wrap at 72 chars, Put in bullet point format

From these code changes: 

<START OF CODE CHANGES>

$code_changes

<END OF CODE CHANGES>

")

printf "%s\n" "$commit_message"
''
