
# bash ${BASH_DIR}/test/if_else_branch.sh
# below cmd will hit error when use if-else-fi   :  [[: not found
# sh ${BASH_DIR}/test/if_else_branch.sh

# bash : [] VS [[]]　　　：　建议使用 [[]] 
# [[]] 是 bash shell 针对 [] 的扩展。  如果要写严格的 bash 兼容的脚本，那么应该用 [] , 否则建议使用 [[]] 
# 使用 bash 扩展的脚本，前面应该添加： #!/bin/bash    => 但似乎在 bash 环境中其不是必须的？ 不过加上最好。

# https://stackoverflow.com/questions/3427872/whats-the-difference-between-and-in-bash
# 例如：
# 1. 如果文件路径字符串是空的，或者文件路径中包含空格，则使用 [] 必须用引号 "" 把文件路径字符串括起来。 而 [[]] 则不需要
# if [ -f "$file" ]
# if [[ -f $file ]]
# 2. [[]] 中可用  && || <>  来作为逻辑运算的组合，而 [] 则不行，因为 && ||<> 在 [] 中被当作正常的内存命令来对待的，而非逻辑运算符。 在 if 语句中，明显逻辑运算符更符合期望。
# 3. [[]] 的字符串比较中，可以使用正则表达式，则 [] 不支持正则表达式。
#    if [ "$answer" = y -o "$answer" = yes ]      # -o : or
#    if [[ $answer =~ ^y(es)?$ ]]
# 4. [[]] 可以支持部分匹配，则 [] 不支持。 如果下列例子中，如果输入 y , yes 都能匹配成功。
#    if [[ $ANSWER = y* ]]

dump_script_position
true
echo "current exit status (should be 0) : $? "
false 
echo "current exit status (should be 1) : $? "

dump_script_position
# -n STRING  ：检查字符串是否   非空。如果字符串长度非零，则返回真。
# -z STRING  ：检查字符串是否为 空。  如果字符串长度为零，则返回真。
# -v VARIABLE：检查变量是否已被声明（即使其值为空）。如果变量已被声明，则返回真。


# add the path to the PATH and LIBRARY_PATH by app detect
type lli &>/dev/null && dumpinfo "lli is detected" || dumpinfo "lli is not detected"
type lli &>/dev/null || { PATH=${EXT_DIR}/build/mlir_server/bin:$PATH; LIBRARY_PATH=${EXT_DIR}/build/mlir_server/lib:$LIBRARY_PATH; }

# check whether the module is in specific path , to avoid below error:
# llc: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.29' not found (required by llc)
# libstdc++.so.6 => /home/utils/gcc-11.2.0/lib64/libstdc++.so.6 (0x0000155552a6f000)        // it is expected path
# libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fb3a86af000)           // it is not expected path
which llc | grep -q ${EXT_DIR}/build/mlir_server/bin && dumpinfo "llc is in expected path" || dumpinfo "llc is not in expected path"
ldd $(which llc) | grep libstdc++.so.6 | grep -q gcc-11.2.0 && dumpinfo "libstdc++.so.6 is in expected path" || dumpinfo "libstdc++.so.6 is not in expected path"
if ldd $(which llc) | grep libstdc++.so.6 | grep -q gcc-11.2.0  ; then
    echo "libstdc++.so.6 is in expected path"
else
    echo "libstdc++.so.6 is not in expected path"
fi

# if the variable value is empty
# [[ -z $must_has_value ]] && return error_code
# no ${} is needed for variable name
[[ -z empty_value_variable     ]] && echo "empty_value_variable value is empty or not set" || echo "empty_value_variable value is not empty"
[[ -n not_empty_value_variable ]] && echo "not_empty_value_variable value is not empty" || echo "not_empty_value_variable value is empty"

# if variable is defined
# [[ -v debugMode ]]  && echo "debugMode is enabled"
[[ -v undefined_variable ]]  && echo "undefined_variable is defined , but its value is empty " || echo "undefined_variable is undefined"

