bash_script_i
# ${BASH_DIR}/test/all_builtin_internal_variable.sh
alias run_in_func_info='[[ "$FUNCNAME" != "" ]] && echo "run in function\n" || echo "run out of function\n" '

dump_position_current
echo

# https://www.tecmint.com/learn-difference-between-and-bashpid-in-bash/

function return_function_or_script() {
    # https://stackoverflow.com/questions/9640660/any-way-to-exit-bash-script-but-not-quitting-the-terminal
    dump_position_current
    run_in_func_info
    echo "now , ready to exit script or exit function , goto parent task or parent function , instead of the terminal"
    return 4  
}

function kill_task_by_kill_process() {
    # https://stackoverflow.com/questions/11141120/exit-function-stack-without-exiting-shell
    dump_position_current
    run_in_func_info
    echo "kill current task sub-process => exit current script "
    # to exit the function stack without exiting shell one can use the command:
    kill -INT $$ 
    # this is like pressing Ctrl-C, which will stop the current script from running and drop you down to the command prompt.
}

echo 0000
run_in_func_info

echo 111111

return_function_or_script

echo 22222

[[ 1 == 0 ]] && echo "meet, exit current script." && return

kill_task_by_kill_process

echo 3333

bash_script_o
