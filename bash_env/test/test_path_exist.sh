bash_script_i
echo
echo https://devconnected.com/how-to-check-if-file-or-directory-exists-in-bash/


existedFile=${BASH_DIR}/test/test_path_exist.sh
existedFolder=${HOME}shell_script/bash_env/test
existedFile2=${BASH_DIR}/test/if_else_branch.sh
existedFolder2=${HOME}shell_script/bash_env/test/bash

missingFile=home/xlshen/scratch/shell_script/bash_env/test/test_path.sh
missingFolder=${HOME}shell_script/bash_env/testEx
missingFile2=home/xlshen/scratch/shell_script/bash_env/test/test_path_2.sh
missingFolder2=${HOME}shell_script/bash_env/testEx_2

# "${}"

[[ ! -e ${tmp_build_dir}/cmds/_1_cmake.sh ]] && echo "这个测试会在文件存在时成功，不论它是什么类型的文件。"
[[ ! -L ${tmp_build_dir}/cmds/_1_cmake.sh ]] && echo "这个测试指向普通文件的符号链接时成功"
[[ ! -f ${tmp_build_dir}/cmds/_1_cmake.sh ]] && echo "这个测试会在文件是一个普通文件"


realpath    $(pwd -L)/../abd                         # ${EXT_DIR}/build/abd

[ "$(ls -A '${existedFolder}'" ] && echo "Not Empty" || echo "Empty"
[ "$(ls -A ${existedFolder} )" ] && echo "Not Empty" || echo "Empty"

if [ -d "${existedFolder}" ]
then
	if [ "$(ls -A ${existedFolder})" ]; then
     echo "Take action ${existedFolder} is not Empty"
	else
    echo "${existedFolder} is Empty"
	fi
else
	echo "Directory ${existedFolder} not found."
fi


if [[ -f "${existedFile}" ]]
then
    echo "This file exists on your filesystem."
fi

if [[ -f "${existedFile}" ]] && [[ -f "${existedFile2}" ]]
then
  echo "They exist!"
fi

[[ -f "${existedFile}" ]] && echo "This file exists!"
[ -f "${existedFile}" ] && echo "This file exists!"


if [[ ! -f "${missingFile}" ]]
then
    echo "${missingFile} does not exist on your filesystem."
fi

[[ ! -f "${missingFile}" ]] && echo "This file does not exist!"
[ ! -f "${missingFile}" ] && echo "This file does not exist!"
[[ -f "${missingFile}" ]] || echo "This file does not exist!"



if [[ -d "${existedFolder}" ]]
then
    echo "${existedFolder} exists on your filesystem."
fi
[[ -d "${existedFolder}" ]] && echo "This directory exists!"

[ -d "${existedFolder}" ] && echo "This directory exists!"


# usage : ${BASH_DIR}/test/test_path_exist.sh  /etc/passwd /etc/pass /etc/file
#!/bin/bash

# Using argument expansion to capture all files provided as arguments.
for FILE in ${@}
do
  if [[ ! -f $FILE ]]
  then
    echo "The file ${FILE} does not exist!"
  fi
done


echo
bash_script_o
