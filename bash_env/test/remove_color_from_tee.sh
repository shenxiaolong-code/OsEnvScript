bash_script_i
# https://stackoverflow.com/questions/8720508/bash-tee-remove-color

# tem_file_log=${TEMP_DIR}/to_del/temp_$RANDOM.log

# below cmd can log everything to the log file include text color info
# exec 4<&1 5<&2 1>&2>&>(tee -a $tem_file_log)

# below cmd can log everything to the log file without text color info
# exec 4<&1 5<&2 1>&2>&>(tee -a >(sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' > $tem_file_log))
# exec 4<&1 5<&2 1>&2>&>(tee -a >(sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' > ${tem_file_log} ))


# | sed 's/.*/$/' will remove color control char
# ls | grep txt | sed 's/.*/prefix&suffix/'

# https://unix.stackexchange.com/questions/694671/leave-color-in-stdout-but-remove-from-tee
# NOTE : different bin output color with different code, it needs different sed filter

echo -E "${green}"                  # \e[0;32m

# suggestion : use ${BASH_DIR}/nvidia/bin/remove_color_from_log_file.sh , instead of it

echo
tem_file_log=${TEMP_DIR}/to_del/temp_$RANDOM.log
echo -e "color \033[1;31mRED\033[0m output" | tee >(sed $'s/\033[[][^A-Za-z]*m//g' > "${tem_file_log}" )
echo    "log : ${green}${tem_file_log}${end}"

echo
# fileter bash terminal color code
tem_file_log=${TEMP_DIR}/to_del/temp_$RANDOM.log
echo -e "# ${green}search text ${brown}111111${green} in file ${red}${curFile}  ${end}." | tee >(sed $'s/\e[[][^A-Za-z]*m//g' > "${tem_file_log}" )
echo -e   "log : ${green}${tem_file_log}${end}"

echo
# fileter grep color output color code
tem_file_log=${TEMP_DIR}/to_del/temp_$RANDOM.log
egrep --color=always -niRH   "bash_script" ${BASH_DIR}/test/test_path_exist.sh  | tee >(sed -E $'s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' > "${tem_file_log}" )
echo -e "log : ${green}${tem_file_log}${end}"

echo
# fileter combination
tem_file_log=${TEMP_DIR}/to_del/temp_$RANDOM.log
(
    echo -e "# ${green}search text ${brown} 22222 ${green} in file ${red} some file  ${end}."
    egrep --color=always -niRH   "bash_script" ${BASH_DIR}/test/test_path_exist.sh 
)  | tee >(sed $'s/\e[[][^A-Za-z]*m//g' | sed -E $'s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g'  > "${tem_file_log}" )
echo -e "log : ${green}${tem_file_log}${end}"


echo
bash_script_o