if ! get_package_url $@ ; then
    dumperr "${green}Fails to get package_url from ${brown}${package_url} ${end}"
fi

dump_script_position
# Compare the files
if cmp -s "a1.txt" "2.txt" then
   echo "same file"
else
   echo "files are different"
fi

[[ ! $(cmp -s "a1.txt" "2.txt") ]] && echo "files are different" || echo "same file"


# local_temp_var can't be used outside of the () block : the variable in () is a subshell, and the variable is not available outside of the subshell.
# () is a subshell, and the variable is not available outside of the subshell.  {} is a block, and the variable is available outside of the block.
cur_folder_is_empty_folder || echo "not empty folder"
cur_folder_is_empty_folder || { echo "Not in git repo"; return 2; }
is_inside_git_svn_repo             || { dumperr "Not in git repo";  return 2; }

cur_folder_is_empty_folder && echo "empty folder" || echo "not empty folder"
cur_folder_is_empty_folder && global_non_temp_var=1 || global_non_temp_var=0
cur_folder_is_empty_folder && (
    local_temp_var=1
    dumpinfox "local_temp_var(${local_temp_var}) can't be used outside of this block"
    dumpkey local_temp_var
) || (
    local_temp_var=0
    dumpinfox "local_temp_var(${local_temp_var}) can't be used outside of this block"
    dumpkey local_temp_var
)

cur_folder_is_empty_folder
## $? is the exit status of the last command executed
dumpinfo "cur_folder_is_empty_folder exist status : $?"
if [[ $? == 0 ]] ; then
    dumpinfox "empty folder"
    global_non_temp_var_in_blcok=1
    dumpinfox "global_non_temp_var(${global_non_temp_var}) can be used outside of this block"
else
    dumpinfox "not empty folder"
    global_non_temp_var=0
    dumpinfox "global_non_temp_var(${global_non_temp_var}) can be used outside of this block"
fi

# https://stackoverflow.com/questions/2172352/in-bash-how-can-i-check-if-a-string-begins-with-some-value
# the ; is MUST before then .. else : syntax error near unexpected token `then'

# You can use either [[ or (( keyword. When you use [[ keyword, you have to use string operators such as -eq, -lt. 
# I think, (( is most preferred for arithmetic, because you can directly use operators such as ==, < and >.

# NOTE : the blank and ; is MUST :  [ condi ] ; 

# brack explain
# https://tldp.org/LDP/abs/html/special-chars.html#BRACEEXPREF


# https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
# declare -F "dump_env_variable" &> /dev/null || source ${BASH_DIR}/init/abc.sh
# alias dumpkey &> /dev/null && echo yes || echo no

declare -F "dump_env_variable" &> /dev/null   && echo "function dump_env_variable is defined" || echo "function dump_env_variable is NOT defined" 
alias dumpkey &> /dev/null                    && echo "alias dumpkey is defined" || echo "alias dumpkey is NOT defined"

dump_script_position
a=$1
b=$2
if [[ a == 1 || b == 2 ||  a == 3 && b == 4  ]] ; then
     echo "Error"
else
     echo "No Error"
fi

if (( $a == 1 )) 
then
    echo "papa"
fi

dump_script_position
array=("one" "two" "potatoes" "bananas" "three" "apples")
value="bananas"

if [[ $(echo ${array[@]} | fgrep -w $value) ]] ; then
  echo "value found"
else
  echo "value not found"
fi

dump_script_position
if [[ -f "${BASH_DIR}/test/if_else_branch.sh" ]] && [[ -f "${BASH_DIR}/test/test_path.sh" ]] ;
then
  echo "the file exists!"
fi

if [[ -f "${BASH_DIR}/test/if_else_branch.sh" ]]; then
  echo "the file exists!"
fi
dump_script_position
if [[ -d "${HOME}shell_script/bash_env/" ]]; then
  echo "the Directory exist!"
