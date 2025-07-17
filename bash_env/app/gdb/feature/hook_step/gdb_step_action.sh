#!/bin/bash
# bash_script_i

# chmod +x  ${CACHE_DIR}/gdb_test/gdb_step_action.sh

# echo -e "# +++++++++ loading ${BASH_SOURCE[0]}:$LINENO ..."

# echo step hook is called.
tmp_file_path=${1%%:*}

if [[ -f "${tmp_file_path}" ]] ; then
    # add readonly for system source file
    [[ ${tmp_file_path} == "/usr/"* ]] && { 
        echo -e "\033[30mreadonly mode for ${tmp_file_path} \e[0;0m" ; 
        # chown -R ${tmp_file_path} ; 
    }

    echo -e "\e[0;34mOpen source file :\e[0;32m $1 \e[0;0m"
    code --goto "$1"
    # or open file in another remote machine
    # ssh xiaolongs@computelab-303 "curl -s 'http://computelab-303.nvidia.com:8000/openfile?path=$1'"
else
    echo -e "\e[0;31mInvalid source path :\e[0;33m ${tmp_file_path} \e[0;0m"
fi

# echo -e "# +++++++++ leaving ${BASH_SOURCE[0]}:$LINENO ..."

# bash_script_o
