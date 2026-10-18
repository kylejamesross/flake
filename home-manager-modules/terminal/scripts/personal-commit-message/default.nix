{pkgs}:
pkgs.writeShellApplication {
  name = "personal-commit-message";
  runtimeInputs = with pkgs; [
    aichat
    coreutils
    git
  ];
  text = ''
    code_changes=$(git diff --minimal --cached | head -c 4100 || true)

    commit_message=$(aichat "Write a commit message in this format, do not show diffs of code:
    Short summary (50 chars or less) of code changes
    <newline>
    Detailed explanation of the code changes (300 chars or less), wrap at 72 chars, Put in bullet point format

    From these code changes:

    <START OF CODE CHANGES>

    $code_changes

    <END OF CODE CHANGES>

    ")

    printf "%s\n" "$commit_message"
  '';
}
