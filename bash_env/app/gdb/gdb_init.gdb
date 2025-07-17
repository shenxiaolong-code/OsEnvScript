# ln -s /home/xlshen/scratch/shell_script/bash_env/app/gdb/gdb_init.gdb   ~/.gdbinit
# ln -s /home/xlshen/scratch/shell_script/bash_env/app/gdb/test/ddd_init  ~/.dddinit

# highlight file context by file extension : associations
# https://stackoverflow.com/questions/29973619/how-to-associate-a-file-extension-with-a-certain-language-in-vs-code
# easy way : ctrl + shift + p  => change language mode => shell script


echo \033[36m+++++++++ loading \033[35m/home/xlshen/.gdbinit:9  \033[37m ...\r\n
echo \033[36m+++++++++ loading \033[35m/home/xlshen/scratch/shell_script/bash_env/app/gdb/gdb_init.gdb:10  \033[37m ...\r\n
# echo sourced by /home/xlshen/.gdbinit    \r\n
# echo ddd init file path : /home/xlshen/.ddd/init\r\n
# https://github.com/gdbinit/Gdbinit/blob/master/gdbinit
# https://gist.github.com/CocoaBeans/1879270

# resolve issue : warning: GDB: Failed to set controlling terminal: Operation not permitted
# chmod +x /home/xlshen/.gdbinit

# NOTE : 
# Not load project-specified gdb script file in gdb_init.gdb file , it should be put : <projDir>/.gdbinit
# the better alternative way    :
# in global common init         : /home/<user>/.gdbinit
# in shell command line         : gdb --command=<gdb_script_path> --args /home/.../bin/cask-sdk-cask-tester run ...
# in vscode gdb launch.json     : "setupCommands":[ { "text": "source /home/.../gdb_init_cppTest.gdb", } ]
# in project specified init     : <projDir>/.gdbinit

# the script file load time point :
# .gdbinit will be loaded when gdb started immediately.
# <gdb_script_path>  of  gdb --command=<gdb_script_path> will be loaded after the main user module symbols is loaded.
# =>  system breakpoints should be set in .gdbinit -- but we can put complex breakpoint examples in .gdbinit with arounding by  if 0 ... end
# =>  user module breakpoints should be set in <gdb_script_path> without pending.

##################################################  implement  ##################################################
# https://docs.amd.com/bundle/ROCDubugger-User-Guide/page/Convenience-Vars.html
# how to remove a convenience variable
# begin
set $gdb_init_phase=1
shell source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/prepare_gdb_path.sh
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/loadPath.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/loadOptions.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/loadAlias.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/load_features.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/loadTracepointCmd.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/bp/load_sx_exception_signal.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cmds/print_string_var_in_cur_function.py
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/pretty_printer/register_verbose_cmd.py
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cmds/print_sub_class_member.py
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cmds/jump_to_line.py
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/feature/hook_step/setup_step_hook.gdb
# source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cmds/print_other_frame_var.py

# https://sourceware.org/gdb/onlinedocs/gdb/Convenience-Funs.html
if $_isvoid($cudagdb)==1
    source /home/xlshen/scratch/shell_script/bash_env/app/gdb/init/loadWindowLayout.gdb
end

# if $_shell("test -f ./project_init.gdb && echo 1 || echo 0") == 1
if 0
    echo "[gdb_init] found project_init.gdb, loading...";
    source ./project_init.gdb
else
    echo \033[31m/home/xlshen/scratch/shell_script/bash_env/app/gdb/gdb_init.gdb:62\033[37m\r\n
    echo \033[33mDisabled feature : \033[31minit project-based gdb init file.\033[37m\r\n
    echo [gdb_init] project_init.gdb not found in current directory.\r\n
end

info auto-load

set $gdb_init_phase=2

echo
echo \r\nDone to load all init script.
echo \r\n\033[33m[prompt]: \033[32muse setting \033[37m' \033[31mset verbose\033[37m '\033[32m to enable gdb verbose mode.\033[37m
echo \r\n\033[33m[prompt]: \033[32muse cmd \033[37m' \033[31mlimit\033[37m '\033[32m to set array/string display size .\033[37m
echo \r\n\033[36m--------- leaving \033[35m/home/xlshen/scratch/shell_script/bash_env/app/gdb/gdb_init.gdb:75 \033[37m ...
echo \r\n\033[36m--------- leaving \033[35m/home/xlshen/.gdbinit:76 \033[37m ...\r\n\r\n


