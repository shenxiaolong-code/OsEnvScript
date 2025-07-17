bash_script_i
# trap --help
# $ trap -l
#  1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL       5) SIGTRAP
#  6) SIGABRT      7) SIGBUS       8) SIGFPE       9) SIGKILL     10) SIGUSR1
# 11) SIGSEGV     12) SIGUSR2     13) SIGPIPE     14) SIGALRM     15) SIGTERM
# 16) SIGSTKFLT   17) SIGCHLD     18) SIGCONT     19) SIGSTOP     20) SIGTSTP
# 21) SIGTTIN     22) SIGTTOU     23) SIGURG      24) SIGXCPU     25) SIGXFSZ
# 26) SIGVTALRM   27) SIGPROF     28) SIGWINCH    29) SIGIO       30) SIGPWR
# 31) SIGSYS      34) SIGRTMIN    35) SIGRTMIN+1  36) SIGRTMIN+2  37) SIGRTMIN+3
# 38) SIGRTMIN+4  39) SIGRTMIN+5  40) SIGRTMIN+6  41) SIGRTMIN+7  42) SIGRTMIN+8
# 43) SIGRTMIN+9  44) SIGRTMIN+10 45) SIGRTMIN+11 46) SIGRTMIN+12 47) SIGRTMIN+13
# 48) SIGRTMIN+14 49) SIGRTMIN+15 50) SIGRTMAX-14 51) SIGRTMAX-13 52) SIGRTMAX-12
# 53) SIGRTMAX-11 54) SIGRTMAX-10 55) SIGRTMAX-9  56) SIGRTMAX-8  57) SIGRTMAX-7
# 58) SIGRTMAX-6  59) SIGRTMAX-5  60) SIGRTMAX-4  61) SIGRTMAX-3  62) SIGRTMAX-2
# 63) SIGRTMAX-1  64) SIGRTMAX

function start_hook() {
    export CUSTOM_VAR="hello world"
}

function exit_hook() {
    # https://stackoverflow.com/questions/1835943/how-to-determine-function-name-from-inside-a-function
    echo "current funciton :  ${FUNCNAME[0]} "
    echo "byebye"
}

#  If a SIGNAL_SPEC is EXIT (0) ARG is executed on exit from the shell.  
#  If a SIGNAL_SPEC is DEBUG, ARG is executed before every simple command.  
#  If a SIGNAL_SPEC is RETURN, ARG is executed each time a shell function or a script run by the . or source builtins finishes executing.
#  A SIGNAL_SPEC of ERR means to execute ARG each time a command failure would cause the shell to exit when the -e option is enabled.

# https://stackoverflow.com/questions/18221348/exit-hook-working-both-on-bash-and-zsh

# builtin exec 'cmd'
# builtin exit

trap 'echo byby, exit current session'  EXIT            # this will hook exit procedure
trap 'echo byby, exit current script '  RETURN

exit_hook

# $$ is PID , the $PPID is sub-process PID , it is script process ID
echo "${brown}kill current script process automatically.${end}"
# kill -9 $$
kill -INT $$


# https://linux.cn/article-9639-1.html
# http://kb.mit.edu/confluence/pages/viewpage.action?pageId=3907156

function finish {
  # your final clean code
  echo "cleaning ..... , I should be runing final"
}
trap finish EXIT

echo "test run clean work , it is similiar to the dtor of C++ ."

trap '{ echo "Hey, you pressed Ctrl-C.  Time to quit." ; exit 1; }' INT
echo "Counting to 5 slowly, press Ctrl-C to interrupt."
for number in 1 2 3 4 5; do
    echo $number
    sleep 1
done

trap '' INT
echo "Counting to 5 again, but pressing Ctrl-C shouldn't work."
for number in 1 2 3 4 5; do
    echo $number
    sleep 1
done

trap - INT
echo "One more time, but Ctrl-C should work again."
for number in 1 2 3 4 5; do
    echo $number
    sleep 1
done



bash_script_o
