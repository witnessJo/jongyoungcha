# golang settings
export GOROOT=$HOME/goroot
export GOPATH=$HOME/gopath
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/work/fabric-samples/bin
export GO111MODULE=on

# deno settings
export DENO_DIR=$HOME/Library/Caches/deno
export DENO_INSTALL_ROOT=$HOME/.deno/bin
export PATH=$PATH:$DENO_INSTALL_ROOT

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


