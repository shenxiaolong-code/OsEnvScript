bash_script_i

# https://tldp.org/LDP/abs/html/internalvariables.html
echo "BASH \t\t: $BASH"
echo "BASH_ENV : $BASH_ENV"
echo "BASH_SUBSHELL : $BASH_SUBSHELL"
echo "BASHPID : $BASHPID"
echo "BASH_VERSINFO : $BASH_VERSINFO"
echo "BASH_VERSION : $BASH_VERSION"
echo "CDPATH : $CDPATH"
echo "DIRSTACK : $DIRSTACK"
echo "EDITOR : $EDITOR"
echo "EUID : $EUID"
echo "FUNCNAME : $FUNCNAME"
echo "LINENO : $LINENO"
echo "GLOBIGNORE : $GLOBIGNORE"
echo "GROUPS : $GROUPS"
echo "HOME : $HOME"
echo "HOSTNAME : $HOSTNAME"
echo "HOSTTYPE : $HOSTTYPE"
echo "IFS : $IFS"
echo "IGNOREEOF : $IGNOREEOF"
echo "LC_COLLATE : $LC_COLLATE"
echo "LC_CTYPE : $LC_CTYPE"
echo "MACHTYPE : $MACHTYPE"
echo "OLDPWD : $OLDPWD"
echo "OSTYPE : $OSTYPE"
echo "PATH : "
echo "PIPESTATUS : $PIPESTATUS"

echo "PID of this script: $$"
# PPID stores the process ID of the subshell's parent process
echo "PPID of this script: $PPID"

echo "PROMPT_COMMAND : $PROMPT_COMMAND"
echo "PS1 : $PS1"
echo "PS2 : $PS2"
echo "PS3 : $PS3"
echo "PS4 : $PS4"
echo "PWD : $PWD"
echo "REPLY : $REPLY"
echo "SECONDS : $SECONDS"
echo "SHELLOPTS : $SHELLOPTS"
echo "SHLVL : $SHLVL"
echo "TMOUT : $TMOUT"
echo "UID : $UID"
echo "parameter 0 , 1 , 2 : $0, $1, $2"
echo "parameter count # : $#"
echo "parameter all * : $*"
echo "parameter all @ : $@"

echo
# source  ${BASH_DIR}/test/all_builtin_internal_variable.sh 1 2 3
echo "#     : $#                  // number of parameters"
echo "*     : $*                  // all parameters as a single string"
echo "@     : $@                  // all parameters as a list"
echo "@:1   : ${@:1}              // all parameters from 1"
echo "@:1:2 : ${@:1:2}            // all parameters from 1 to 2"
echo "@:2   : ${@:2}              // all parameters from 2"
echo "-     : $-                  // options set by the shell"
echo "!     : $!                  // process id of the last background command"
echo "_     : $_                  // the last argument of the previous command"
echo "?     : $?                  // exit status of the last command"
echo "\$     : $$                  // process id of the current shell"

echo
echo "built-in variable(r/w) : https://tldp.org/LDP/abs/html/internalvariables.html"
echo "built-in option  (r  ) : https://tldp.org/LDP/abs/html/options.html#OPTIONSREF"
echo "built-in escape char   : https://tldp.org/LDP/abs/html/special-chars.html#BRACEEXPREF"


echo
bash_script_o
