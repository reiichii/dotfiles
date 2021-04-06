[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias de='cd ~/Desktop'
alias et='pet exec'
alias es='pet search'

# スクリプト読み込み
#source $HOME/.git-completion.bash
#source $HOME/.git-prompt.sh

# プロンプトに各種情報を表示
#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWUPSTREAM=1
#GIT_PS1_SHOWUNTRACKEDFILES=
#GIT_PS1_SHOWSTASHSTATE=1

alias de='cd ~/Desktop'
alias gch='git checkout $(git branch | peco)'

function ccd {
    local dir="$( ls -1d */ | peco )"
    if [ ! -z "$dir" ] ; then
        cd "$dir"
    fi
}

#修正しないと選択したコマンドが実行されない
peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'


