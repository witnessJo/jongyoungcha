export GOROOT=$HOME/goroot
export GOPATH=$HOME/gopath
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOPATH/src/github.com/richard-themediumio/fabric-samples/bin
# export PATH=$PATH:$HOME/gowork/fabric-kubernetes-tutorial/fabric-samples/bin
export PATH=$PATH:$HOME/gowork/fabric-samples/bin
export GO111MODULE=on

alias k='kubectl'
# alias docker='podman'
alias g='git'
alias emc='emacsclient -c'
alias netstat-listen='sudo lsof -iTCP -sTCP:LISTEN -n -P'

reload-pro() {
  source ~/jongyoungcha/.profile 
}

kill-emacs() {
  ps -ef | grep emacs | awk '{ print $2 }' | xargs kill -2
}

podman-vm-start() {
  podman machine start
}

podman-vm-stop() {
  podman machine stop
}

podman-vm-rm() {
  podman machine rm
}

podman-vm-init() {
  podman machine init --cpus=3 --memory 3700
}

minikube-start() {
  minikube start \
           --driver docker \
           --container-runtime=containerd \
           --mount --mount-string="/Users/jongyoungcha/volumes/share:/Users/jongyoungcha/volumes/share"
  # minikube ssh sudo mkdir -p /Users/jongyoungcha/volumes/share
  # minikube ssh sudo mkdir -p /Users/jongyoungcha/volumes/block
  # kubectl apply -f $HOME/jongyoungcha/minikube-mount.yaml
}

minikube-delete() {
  minikube delete
}

#vterm configurations
vterm_printf(){
  if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
    # Tell tmux to pass the escape sequences through
    printf "\ePtmux;\e\e]%s\007\e\\" "$1"
  elif [ "${TERM%%-*}" = "screen" ]; then
    # GNU screen (screen, screen-256color, screen-256color-bce)
    printf "\eP\e]%s\007\e\\" "$1"
  else
    printf "\e]%s\e\\" "$1"
  fi
}

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%m:%2~\a" }

vterm_prompt_end() {
  vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

vterm_cmd() {
  local vterm_elisp
  vterm_elisp=""
  while [ $# -gt 0 ]; do
    vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
    shift
  done
  vterm_printf "51;E$vterm_elisp"
}


find_file() {
  vterm_cmd find-file "$(realpath "${@:-.}")"
}

open_file_below() {
  vterm_cmd find-file-below "$(realpath "${@:-.}")"
}

say() {
  vterm_cmd message "%s" "$*"
}
