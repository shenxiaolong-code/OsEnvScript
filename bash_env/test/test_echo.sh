# trace & debug
# https://stackoverflow.com/questions/2853803/how-to-echo-shell-commands-as-they-are-executed

echo "echo on"
#!/bin/sh -x
# set -x              # set -o xtrace
# set -v              # set -o verbose

# 直接引用变量值
# echo "${var_name}"
# 间接引用变量值 : 使用变量名的值作为另一个变量的名字
# echo "${!var_name}"

# multiline comments in Bash
# Use : ' to open and ' to close.
: '
This is a
very neat comment
in bash
'

# 标签可以自定义：虽然通常使用 EOF，但标签可以是任何字符串，只要它单独占一行且没有前后空格。

# echo raw string without variable expansion
# << EOF: 允许变量展开和命令替换
# << 'EOF': 禁止变量展开和命令替换
# 生成配置文件
# 创建脚本
# 输出多行文本
# 创建临时文件

cat << 'EOF'    # 单引号防止变量展开
$PATH           # 会原样输出 "$PATH"
EOF

# 不带引号 - 变量会被展开
cat << EOF
当前路径: $PWD
EOF

# 带引号 - 变量不会被展开
cat << 'EOF'
当前路径: $PWD
EOF

cat <<EOF > ${TEMP_DIR}/to_del/output.txt
This text will be saved in output.txt.
this is a multiline comment
EOF

# 如果结束的 EOF 前面有任何空格或制表符，shell 会保留 heredoc 内容中的前导空格：
cat << EOF
    内容会保持这些缩进
    这些空格会被保留
EOF

# 如果结束的 EOF 顶格写（前面没有任何空格），shell 会忽略 heredoc 内容中的前导空格：
cat << EOF
    内容的缩进会被忽略
    前导空格不会保留
EOF

# ls -l /dev/{stdout,stdin,stderr}
# command >   /dev/null   2>&1
# command &>  /dev/null
echo "no show "   >   /dev/null
echo "no show "  &>   /dev/null

echo "no ok show"               1>      /dev/null
echo "no error show"            2>      /dev/null
echo "no ok and error show"     >       /dev/null   2>&1

cd -   >/dev/null     2>&1      # fix : sh: 0: getcwd() failed: No such file or directory

egrep -c "^# set -x"  ${BASH_DIR}/test/test_echo.sh  &> /dev/null  &&  echo "exist 'set -x'" || echo "NO 'set -x'"
egrep -c "^# set -d"  ${BASH_DIR}/test/test_echo.sh  &> /dev/null  &&  echo "exist 'set -d'" || echo "NO 'set -d'"

# set -B            # Enable brace expansion (default setting = on)
echo {a..z}         # a b c d e f g h i j k l m n o p q r s t u v w x y z
echo {1..8}         # 1 2 3 4 5 6 7 8
echo {1..8} | xargs -n3 echo $1
echo {1..8} | xargs -n2 sh -c 'echo "the number $1 comes before $2"' sh
# output :
# the number 1 comes before 2
# the number 3 comes before 4
# the number 5 comes before 6
# the number 7 comes before 8

# 假设我们有一个环境变量名
env_var_name="MY_VAR"
MY_VAR="Hello, World!"

# 使用间接引用获取变量值
value="${!env_var_name}"
echo "$value"  # 输出: Hello, World!

echo -n " NO new line "
echo -e "${red}color output (enable interpretation of backslash escapes) ${end}"
echo -E "${red}disable interpretation of backslash escapes (default) ${end}"
# \e[0;31mdisable interpretation of backslash escapes (default) \e[0;0m

: '
If -e is in effect, the following sequences are recognized:
\\     backslash
\a     alert (BEL)
\b     backspace
\c     produce no further output
\e     escape
\f     form feed
\n     new line
\r     carriage return
\t     horizontal tab
\v     vertical tab
\0NNN  byte with octal value NNN (1 to 3 digits)
\xHH   byte with hexadecimal value HH (1 to 2 digits)
'

echo
echo "asc to hex string:"
echo "11111111" | od -A n -t x1
echo "hex to asc string:"
echo -e "\x65"

echo "random number : $RANDOM"

echo "LINENO: ${LINENO}"
echo "BASH_LINENO: ${BASH_LINENO[*]}"

# tcsh use `` to save command output, bash use $(  )
shFilePath=$( echo $1|sed 's#.*/#${EXT_DIR}/temp/#g'|sed 's/.csh/.sh/g' )

NODE_ENV=${NODE_ENV:-development}
echo NODE_ENV : ${NODE_ENV}

echo ${shFilePath}


echo "echo off"
# set +x
# set +v
