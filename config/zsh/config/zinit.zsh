# =========================================================== #
# Zinit                                                       #
# =========================================================== #

# Installation
ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
# =========================================================== #

# LS_COLORS
zinit ice atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

## OMZ Libs and Plugins
zinit wait lucid for \
    OMZL::functions.zsh \
    OMZL::grep.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZP::colored-man-pages \
    OMZP::command-not-found \
    OMZP::copyfile \
    OMZP::copypath \
    OMZP::dirhistory \
    OMZP::extract \
    OMZP::globalias \
    OMZP::history

# fast-syntax-highlighting
zinit ice wait lucid atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# zsh-autopair
zinit light hlissner/zsh-autopair

# zsh-history-substring-search
zinit ice wait lucid atinit'
    zstyle :history-search-multi-word page-size 20
    zstyle :history-search-multi-word highlight-color fg=green,bold
    zstyle :plugin:history-search-multi-word reset-prompt-protect 1'
zinit light zsh-users/zsh-history-substring-search

# agkozak/zsh-z
zinit ice wait lucid atinit'ZSHZ_DATA=${ZDOTDIR}/.z'
zinit light agkozak/zsh-z

# zsh-completions
zinit ice wait lucid atpull'zinit creinstall -q .'
zinit light clarketm/zsh-completions

# Theme
# =========================================================== #

export TERM=xterm-256color

zinit wait'!' lucid for \
    OMZL::git.zsh \
    OMZL::prompt_info_functions.zsh \
    OMZT::ys
