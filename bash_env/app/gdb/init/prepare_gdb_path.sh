echo
echo "+++++++++ loading ${BASH_DIR}/app/gdb/init/prepare_gdb_path.sh ..."
echo

cache_dir_gdb="${CACHE_DIR}/gdb_tmp"
if [[ ! -d "${cache_dir_gdb}" ]] ; then 
    mkdir -p "${cache_dir_gdb}"
fi
echo "gdb temporary path : ${cache_dir_gdb}"

gdb_py_init_file="${cache_dir_gdb}/py_init_$(hostname).txt"
[[ ! -f "${gdb_py_init_file}" ]] && {
    # avoid repeat init
    echo "install python module : ${BASH_DIR}/app/gdb/requirements.txt "
    pip install -r  ${BASH_DIR}/app/gdb/requirements.txt
    touch "${gdb_py_init_file}"
}

# https://docs.nvidia.com/cuda/cuda-gdb/index.html
# Temporary Directory
# warning : if only TMPDIR is set without CUDBG_APICLIENT_PID, it will cause cuda gdb internal error 
# export  TMPDIR="${TEMP_DIR}"                                      # used by cuda gdb
# export  CUDBG_APICLIENT_PID=


echo "--------- leaving ${BASH_DIR}/app/gdb/init/prepare_gdb_path.sh ..."
