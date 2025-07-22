
bash_script_i

echo
dumpinfox cpu information:
dumpcmd lscpu
lscpu

echo
dumpinfox network ip :
dumpcmd 'ip addr show | grep "inet "'
ip addr show | grep "inet "
dumpinfo "global ip and local ip:"
dumpcmd 'hostname -I'
hostname -I

echo
dumpinfox current desktop environment : `uname -o`
dumpcmd 'uname -a'
uname -a
dumpinfo current shell is : $SHELL

# smi_file=${TEMP_DIR}/nvidia_smi_`hostname`.log
# dumpinfox "# nvidia-smi -q "  2>&1   |  tee       ${smi_file}
# nvidia-smi -q            >>  ${smi_file}
# cat  ${smi_file} | grep -A 2 "Driver Version"
# dumpinfo "full smi info :  ${red} ${smi_file} ${end}"

echo
dumpinfox "bash builtin var :${green} ${BASH_DIR}/test/all_builtin_internal_variable.sh  ${end}"

echo
bash_script_o
