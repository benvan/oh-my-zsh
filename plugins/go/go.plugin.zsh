#!/bin/bash


go(){

  local config=~/.go
  local code
  local target

  if [[ $1 == 'add' ]]; then
    echo $2:`pwd` >> $config
    echo Go $2 "-->" `pwd`
  else
    code=$1
    target=$(cat $config | grep -E "$code.*:" | sed 's/.*://' | head -n1)
    cd $target
  fi
  
}


_go () {
  compadd $( cat ~/.go | grep -oE "^[^:]*" )
}

compdef _go go
