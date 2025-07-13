
echo \033[36m+++++++++ loading /home/xlshen/scratch/bash_env/app/gdb/init/project_init.gdb \033[37m...\r\n
# until now, the debugee symbol is loaded, the project-related cmd can be executed.
# this script is specified in gdb --command=xxx
# e.g. 
# gdb -q --command=/home/xlshen/scratch/bash_env/app/gdb/init/project_init.gdb  --args ...

source /home/xlshen/scratch/bash_env/app/gdb/init/load_gdb_log_path.gdb
source /home/xlshen/scratch/bash_env/app/gdb/feature/bp/alias_gdb_breakpoint.gdb

echo \033[36m--------- leaving \033[35m/home/xlshen/scratch/bash_env/app/gdb/init/project_init.gdb\033[37m ...\r\n

if $_isvoid($_gdb_major)==0
    # only high version gdb defined variable _gdb_major and support run command in script.
    printf "\ngdb main version : %d , support more frequent used cmds. \n\n", $_gdb_major
    run
end

echo \033[36m--------- leaving /home/xlshen/scratch/bash_env/app/gdb/init/project_init.gdb \033[37m\r\n