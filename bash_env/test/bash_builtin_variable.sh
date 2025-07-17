bash_script_i
echo

function bash_builtin_variable()
{
    echo "Bash 内建变量"
    echo "Bash 特殊变量"
    echo "\$0                : $0"
    echo "BASH_SOURCE       : $BASH_SOURCE "
    echo "BASH_SOURCE[0]    : ${BASH_SOURCE[0]}"
    echo "BASH_LINENO       : ${BASH_LINENO}"
    echo "FUNCNAME          : ${FUNCNAME}"
    echo "BASH_SUBSHELL     : ${BASH_SUBSHELL}"
    echo "BASH_VERSION      : ${BASH_VERSION}"
    echo "BASH_VERSINFO     : ${BASH_VERSINFO}"
    echo "BASH_XTRACEFD     : ${BASH_XTRACEFD}"
}


bash_builtin_variable


echo
bash_script_o
