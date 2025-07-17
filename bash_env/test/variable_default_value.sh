bash_script_i
# https://stackoverflow.com/questions/2013547/assigning-default-values-to-shell-variables-with-a-single-command-in-bash
echo

variable1=$1
variable2=${2:-$variable1}

echo "variable1=$variable1"
echo "variable2=$variable2"

# ****************************************  ${parameter:+word}  vs ${parameter:-word}  **********************************
var="Hello"
echo ${var:+World}  # 输出 World，因为 var 不为空

var=""
echo ${var:+World}  # 输出空字符串，因为 var 为空

var="Hello"
echo ${var:-World}  # 输出 Hello，因为 var 不为空

var=""
echo ${var:-World}  # 输出 World，因为 var 为空

# **************************************************************************************************************
echo
# var_err=${1:?"Specify a username"}
ACTION=${1:?"Specify 'action' as argv[1]"}
DIRNAME=${2:-`pwd -L`}
OUTPUT_DIR=${3:-${HOMEDIR:-"/tmp"}}

echo "ACTION=$ACTION"
echo "DIRNAME=$DIRNAME"
echo "HOMEDIR=$HOMEDIR"
echo "OUTPUT_DIR=$OUTPUT_DIR"

# **************************************************************************************************************
unset var
echo
echo "${var}"
echo "Substitute the value of var."

echo "${var:-word}"
echo "If var is null or unset, word is substituted for var. The value of var does not change."

echo "${var:=word}"
echo "If var is null or unset, var is set to the value of word."

echo "${var:?message}"
echo "If var is null or unset, message is printed to standard error. This checks that variables are set correctly."

echo "${var:+word}"
echo "If var is set, word is substituted for var. The value of var does not change."

bash_script_o
