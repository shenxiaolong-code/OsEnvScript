bash_script_i

echo "full result:" 
egrep --color=auto  "^ *(struct|class|enum .*) +TestCase"  ${REPO_DIR_CASK6}/tools/tester/src/testcase.hpp  ;

# echo 
# cat ${REPO_DIR_CASK6}/tools/tester/src/testcase.hpp | egrep   --color=auto  "^class +TestCase" | od -A n -t x1 


echo
echo "expected: only 'class TestCase'" 
cat ${REPO_DIR_CASK6}/tools/tester/src/testcase.hpp | egrep  --color=auto  "^class +TestCase[\r\n]"
# egrep -rnI --exclude-dir={.svn,.git,.vscode}  --color=auto  "^ *(struct|class|enum .*) +TestCase[ {:]"  "${cur_repo_dir}"  ;

echo
echo "HEX string"
echo "TestCaseResult" | od -A n -t x1
echo "TestCase" | od -A n -t x1
echo "c.e" | od -A n -t x1 


# search "grep can't match Carriage Return"
# https://unix.stackexchange.com/questions/214770/grep-doesnt-match-carriage-return-characters

# https://serverfault.com/questions/317372/grep-recognize-carriage-return-as-new-line

bash_script_o
