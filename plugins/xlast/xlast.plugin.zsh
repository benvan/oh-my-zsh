#!/bin/bash

# USAGE: 
#     xlast [TARGET]    - extract most recently modified file in $ZSH_XLAST_DEFAULT_SOURCE_DIR into TARGET directory
#     xlast -c [TARGET] - extract most recently modified file in the current directory into TARGET directory

# attempts to extract the last file you downloaded / touched
# by looking either in $ZSH_XLAST_DEFAULT_SOURCE_DIR or a directory 
# specified via the -c option

xlast(){
  into=$1
  downdir=~/downloads
  last=$(ls $downdir -t | head -n1)

  if [[ ! -d $into ]]; then
    mkdir $into;
  fi

  case "$last" in
    *.zip )
      unzip "$downdir/$last" -d $1;;
    *.tar.gz )
      tar -xvzf "$downdir/$last" -C $1;;
    *.tar.bz2 )
      tar -xvjf "$downdir/$last" -C $1;;
     *.tar )
      tar -xvf "$downdir/$last" -C $1;;
    *.rar )
      unrar x "$downdir/$last" $1;;
    * )
      echo "couldn't recognise filetype ($last)" ;;
  esac
}
