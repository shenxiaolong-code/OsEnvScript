

echo +++++++++ loading /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/gdb_python_api/load_gdb_python_api.gdb:3 ...\r\n

# experiment gdb_python_api
# https://github.com/jefftrull/gdb_python_api
# see video tutorial
# https://youtube.com/watch?v=ck_jCH_G7pA

source /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/gdb_python_api/load_gdb_python_api.py

# if $_shell("test -f /home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api/gdb_util/stepping.py && echo 1 || echo 0") == 1
if 1
    # git clone https://github.com/jefftrull/gdb_python_api  /home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api
    source /home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api/gdb_util/stepping.py
    # affected cmds : su -- Stepping only into user code
    # https://github.com/jefftrull/gdb_python_api#stepping-only-into-user-code

    source /home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api/gdb_util/backtrace.py

    # affected cmds : bt  -- Backtrace Cleanup for a group function
    # for continus call stack which has the save prefix, only show the last one.
    # this technique is useful for c++ std template library -- we don't care about the std function call stack
    # https://github.com/jefftrull/gdb_python_api#backtrace-cleanup-for-c-template-libraries
    set backtrace-strip-regexes (^std::)|(^boost::)
    # set backtrace-strip-regexes (^std::)|(^__gnu)|(^boost::)|(^cutlass::)|(^cask6::)
    # show backtrace-strip-regex

else
    # the source code download to : 
    # /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/gdb_python_api
    echo \r\nskip not existing external util.\r\n
    echo \033[33mNot existing dir : \033[31m/home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api\033[37m\r\n
    echo git clone https://github.com/jefftrull/gdb_python_api  /home/xlshen/scratch/third_part_dependency/gdb_pretty_printer/gdb_python_api \r\n\r\n
end

echo --------- leaving /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/gdb_python_api/load_gdb_python_api.gdb:37 ...\r\n