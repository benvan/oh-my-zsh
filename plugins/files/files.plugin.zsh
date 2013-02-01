files(){
  while read ext; do
    find . -name "*.$ext"
  done < <(for i in $@; do echo $i; done)
}
