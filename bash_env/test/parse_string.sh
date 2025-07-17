
# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html


# -oP only output the matched part, -o is not supported in bash, but -P is supported
dumpinfo "cmake version : $(cmake --version | grep -oP "\d+\.\d+\.\d+")"      # 3.21.3
echo "${BASH_DIR}/app/gdb/cmds/print_string_var_in_cur_function.py" | grep -oP "app/.*/print"

string=01234567890abcdefgh
echo string=${string}
echo string length : ${#string}

dumpinfo "string replace 字符串替换"
# tr 用于在 Unix 和 Linux 系统中转换或删除字符. tr 命令只能处理单个字符，不能处理字符串或子字符串 tr --help

# ${line_string/str/rep_str}                    # /  只替换第一个
# ${line_string//str/rep_str}                   # // 替换所有
# https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
firstString="I love Suzi and Marry"
secondString="Sara"
echo "${firstString/Suzi/"$secondString"}"        # I love Sara and Marry

# To replace all occurrences, use ${parameter//pattern/string}:
message='The secret code is 12345'
echo "${message//[0-9]/X}"                        # The secret code is XXXXX
echo "${PWD/.xia?/-}"
echo "${PWD/lo*/}"
# match only support ? * [...]  : single char, any string, char set
string="origin/cxx/ccc/ddd"             # 当替换的字符串中有 / 字符时
echo "${string#origin/}"                # 输出: cxx/ccc/ddd

echo 
file=/dir1/dir2/dir3/my.file.txt
# https://blog.csdn.net/jiezi2016/article/details/79649382
# ${string#substring}Strip shortest match of $substring from front of $string
# ${string%substring}Strip shortest match of $substring from back of $string
#  # 是删除左边 . #代表删除从前往后最小匹配的内容，# 表示第一个匹配，## 表示最后一个匹配，即 # 表示最短匹配， ## 表示最长匹配
#  % 是删除右边 ，% 代表删除从后往前最小匹配的内容，% 表示第一个匹配，%% 表示最后一个匹配，即 % 表示最短匹配， %% 表示最长匹配
#  不表示任意字符，仅仅表示其本身。标识符仅仅只能一个字符
dumpinfo "string trunct 字符串匹配截取"
echo ${file#*/}     # ：删掉第一个 / 及其左边的字符串：dir1/dir2/dir3/my.file.txt
echo ${file##*/}    # ：删掉最后一个 /  及其左边的字符串：my.file.txt
echo ${file#*.}     # ：删掉第一个。及其左边的字符串：file.txt
echo ${file##*.}    # ：删掉最后一个。及其左边的字符串：txt

echo ${file%/*}     # ：删掉最后一个  /  及其右边的字符串：/dir1/dir2/dir3
echo ${file%%/*}    # ：删掉第一个 /  及其右边的字符串：(空值)
echo ${file%.*}     # ：删掉最后一个。及其右边的字符串：/dir1/dir2/dir3/my.file
echo ${file%%.*}    # ：删掉第一个。及其右边的字符串：/dir1/dir2/dir3/my

# 字符串截取，除了上面的方法或，用得更多的还是 sed, grep ,awk
# 对于复杂规则的字符串提取，使用 egrep 是一个不错的选择
echo "libgcc-4.8.5-4.h5.x86_64.rpm" | egrep -o "[0-9]+\.[0-9]+"     # output 4.8
echo "hello world, abc is good"     | egrep -o '([^abc]+)'
echo "hello world, abc is good"     | egrep -o '[^abc]+' | xargs

param=1
if [[ ${param} =~ ^[0-9]+$ ]]; then
  echo "param is number"
else
  echo "param is not number"
fi

echo
dumpinfo "string match test 字符串匹配测试"
# Note : below style "=~" and []  is not supported in bash, but it works in tcsh , bash uses [[ =~ ]]
# [ $string =~ "main" ]           && echo yes
# but it works when
# [ "$string" == "main" ]         && echo yes

str="hello world"
substr="world"
# https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
string='hello , My string';
if [[ $string =~ "My" ]]; then
   dumpinfo "String contains substring."
fi

if [[ $str == *"$substr"* ]];
then
    dumpinfo "String contains substring."
else
    dumpinfo "String does not contain substring."
fi

string='My long string'
if [[ $string == *"My long"* ]]; then
  dumpinfo "include 'My long' "
fi
if [[ $string == "My long"* ]]; then
  dumpinfo "start with 'My long' "
fi
if [[ $string == *"My long" ]]; then
  dumpinfo "end with 'My long' "
fi

echo
dumpinfo "string trunct 字符串根据位置和长度截取"
string=01234567890abcdefgh
dumpinfo "string=${string}"
dumpinfo "last char : ${string: -1}"            # the blank between ':' and '-1' is MUST
dumpinfo "worng last char : ${string:-1}"

# the begin index from 0
# sub-string from index 7
echo ${string:7}
# 890abcdefgh

echo ${string:7:0}

# sub-string from index 7 , length 2
echo ${string:7:2}
# 8

# sub-string from index 7 , -2
echo ${string:7:-2}
# 890abcdef

echo ${string: -7}        # the blank between ':' and '-7' is MUST
# cdefgh

echo ${string:-7:0}

echo ${string:-7:2}
# c

echo ${string:-7:-2}
# cdef

echo
set -- 01234567890abcdefgh
dumpinfo "脚本内设置参数 1 : $1"
echo ${1:7}
# 890abcdefgh

echo ${1:7:0}

echo ${1:7:2}
# 8

echo ${1:7:-2}
# 890abcdef

echo ${1: -7}
# cdefgh

echo ${1: -7:0}

echo ${1: -7:2}
# c

echo ${1: -7:-2}
# cdef

array[0]=01234567890abcdefgh
echo ${array[0]:7}
# 890abcdefgh

echo ${array[0]:7:0}

echo ${array[0]:7:2}
# 8

echo ${array[0]:7:-2}
# 890abcdef

echo ${array[0]: -7}
# cdefgh

echo ${array[0]: -7:0}

echo ${array[0]: -7:2}
# c

echo ${array[0]: -7:-2}
# cdef

# 注意， cut 在使用以空格或者制表符为分隔符的字符串时有问题：当输入行包含多个连续的空格时,cut 会将它们视为多个字段分隔符，而不是一个。
# 这种情况下要使用 sed 命令先将多个连续的空格替换为单个空格,然后再使用 cut 命令提取第二个字段:
dumpinfo "cut 截取字符串"
echo "/your/full/string/with/slashes" | cut -d'/' -f1-2



# 当处理多个空格或者制表符当成一个分隔时，应该优先使用 awk 命令，其行为更适合我们的常识思维
# awk 命令默认使用空格或制表符作为字段分隔符。当输入行包含多个连续的空格时，awk 会将它们视为一个字段分隔符。
# 相比于 grep 的查找和 sed 的编辑,awk 在数据分析和报告生成方面显得更加强大
# awk 通常以文件的一行为处理单位,逐行读入文件并执行相应的命令来处理文本, 可以用于在文件或字符串中基于指定规则浏览和抽取信息。
# awk 拥有自己的编程语言,支持变量、表达式、条件语句、循环语句等编程功能,可以编写复杂的文本处理脚本
ps -u xiaolongs -f | grep ".vscode-server" | head -n -1  | awk '{print $2}'

# 这个命令会从 /etc/passwd 文件中提取用户名和 UID。
awk -F':' '{print $1, $3}' /etc/passwd
# 统计文件中每个单词出现的次数:
awk '{for(i=1;i<=NF;i++) count[$i]++} END {for(word in count) print word, count[word]}' ${BASH_DIR}/test/parse_string.sh
# 这个命令会将 file.txt 文件中的每行数据格式化输出,每个字段占 10 个字符宽度,左对齐。
awk 'BEGIN{OFS="\t"} {printf "%-10s %-10s %-10s\n", $1, $2, $3}' ${BASH_DIR}/test/parse_string.sh


echo 
echo ${BASH_DIR}/test/parse_string.sh