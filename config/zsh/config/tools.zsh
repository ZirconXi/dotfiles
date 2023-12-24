# =========================================================== #
# Tools
# =========================================================== #

# git
# =========================================================== #

zinit wait lucid for \
    OMZL::git.zsh \
  atload'unalias grv' \
    OMZP::git \
    OMZP::gitignore \

# lazygit
zinit ice lucid as'program' from'gh-r' bpick'lazygit*'
zinit light jesseduffield/lazygit

# fzf
# =========================================================== #

# installation
zinit ice lucid as'program' from'gh-r' pick'fzf'
zinit light junegunn/fzf

# yq
# =========================================================== #

# installation
zinit ice lucid as'program' from'gh-r' bpick'yq*' mv'yq* -> yq'
zinit light mikefarah/yq

# tre
# =========================================================== #

zinit ice lucid as'program' from'gh-r' bpick'tre*' \
  atload'
    tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; };
    alias tre1="tre -l 1";
    alias tre2="tre -l 2";
    alias tre3="tre -l 3";
  '
zinit light dduan/tre

# tldr
# =========================================================== #

zinit ice lucid has'tldr' \
    atload'alias tldr="tldr --theme ocean"'
zinit light zdharma-continuum/null

# df
# =========================================================== #

zinit ice lucid has'df' atload'alias df="df -h"'
zinit light zdharma-continuum/null

# du
# =========================================================== #

zinit ice lucid has'du' \
  atload'
    alias du="du -h -c";
    # disk usage, human-readable sizes, total only
    alias du1d="du -h -d 1";
    alias du2d="du -h -d 2";
    alias du3d="du -h -d 3";
  '
zinit light zdharma-continuum/null

# trash
# =========================================================== #

zinit ice lucid has'trash' atload'alias rm=trash'
zinit light zdharma-continuum/null

# direnv
# =========================================================== #

zinit ice lucid as'program' from'gh-r' mv'direnv* -> direnv' \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick'direnv' src'zhook.zsh' \
  atinit'
    export DIRENV_CONFIG=${XDG_CONFIG_HOME}/direnv
    mkdir -p ${DIRENV_CONFIG}
  '
zinit light direnv/direnv

# rclone
# =========================================================== #

zinit ice lucid as'program' from'gh-r' bpick'rclone*' \
    mv'rclone-*/rclone -> rclone' pick'rclone' \
    atload'find . -type d -name "rclone-*" -maxdepth 1 -exec rm -r "{}" \;'
zinit light rclone/rclone

# go-task
# =========================================================== #

zinit ice lucid as'program' from'gh-r' bpick'task*'
zinit light go-task/task

# neovim
# =========================================================== #

NVIM_CONF="${XDG_CONFIG_HOME}/nvim"
[ ! -d ${NVIM_CONF}/.git ] && git clone https://github.com/NvChad/NvChad "${NVIM_CONF}" --depth 1

zinit ice lucid has'nvim' atload'alias vim=nvim'
zinit light zdharma-continuum/null

# docker
# =========================================================== #

# docker-compose
zinit ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"docker-compose*"
zinit load docker/compose

# lazydocker
zinit ice lucid as'program' from'gh-r' bpick'lazydocker*'
zinit light jesseduffield/lazydocker

# k8s
# =========================================================== #

# kubectl
if [[ ! -f "${XDG_BIN_HOME}/kubectl" ]]; then
  curl -L https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname | tr "[:upper:]" "[:lower:]")/$(uname -m)/kubectl \
    -o "${XDG_BIN_HOME}/kubectl"
  chmod +x "${XDG_BIN_HOME}/kubectl"
fi

# k9s
zinit ice lucid as'program' from'gh-r' bpick'k9s*'
zinit light derailed/k9s

# pulumi
# =========================================================== #

# installation
zinit ice lucid as'program' from'gh-r' bpick'pulumi*' pick'pulumi/*'
zinit light pulumi/pulumi

# sops
# =========================================================== #

# age
zinit ice lucid as'program' from'gh-r' bpick'age*' pick'age/*'
zinit light FiloSottile/age

# installation
zinit ice lucid as'program' from'gh-r' bpick'sops*' mv'sops* -> sops' pick'sops'
zinit light getsops/sops

# ASDF, https://asdf-vm.com/guide/getting-started.html
# =========================================================== #

ASDF_CONFIG_HOME="${XDG_CONFIG_HOME}/asdf"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${ASDF_CONFIG_HOME}/asdfrc"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-py-packages"
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-go-packages"

zinit ice lucid wait pick'asdf.sh' \
  atload'
    asdf plugin add python https://github.com/asdf-community/asdf-python.git >/dev/null 2>&1
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git >/dev/null 2>&1
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git >/dev/null 2>&1
    asdf plugin add rust https://github.com/asdf-community/asdf-rust.git >/dev/null 2>&1

    # golang
    [[ -f "${ASDF_DATA_DIR}/plugins/golang/set-env.zsh" ]] && source "${ASDF_DATA_DIR}/plugins/golang/set-env.zsh"

    # cargo
    export CARGO_HOME="${XDG_DATA_HOME}/cargo"
    export PATH="${CARGO_HOME}/bin:${PATH}"

    # yarn
    export PATH="${HOME}/.yarn/bin:${PATH}"
  '
zinit light asdf-vm/asdf

# python
# =========================================================== #

zinit wait lucid for \
    OMZP::poetry-env \
    OMZP::python
