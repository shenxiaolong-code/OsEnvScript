
# bash_script_i
# below gdb settion option needs the gdb version greater than 9.0
printf "gdb version is greater 9.0 ,  _gdb_major=%d , _gdb_minor=%d\n", $_gdb_major, $_gdb_minor

source /home/xlshen/scratch/bash_env/app/gdb/init/load_color_style.gdb

# _gdb_major is new built-in variable in gdb 9.0

define .
    # p $pc    
    # | frame 0 | grep ":" > /home/scratch.xiaolongs_gpu/temp/gdb_cmd_output.txt
    # !source /home/xlshen/bash_env/app/vscode/bin/vscode_open_file_goto_line.csh
    # only computelad-303 can open the file directly
    # echo\r\n
    # frame 0
    # x $rip
    gdb2shell -g 'x $rip'
end

document .
    show current source file:line
    file : /home/xlshen/scratch/bash_env/app/gdb/feature/cmds/load_gdb_version90_supported.gdb
end

define ..
    finish
end

document ..
    go out currrent functon
    the equivalent command is : ss if previous cmd is 's' in general , else it equivalent to cmd c -- runaway
    file : /home/xlshen/scratch/bash_env/app/gdb/feature/cmds/load_gdb_version90_supported.gdb
end

# bash_script_o