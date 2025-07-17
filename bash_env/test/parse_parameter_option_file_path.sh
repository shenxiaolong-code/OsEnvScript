bash_script_i
echo

dump_script_position
echo the raw all parameter  : $*
echo the raw all parameter  : $@
echo all parameter after No.2 : ${@:2}
echo the raw parameter number  : $#
echo the raw parameter No.0 : $0
echo the raw parameter No.1 : $1
echo the raw parameter No.2 : $2
echo

echo
dump_script_position
echo "win %~dp0 : ${0%/*}"                          # /usr/bin
echo "win %~0   : ${0%}"                            # /usr/bin/bash
echo "win %~0   : ${0}"                             # /usr/bin/bash

echo
dump_script_position
# shift n     会移除前 n 个参数
# shift $#    移除所有参数
shift $#;  source ${BASH_DIR}/test/_test_bash.sh  # remove any parameter and call the script without any parameter


dirname   ${BASH_DIR}/bin/unpack.sh                            # ${file_path%/*}  :  ${BASH_DIR}/bin
basename  ${BASH_DIR}/bin/unpack.sh                            # ${file_path%*/}  :  unpack.sh
echo      ${BASH_DIR}/bin/unpack.sh | awk -F'/' '{print $3}'   # xiaolongs
echo      ${BASH_DIR}/bin/unpack.sh | cut -d'/' -f3            # xiaolongs

file -b --mime-type ${BASH_DIR}/bin/unpack.sh                  # text/plain       : text/x-c
file                ${BASH_DIR}/bin/unpack.sh                  # ${BASH_DIR}/bin/unpack.sh: C source, UTF-8 Unicode text
file -i             ${BASH_DIR}/bin/unpack.sh                  # ${BASH_DIR}/bin/unpack.sh: text/x-c; charset=utf-8

realpath      ~/linuxRepo         #  解析符号链接 ， 返回给定路径的绝对路径。
readlink -f   ~/linuxRepo         #  显示符号链接的目标路径。

function test_params() {
    echo "All parameters: $@"
    
    # Extract the nth parameter
    n=3
    echo "The 3rd parameter is: ${!n}"

    # Extract the first n parameters
    n=4
    echo "The first 4 parameters are: ${@:1:$n}"

    # Extract the last n parameters
    n=2
    echo "The last 2 parameters are: ${@: -$n}"

    # Extract parameters from m to n
    m=2
    n=4
    echo "Parameters from the 2nd to the 4th are: ${@:m:$((n-m+1))}"
}

# Test the function
test_params arg1 arg2 arg3 arg4 arg5 arg6



echo 
file=/dir1/dir2/dir3/my.file.txt
# https://blog.csdn.net/jiezi2016/article/details/79649382
# ${string#substring}Strip shortest match of $substring from front of $string
# ${string%substring}Strip shortest match of $substring from back of $string
#  # 是去掉左边 . #代表删除从前往后最小匹配的内容, # 表示第一个匹配，## 表示最后一个匹配 , 即 # 表示最短匹配， ## 表示最长匹配
#  % 是去掉右边 ，%代表删除从后往前最小匹配的内容, % 表示第一个匹配，%% 表示最后一个匹配 , 即 % 表示最短匹配， %% 表示最长匹配
#  不表示任意字符，仅仅表示其本身 . 标识符仅仅只能一个字符
dump_script_position
echo ${file#*/}     # ：删掉第一个 / 及其左边的字符串：dir1/dir2/dir3/my.file.txt
echo ${file##*/}    # ：删掉最后一个 /  及其左边的字符串：my.file.txt
echo ${file#*.}     # ：删掉第一个 .  及其左边的字符串：file.txt
echo ${file##*.}    # ：删掉最后一个 .  及其左边的字符串：txt

echo ${file%/*}     # ：删掉最后一个  /  及其右边的字符串：/dir1/dir2/dir3
echo ${file%%/*}    # ：删掉第一个 /  及其右边的字符串：(空值)
echo ${file%.*}     # ：删掉最后一个  .  及其右边的字符串：/dir1/dir2/dir3/my.file
echo ${file%%.*}    # ：删掉第一个  .   及其右边的字符串：/dir1/dir2/dir3/my

# source ${EXT_DIR}/tmp/test/_test_bash.sh 1 2 3 4 5
dump_script_position
echo "script full path (win %~f0)   : ${BASH_SOURCE[0]}"                # ${EXT_DIR}/tmp/test/_test_bash.sh
echo "script full dir (win %~dp0)   : ${BASH_SOURCE[0]%/*}"             # ${EXT_DIR}/tmp/test
echo "script file naem (win %~nx0)  : ${BASH_SOURCE[0]##*/}"            # _test_bash.sh

echo
dump_script_position
echo "convert existing related path to absolute path:"
realpath      .
realpath      ../
readlink -f   .
readlink -f   ../
realpathx      .
realpathx      ../
echo "convert related path to absolute path , path can not exist"
readlink -m   ../


echo
dump_script_position
echo "all parametrs : ${BASH_SOURCE[@]}"

echo
echo "%~f0    : ${BASH_SOURCE[0]}"
echo "%~dp0   : ${BASH_SOURCE[0]%/*}"
echo "%~dpn0  : ${BASH_SOURCE[0]%%.*}"
echo "%~nx0   : ${BASH_SOURCE[0]##*/}"
echo "%~x0    : ${BASH_SOURCE[0]##*.}"

# source ${BASH_DIR}/test/parse_parameter_option.sh  ${BASH_DIR}/test/_test_bash.sh
echo
echo "%~f0    : ${BASH_SOURCE[1]}"
echo "%~dp0   : ${BASH_SOURCE[1]%/*}"
echo "%~dpn0  : ${BASH_SOURCE[1]%%.*}"
echo "%~nx0   : ${BASH_SOURCE[1]##*/}"
echo "%~x0    : ${BASH_SOURCE[1]##*.}"

echo
dump_script_position
# 单一符号是最小匹配；两个符号是最大匹配
echo ${file:0:5}     # ：提取最左边的 5 个字节：/dir1
echo ${file:5:5}     # ：提取第 5 个字节右边的连续5个字节：/dir2
# 也可以对变量值里的字符串作替换：
echo ${file/dir/path}       #  ：将第一个dir 替换为path：/path1/dir2/dir3/my.file.txt
echo ${file//dir/path}      #  ：将全部dir 替换为 path：/path1/path2/path3/my.file.txt

# https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
# source ${BASH_DIR}/test/bash/use_parameter_flag_in_script.sh -f 'John Smith' -a 25 -u john
# sh ${BASH_DIR}/test/use_parameter_flag_in_script.sh -f 'John Smith' -a 25 -u john
echo
dump_script_position
while getopts u:a:f: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) age=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done
echo "Username: $username";
echo "Age: $age";
echo "Full Name: $fullname";

# remove the possible quote of input parameter
dump_script_position
param_no_quote=$(echo $1|xargs)
param_no_quote=$(echo $1 | sed 's/^"\(.*\)"$/\1/')

opt=$1
param_no_quote="${opt%\"}"
param_no_quote="${temp#\"}"
echo "$param_no_quote"


# Using argument expansion to capture all files provided as arguments.
dump_script_position
echo "parse parameter loop : ${@}"
for FILE in ${@} ; do
  if [[ ! -f $FILE ]] ; then
    echo "The file ${FILE} does not exist!"
  else
    echo "The file ${FILE} exist!"
  fi
done


echo
bash_script_o