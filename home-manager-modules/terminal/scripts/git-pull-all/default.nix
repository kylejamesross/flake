{pkgs}:
pkgs.writeShellScriptBin "git-pull-all" ''

  directories=$(${pkgs.fd}/bin/fd . "/home/$USER/source" --min-depth 1 --max-depth 2 --type d --exec sh -c 'test -e "$1/.git" && echo "$1"' sh {} \;)

  for folder in $directories
  do
      cd "$parent_directory/$folder"
      ${pkgs.git}/bin/git pull -q
      if [ $? -eq 0 ]; then
          echo "Git pull executed successfully for $folder"
      else
          echo -e "\e[1;31m Git pull executed incorrectly for $folder \e[0m"
      fi
  done

''
