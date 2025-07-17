 
# ll /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda-gdbinit.gdb
# ln -s /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda-gdbinit.gdb  ${HOME}/.cuda-gdbinit
# https://docs.nvidia.com/cuda/cuda-gdb/index.html#getting-help
# ln -s /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda-gdbinit.gdb  ~/.cuda-gdbinit
# need cuda-gdb 12.1 and later support

echo \033[33m+++++++++ loading \033[32m/home/xlshen/.cuda-gdbinit\033[37m ...\r\n
echo \033[36m+++++++++ loading \033[35m/home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda-gdbinit.gdb\033[37m ...

set $cudagdb=1
# cudagdb usage
# if $_isvoid($cudagdb)==1 
#   # on gdb env : we expect to debug the host code on parent process
#     set follow-fork-mode parent
# else
#   # on cuda gdb env : we expect to debug the device code on child process
#     set follow-fork-mode child
# end

! source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda_set_env_var.sh

source /home/xlshen/scratch/shell_script/bash_env/app/gdb/gdb_init.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/loadOptions_cudagdb.gdb
source /home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/loadAlias_cudagdb.gdb

echo \r\n\033[36m--------- leaving \033[35m/home/xlshen/scratch/shell_script/bash_env/app/gdb/cuda_gdb/cuda-gdbinit.gdb\033[37m ...
echo \r\n\033[33m--------- leaving \033[32m/home/xlshen/.cuda-gdbinit\033[37m ...\r\n