fi
dump_script_position
[ -d "${HOME}shell_script/bash_env/" ]         && echo "Directory  exists."
[ ! -d "${HOME}shell_script/bash_env/abc/" ]   && echo "Directory  DOES NOT exists."
[ -d "${HOME}shell_script/bash_env/" ]         && echo "Directory  exists." || echo "Error: Directory  does not exists."

dump_script_position
if [[ -z "${DEPLOY_ENV}" ]]; then
  echo "DEPLOY_ENV is NOT defined"
else  
  echo "DEPLOY_ENV is defined"
fi

# 直接引用变量，如果变量未定义，将不会返回任何内容。
if [ $VARNAME ]; then
    echo "VARNAME is set to $VARNAME"
else
    echo "VARNAME is not set or is set to an empty string"
fi

# 使用 - z 字符串比较操作符来检查变量是否为空。如果变量未定义或值为空，-z 将返回真（true）
if [ -z "$VARNAME" ]; then
    echo "VARNAME is null string or VARNAME not exist"
else
    echo "Value of VARNAME is: $VARNAME"
fi

# 使用特殊的字符串处理，比如在变量前后添加一个字符，来检查变量是否被设置。
if [ "x${VARNAME}" != "x" ]; then
    echo "说明 VARNAME 变量不为空"
else
    echo "变量 VARNAME 为空或未定义"
fi

# 使用 env 命令配合 grep 来检查环境变量是否存在。
env | grep ^VARNAME=
if [ $? -ne 0 ]; then
    echo "VAR VARNAME not exist in env"
else
    echo "Value of VARNAME is: $VARNAME"
fi


# or using a short-hand version
[[ -z "${DEPLOY_ENV}" ]] && MyVar=='default' || MyVar=="${DEPLOY_ENV}"
# or even shorter use
MyVar="${DEPLOY_ENV:-default_value}"

dump_script_position
if [[ ! -v DEPLOY_ENV ]]; then
    echo "DEPLOY_ENV is not set"
elif [[ -z "$DEPLOY_ENV" ]]; then
    echo "DEPLOY_ENV is set to the empty string"
else
    echo "DEPLOY_ENV has the value: $DEPLOY_ENV"
fi

dump_script_position
if [ -z "$PS1" ]; then
        echo "This shell is not interactive"
else
        echo "This shell is interactive"
fi

# detect folder is empty
dump_script_position
DIR="${HOME}/csh_env"
if [ -d "$DIR" ] ; then
	if [ "$(ls -A $DIR)" ]; then
     echo "Take action $DIR is not Empty"
	else
    echo "$DIR is Empty"
	fi
else
	echo "Directory $DIR not found."
fi

dump_script_position
# below cmd , the \; is MUST
find ~/temp/empty -maxdepth 0 -empty -exec echo {} is empty. \;

[ "$(ls -A ${HOME}/csh_env)" ] && echo "Not Empty folder" || echo "Empty folder"
[ "$(ls -A /tmp)" ] && echo "Not Empty folder" || echo "Empty folder"


[[ -L "${file%/}" ]] && echo "is symbol link"

dump_script_position
echo $0
if [ -z "$PS1" ]; then
        echo "This shell is not interactive"
else
        echo "This shell is interactive"
fi

if [[ $- == "*i*" ]]; then
    echo "do_interactive_stuff"
fi

dump_script_position
my_error_flag=1
my_error_flag_o=1
if [ $my_error_flag -eq 1 ] ||  [ $my_error_flag_o -eq 2 ]; then
      echo "$my_error_flag"
else
    echo "no flag"
fi

dump_script_position
if [ $my_error_flag -eq 1 ] ||  [ $my_error_flag_o -eq 2 ] || ([ $my_error_flag -eq 1 ] && [ $my_error_flag_o -eq 2 ]); then
      echo "$my_error_flag"
else
    echo "no flag"
fi


# mkdir -p ~/bin 
# cd ~/bin && touch check_file && chmod u+x check_file && vi check_file
