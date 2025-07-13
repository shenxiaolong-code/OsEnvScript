bash_script_i
echo



# show change
git -C ${DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api  status
# git -C ${DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api  diff
code --diff  ${DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util/backtrace.py.raw  ${DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util/backtrace.py 

rm ./backtrace.py 
cp ${DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util/backtrace.py   ./

echo
bash_script_o
