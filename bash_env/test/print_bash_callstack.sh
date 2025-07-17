

function fun1() {
    echo "fun1();"      ;
    print_call_stack      ;
    # print_stack_and_args ； 
    # print_call_stack2   ;
}
function fun2() {
    echo "fun2();" ;
    fun1    11 ;
}
function fun3() {
    echo "fun3();"      ;
    fun2  22 ;
}
function fun4() {
    echo "fun4();"      ;
    fun3  33 ;
}

function print_call_stack() {
    local i=0
    while frames=$(caller $i); do
        # echo "$frames"
        # echo "[0] ${frames[0]}   [1] ${frames[1]}   [2] ${frames[2]}   [3] ${frames[3]}   "
        # echo -e "-------------------------------------------------------------------------------"
        # echo -e "${green}src       :${brown} ${BASH_SOURCE[$((i+1))]}:${BASH_LINENO[$i]}  ${end}"
        # echo -e "${green}func name :${brown} ${FUNCNAME[$i]}  ${end}"
        # echo -e "${green}func args :${brown} ${BASH_ARGV[@]:$i}  ${end}"
        parts=(${frames[0]})
        printf "[ %-6s ] %-96s  -  %-12s => %-12s => %s\r\n"  ${parts[1]} ${parts[2]}:${parts[0]} ${FUNCNAME[$i+2]} ${FUNCNAME[$i+1]} ${FUNCNAME[$i]}
        ((i++))
    done
}

function print_stack_and_args() {
    local i=0
    while caller $i &>/dev/null; do
        echo -e "-------------------------------------------------------------------------------"
        echo -e "${green}src       :${brown} ${BASH_SOURCE[$((i+1))]}:${BASH_LINENO[$i]}  ${end}"
        echo -e "${green}func name :${brown} ${FUNCNAME[$i]}  ${end}"
        echo -e "${green}func args :${brown} ${BASH_ARGV[@]:$i}  ${end}"

        # local args="${FUNCNAME[$i]}: "
        # for arg in ${BASH_ARGV[@]:$i}; do
        #     args+="$arg "
        # done
        ((i++))
    done
}

function print_call_stack2() {
    local i=0
    local stack=""
    while frames=$(caller $i); do
        stack+="$frames\n"
        ((i++))
    done
    echo -e $stack
}

fun4

