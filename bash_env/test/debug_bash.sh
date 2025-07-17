#!/bin/bash

bash_script_i
echo
# set 命令可以启用调试选项，帮助你更好地理解脚本执行的过程：
# set -x：输出每一行命令及其结果，便于跟踪脚本的执行流程。
# set -e：在遇到错误时立即退出脚本，避免继续执行可能导致问题的命令。
# set -u：对未定义的变量进行警告，帮助发现变量名拼写错误或未初始化的问题。
# set -o pipefail：确保管道中任何一个命令失败时，整个管道返回失败状态。

#!/bin/bash
set -euxo pipefail  # 开启所有调试选项

echo "开始执行脚本"
undefined_variable="test"  # 演示未定义变量的警告
ls /nonexistent_directory  # 演示错误退出

# bash -x script.sh：逐行打印脚本执行的命令及其结果。
# bash -v script.sh：逐行打印脚本内容（不包括执行结果）。

ls /nonexistent_directory
if [ $? -ne 0 ]; then
    echo "命令失败"
fi

set +euxo pipefail       # 禁用调试选项

echo
bash_script_o
