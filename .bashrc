alias de='cd ~/Desktop'
alias cop=!"git branch --all | tr -d '* ' | grep -v -e '->' | peco | sed -e 's+remotes/[^/]*/++g' | xargs git checkout"
