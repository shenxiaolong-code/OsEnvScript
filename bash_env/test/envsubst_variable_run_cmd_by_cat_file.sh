bash_script_i
echo

# read specified key from ini file , refer to :
# read_variable()

test_file=${EXT_DIR}/build/_bd_template_cask6/cmds/_1_cmake.sh

# grep "=" ${test_file} | grep -v "\-D" | bash
# the bash command will not work, because the bash command will run in a subshell, and the env vars will not be exported to the parent shell

echo
dumpinfox "cmd content from file :${brown} ${test_file}"
grep "=" ${test_file}  | grep -v "\-D" | grep -v "fetch_sm_arch"

echo
dumpinfox "run cmd by file content"
source <(grep "=" ${test_file} | grep -v "\-D" | grep -v "fetch_sm_arch" )

dumpkey     ffma_fprop
dumpkey     ffma
dumpkey     first_layer
dumpkey     bn_stat
dumpkey     build_archs

echo
dumpinfox "use envsubst to expand the vars"
# envsubst can only expand the exported vars, so we need to export the vars first
grep "=" ${test_file} | grep -v "\-D" | grep -v "fetch_sm_arch" | sed 's/^/export /'
source <( grep "=" ${test_file} | grep -v "\-D" | grep -v "fetch_sm_arch" | sed 's/^/export /' )
echo 'envsubst value : ${first_layer}' | envsubst 

echo
dumpinfox "test run cmd by cat file"
grep "ffma_fprop" ${BASH_SOURCE[0]} | grep -v "source" 
source <(grep "ffma_fprop" ${BASH_SOURCE[0]} | grep -v "source" )


echo
bash_script_o
