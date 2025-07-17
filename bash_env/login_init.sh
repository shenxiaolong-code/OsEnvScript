bash_script_i_blue
# source  s1.sh          // don't start new process
# .       s1.sh          // don't start new process
# bash    s1.sh          //       start new process
# ./s1.sh                //       start new process

# best shell script practice : use upper-case in shell env script.  in lower-case in user cmd script.

# verify the environment variables
# EXT_DIR is set in ${EXT_DIR}shell_script/bash_env/init/script_path_config.sh
[[ ! -d ${EXT_DIR} ]]  && {
    command echo -e "\e[1;31mError : \e[1;34mSCRATCH_DIR does not exist: \e[0;33m${EXT_DIR}\e[0;0m"    
    return 1
}

source  ${BASH_DIR}/init/init_color_variables.sh
source  ${BASH_DIR}/init/init_color_variables_sed.sh noShow
source  ${BASH_DIR}/init/alias_quick_path.sh
source  ${BASH_DIR}/init/options_bash_env.sh
source  ${BASH_DIR}/init/alias_color.sh
source  ${BASH_DIR}/app/vscode/vscode_shell_integration.sh
# source  ${BASH_DIR}/app/ai_cursor/alias_ai_cursor.sh
source  ${BASH_DIR}/init/alias_and_function.sh
source  ${BASH_DIR}/init/alias_find_file_or_text.sh
source  ${BASH_DIR}/app/git/git_alias.sh
source  ${BASH_DIR}/app/svn/alias_svn.sh
source  ${BASH_DIR}/app/cmake/alias_cmake_build.sh
source  ${BASH_DIR}/app/python/alias_python.sh
source  ${BASH_DIR}/init/init_linux_cpp_pratice.sh

# https://phoenixnap.com/kb/change-bash-prompt-linux
# https://linuxhint.com/bash-ps1-customization/
# export PS1="[${purple}\t${green} \u@\h${cyan} \w${end}]${brown}[\s-\v]${red}\$ ${end}"
# \e[0; : set prompt
# \e[2; : set title

# \w : full path  ;  \W : folder name
# \u : xiaolongs  ;  \h : sc-xterm-84
# \t : 00:29:21   ;  \T : 12:29:52

# \w always show ~ short path if in home dir , $(pwd -L) will show full path
# export PS1_RAW="[ ${blue}\h ${purple}\T${green} \w${end} ][ ${brown}\s-\v${end} ]\n${red}\$ ${end}"
# export PS1=${PS1_RAW}
export PROMPT_COMMAND='PS1="[ ${blue}\h ${purple}\T${green} $(pwd -L)${end} ][ ${brown}\s-\v${end} ]\n${red}\$ ${end}"'

: '
my_customized_prompt() {
  printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"
}
PROMPT_COMMAND=my_customized_prompt
'

bash_script_o

