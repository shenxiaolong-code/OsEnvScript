
# bash reset all environment variables
# https://stackoverflow.com/questions/9671027/sanitize-environment-with-command-or-bash-script


env -i bash -c  "source ${HOME}/.bashrc"


# env -i bash -c 'printf "%s\n" "${?+?=$?}" "${#+#=$#}" "${*+*=$*}" "${@+@=$@}" "${-+-=$-}" "${!+!=$!}" "${_+_=$_}" "${$+$=$$}"; env'

