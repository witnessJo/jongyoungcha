# export KIND_EXPERIMENTAL_PROVIDER=podman

export PV_PATH=$HOME/volumes
export GOPRIVATE=github.com/the-medium-tech/*

alias emvm='ssh mdl-local emacs'

reload-mdl() {
  source ~/jongyoungcha/.mdl.sh 
}

start-image-registry() {
  podman machine start > /dev/null
  podman run --name my-private-registry -d -p 5500:5000 registry > /dev/null
  docker start

  ps -ef | grep '/bin/lt' | awk '{ print $2 }' | xargs kill -2 {}
  
  if [ ! -z $(command -v lt) ]; then
    nohup lt -p 5500 > ~/.lt_last &
  else
    echo "could not find 'lt' command" >& 2
  fi
}
