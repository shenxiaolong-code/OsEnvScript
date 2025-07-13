bash_script_i

alias   cdp='cd $(pwd -P)'                              # cd to physical path

alias   cdroot='cd ${EXT_DIR} ; list_dir_with_reversed_index ;'
alias   cdsh='cd ${BASH_DIR} ; list_dir_with_reversed_index ;'
alias   cdtmp='cd ${TEMP_DIR} ; list_dir_with_reversed_index ;'
alias   cdcache='cd ${CACHE_DIR} ; list_dir_with_reversed_index ;'
alias   cdbak='cd ${BACKUP_DIR} ; list_dir_with_reversed_index ;'
alias   cdtest='cd ${TEST_DIR} ; list_dir_with_reversed_index ;'
alias   cddep='cd ${DEPENDENCY_DIR}; list_dir_with_reversed_index ;'   # dependency folder, can't be deleted
alias   cddel='cd $( mktemp -d -p ${TEMP_DIR}/to_del )'

alias   ldel='ll ${TEMP_DIR}/to_del ;'

bash_script_o
