if [[ "$(tty)" == "/dev/tty1" ]] then
    startx
else
    colorscript -r
    export ZSH="$HOME/.oh-my-zsh"
    ZSH_THEME="gnzh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c9c9c9"
    plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)
    source $ZSH/oh-my-zsh.sh
fi
