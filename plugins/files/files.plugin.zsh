files(){
  while read ext; do
    find . -type f -name "*.$ext"
  done < <(for i in $@; do echo $i; done)
}
