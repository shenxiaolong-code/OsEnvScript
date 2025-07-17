#!/bin/bash

bash_script_i
echo

# 直接运行 - 变量不会被二次展开
var="world"
cmd='echo $var'
$cmd  # 输出: $var

# eval - 变量会被二次展开
var="world"
cmd='echo $var'
eval "$cmd"  # 输出: world

# 直接运行 - 复杂命令可能失败
file="my file.txt"
cmd="cat $file"  # 空格会导致命令失败

# eval - 可以正确处理复杂命令
file="my file.txt"
eval "cat '$file'"  # 正确处理带空格的文件名

echo
bash_script_o