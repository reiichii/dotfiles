# openssl
set -x fish_user_paths /usr/local/opt/openssl@1.1/bin

# pyenv
pyenv init - | source
set -x LDFLAGS "-L/usr/local/opt/bzip2/lib"
set -x CPPFLAGS "-I/usr/local/opt/bzip2/include"

# nodeenv
nodenv init - | source

alias vscode='code ~/ghq/(ghq list | fzf --height 40% --reverse)'

alias fishconf='code ~/.config/fish'
alias fishcp='cp ~/.config/fish/config.fish ~/repo/private/dotfiles/'
alias fishdp='cp ~/repo/private/dotfiles/config.fish ~/.config/fish/config.fish'

# aws
if type aws > /dev/null 2>&1
    # aws profile select
    alias ap='set -xg AWS_DEFAULT_PROFILE (cat ~/.aws/credentials | grep -e "\[\(.*\)\]" | sed -e "s/\[//g" | sed -e "s/\]//g" | sort | fzf)'
    # aws ec2 ip list
    alias ec2='aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | select(.Tags!=null) | [.InstanceId, .PublicIpAddress, .PrivateIpAddress, [.Tags[] | select(.Key == \"Name\").Value][]] | @tsv " | sort -k3'
end

function sandbox
  if string length -q $argv
    set dirname $argv
  else
    set dirname (date "+%Y%m%d-%H%M")
  end

  ghq create $dirname
  code /Users/a999-396/ghq/github.com/a999-396/$dirname
end

# oh-my-fish/theme-default
# ⋊> 09:21:00 ~/dotfiles on master ↑

# You can override some default options with config.fish:
#
# set -g theme_short_path yes

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish     "⋊>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"
  set -l date (date "+%H:%M:%S")

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color $fish_pager_color_progress 2> /dev/null; or set_color cyan)
  set -l success_color    (set_color cyan)
  set -l error_color      (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
  set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)

  if test $last_command_status -eq 0
    echo -n -s $success_color $fish $normal_color
  else
    echo -n -s $error_color $fish $normal_color
  end

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

    echo -n -s " " $date $normal_color
    echo -n -s " " $directory_color $cwd $normal_color
    echo -n -s " on " $repository_color (git_branch_name) $normal_color " "

    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s " " $date $normal_color
    echo -n -s " " $directory_color $cwd $normal_color
  end

  echo -n -s " "
end

function fish_right_prompt
end

