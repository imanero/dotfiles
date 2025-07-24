pokemon-colorscripts -r
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c9c9c9"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
alias vim=nvim
source $ZSH/oh-my-zsh.sh
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
