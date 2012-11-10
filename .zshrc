fortune #| ponysay
autoload -U compinit promptinit
compinit
promptinit
export PATH="${HOME}/.cabal/bin:${HOME}/bin:${PATH}"

xrdb ~/.Xresources
xrdb -merge ~/.colours/nickfletcher


function ls_no_nl() {
    ls $@ | tr '\n' ' '
}

function record_all {
   ffmpeg -f alsa -i pulse -f pulse -i default -f x11grab -s "1280x736" -r 10 -i :0.0 -vcodec libvpx -s "835x480" -acodec libvorbis -ab 128k -filter_complex amix $@.webm
}

alias singlescreen="xrandr --output CRT1 --off"
alias alsi="alsi -a -u"
alias smi="sudo make install"
alias xc="xclip -selection c"
alias savelog="xclip -out >> ~/misc/logs/'`date`'"
alias tdorg="ssh rat@trumpetdust.org"
alias tdorg-root="ssh root@trumpetdust.org"
alias zshc='vim ~/.zshrc'
alias steam-wine='wine ~/.wine/drive_c/steam/Steam.exe'
alias winefiles="cd ~/.wine/drive_c/"
alias tf2stuff="cd ~/.wine/drive_c/steam/steamapps/fucktheshutup/team\ fortress\ 2/tf"

alias pain='sudo pacman-color -S'
alias pareps='sudo pacman-color -Ss'
alias parem='sudo pacman-color -Rs'
alias padb='sudo pacman-color -Sy'
alias paupd='sudo pacman-color -Syu'

alias yain='yaourt -S'
alias yareps='yaourt -Ss'
alias yarem='yaourt -Rs'
alias yadb='yaourt -Sy'
alias yaupd='yaourt -Syu'

alias colours3='for code in {000..255}; do echo -en "\e[38;05;${code}m ██ $code "; done ; echo ""'

alias vimtest='vim ~/code/ii/ii.c'

alias ls2="ls_no_nl"

alias mc-backup="cd ~/games/minecraft/tekkit/server && tar -cjf backups/`date|tr ' :' '-'`.tar.bz2 world"

setprompt () {

    setopt prompt_subst

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_END=${altchar[u]:--}
    PR_LBRACK="["
    PR_RBRACK="]"

    PROMPT='$PR_SET_CHARSET\
$PR_BLACK┌─$PR_LBRACK\
$PR_RED%n$PR_WHITE@$PR_RED%m$PR_BLACK:$PR_CYAN%l$PR_BLACK:$PR_GREEN%~\
$PR_BLACK$PR_RBRACK
└─$PR_WHITE> $PR_NO_COLOUR'

    RPROMPT='$PR_GREEN%T$PR_NO_COLOUR'
}
setopt interactivecomments
setprompt
alias pingtest="ping 8.8.8.8"
