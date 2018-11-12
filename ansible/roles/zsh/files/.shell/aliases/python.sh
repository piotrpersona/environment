function pypkg() {
  if [[ -z ${1} ]] then; echo "Please provide package name"; fi
  mkdir ${1} && touch ${1}/__init__.py
}
