
# bash_script_i
# https://sourceware.org/gdb/onlinedocs/gdb/Skipping-Over-Functions-and-Files.html
# info skip
# show debug skip

# skip delete [range]
# skip enable  [range]
# skip disable  [range]
# set debug skip [on|off]

# skip file [filename]              # -fi file
# skip function [linespec]          # -fu linespec
# skip -rfunction regexp            # -rfu regexp , e.g.  skip -rfu .*::getInstance

# source /home/xlshen/scratch/bash_env/app/gdb/feature/skip_filter/loadFilter_skipNoSrc.py
source /home/xlshen/scratch/bash_env/app/gdb/feature/skip_filter/loadFilter_step2SpecSrc.py
source /home/xlshen/scratch/bash_env/app/gdb/feature/skip_filter/loadFilter_skipStd.gdb

define filter
    source /home/xlshen/scratch/bash_env/app/gdb/feature/skip_filter/loadFilter.gdb
end

document filter
	reload the gdb alias script : source /home/xlshen/scratch/bash_env/app/gdb/feature/skip_filter/loadFilter.gdb
end 

# bash_script_o