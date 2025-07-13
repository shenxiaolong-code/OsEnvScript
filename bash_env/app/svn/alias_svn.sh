bash_script_i

# install svn client on linux
# sudo apt update && sudo apt install subversion -y

source ${BASH_DIR}/app/svn/svn_server_manage.sh

# 创建一个函数来处理svn diff并用VSCode打开
# svn_diff_a_file_in_vscode <file_relative_path>
# svn_diff_a_file_in_vscode app/svn/alias_svn.sh

function svn_diff_a_file_in_vscode() {
    local svn_file=$1
    [[ ! -f $svn_file ]] && { dumperr "file not exist: $svn_file" ; return 1 ;}
    local svn_root_dir=$(svn info ${svn_file} | grep -oP "Working Copy Root Path: \K.*" | update_symbol_path)    
    [[ ! -d $svn_root_dir/.svn ]] && { dumperr "svn_root_dir not exist: $svn_root_dir" ; return 1 ;}
    
    local file_checksum=$(svn info ${svn_file} | grep -oP "Checksum: \K.*")
    local base_file=${svn_root_dir}/.svn/pristine/${file_checksum:0:2}/${file_checksum}.svn-base    
    
    if [ -f "$base_file" ]; then
        #e.g : ide --diff '${BASH_DIR}/.svn/pristine/4c/4c8b91fdf829d031b2619ee86ae522a8f414f049.svn-base' '${BASH_DIR}//init/alias_color.sh'
        full_file_path=${svn_root_dir}/${svn_file/${svn_root_dir}/}
        echo "ide --diff '$base_file' '${full_file_path}'"
        #cursor --diff "$base_file" "$full_file_path"
        return 0
    else
        echo "# Base svn_file not found: $base_file"
        return 1
    fi
}

function svn_diff_all_files_in_vscode(){
    local svn_dir=${1:-$(pwd -L)}
    [[ ! -d $svn_dir/.svn ]] && { dumperr "dir not exist: $svn_dir" ; return 1 ;}
    
    local svn_diff_cmd_file=${TEMP_DIR}/to_del/svn_diff_cmd_$(date "+%Y%m%d_%H%M%S").sh
    svn status ${svn_dir} | while read -r status file ; do
        # echo "status: $status, file: $file"
        {
            svn_diff_a_file_in_vscode  ${file}
            echo pause
        } >> ${svn_diff_cmd_file}
    done
    cat ${svn_diff_cmd_file}
    dumpkey svn_diff_cmd_file
}

alias svndiffs='svn_diff_all_files_in_vscode'
function svn_diff_a_file_local_modification_in_vscode(){
    [[ -f $1 ]] && eval $(svn_diff_a_file_in_vscode $1) || { svn status . ; dumpinfo "usage ${brown} : svndiff <file_path> " ;}
}
alias svndiff='svn_diff_a_file_local_modification_in_vscode'

function checkout_svn_repo(){
    local svn_url=$1
    if [[ -z $svn_url ]] ; then
        dumpinfo "usage: ${brown} svnco <svn_url> ${end}"
        return 1
    fi
    dumpkey svn_url
    if [[ $svn_url =~ "127.0.0.1" ]] ; then
        # it is local svn repo, update svn server ip
        local real_ip=$(svn info ${BASH_DIR} | grep -P "^URL: " | grep -oP "[0-9.]+")
        local new_svn_url=$(echo ${svn_url} | sed "s#127.0.0.1#${real_ip}#")
        dumpinfo "${azure_256}${svn_url}${end} => ${lime_256}${new_svn_url}${end}"
        svn_url=${new_svn_url}
    fi

    run_svn_cmd_need_pwd checkout ${svn_url}
    if [[ $? -ne 0 ]] ; then
        dumpinfo "checkout svn repo failed, please check the svn url: ${svn_url}"
        return 1
    else
        dumpinfo "checkout svn repo success:${orange_24} ${svn_url}"
        run_svn_cmd_need_pwd info ${svn_url}
    fi
}

function relocate_svn_server_ip() {
    local new_ip=$1
    if [[ -z ${new_ip} ]] ; then
        echo "${red}Please input new svn server ip, e.g. 127.0"
        return 0
    fi
    dumpinfo "relocate svn server ip to${red} ${new_ip}"

    # svn relocate MUST operate on a svn root url, not a svn subdirectory
    svn_root_url_path=$(svn info | grep -oP "^Repository Root: \K.+")
    # dumpkey svn_root_url_path
    local old_ip=$(echo ${svn_root_url_path} | grep -oP "[0-9.]+")
    if [[ -z ${old_ip} ]] ; then
        dumperr "svn ip is not found from svn root url, please check your svn repo"
        return 1
    fi
    if [[ ${old_ip} == ${new_ip} ]] ; then
        dumpinfo "svn server ip is already ${new_ip}, no need to relocate"
        return 0
    fi
    dumpinfo "${azure_256}${old_ip}${end} => ${lime_256}${new_ip}${end}"
    local new_svn_root_url_path=$(echo ${svn_root_url_path} | sed "s#${old_ip}#${new_ip}#")
    # https://127.0.0.1/svn/svnRepo => https://192.168.0.102/svn/svnRepo
    dumpinfo "relocate svn repo : ${azure_256}${svn_root_url_path}${end} => ${lime_256}${new_svn_root_url_path}${end}"
    run_svn_cmd_need_pwd relocate ${new_svn_root_url_path}
    echo
}

function show_svn_commit_id_related_cmd() {
    echo
    dumpinfox  "run cmd '${red} hsvn ${blue}' to show svn commit id related cmd"
    dumpinfo "general svn command:"
    echo "checkout repo         : svn co https://10.19.180.103/svn/work/linuxPratice/linuxScript"
    echo "update                : svn up ."
    echo "check modification    : svn st"
    echo "add all new files     : svn add ./*"
    echo "add file or folder    : svn add <path>"
    echo "del file from repo    : svn del <path>"
    echo "del foler from repo   : svn rm <path>"
    # delete all missing file   : svn st | grep ^! | awk '{print " --force "$2}' | xargs svn rm
    # delete file 2             : find ./ -type f -iname "2" | grep -v "/.svn/" | xargs rm ${1}
    echo "ignore foler          : svn propset svn:ignore ./output"
    echo "ignore file           : svn propset svn:ignore -F ignoring.txt"
    echo "commit                : svn commit -m 'svn commit message'"
    echo "autho info            : svn info | svn --version | svn auth"
    echo "revert all change     : svn revert -R ."
    echo "revert modificatio    : svn revert <path>"
    echo "delete no-added files : svn cleanup . --remove-unversioned  "
    echo "svn clean             : svn cleanup --non-interactive  "
    echo

    echo
    # ${BASH_DIR}/app/svn/alias_svn.sh
    echo "${green}use '${brown}hhsvn${green}' to list all svn user cmd. ${end}"
    echo "${green}use '${brown}isvn${green}' to list svn file configuration. ${end}"
    echo "${green}use '${brown}svnco${green}' to checkout new svn repo. ${end}"
    echo "${green}use '${brown}svnst${green}' to list svn file statue. ${end}"
    echo "${green}use '${brown}svnrm${green}' to remove not existed file. ${end}"
    echo "${green}use '${brown}svnadd${green}' to add new unversioned file. ${end}"
    echo "${green}use '${brown}svnc${green}' to commit current svn change. ${end}"
    echo "${green}use '${brown}list_remote_svn_repo${green}' to list all remote svn repo. ${end}"
    echo "${green}use '${brown}add_svn_repo${green}' to add new svn repo of current dir. ${end}"
    echo "${green}use '${brown}remove_svn_repo${green}' to remove svn repo. ${end}"
    echo "${green}use '${brown}atl+d${green} ( SVN: Open Changes with BASE )' to compare active file local modificaton. ${end}"
    dumpinfo "${BASH_SOURCE[0]}:148"
}

function commit_all_svn_repo_on_linux() {    
    dumpinfo "only show svn status without any parameter, else it will commit all changes."
    if [[ $# -ne 0 ]] ; then
        action_st_or_commit='commit -m "update"'
        dumpinfo "commit all changes"
    else        
        action_st_or_commit=status
        dumpinfo "show svn status"
    fi
    [[ $action_st_or_commit != "status" ]] && dumpinfo "press_any_key_to_continue or cancel by ctrl+c" && pause
    
    run_svn_cmd_need_pwd ${action_st_or_commit} ${BASH_DIR}
    run_svn_cmd_need_pwd ${action_st_or_commit} ${EXT_DIR}/repo/linux_pratice
    dumpinfo "without any parameter, it will only show svn status, else it will commit all changes"
}

function run_svn_cmd_need_pwd(){
    dumpcmd "svn $@"
    local svn_user="xlshen"    
    svn --username "${svn_user}" --non-interactive "$@" >/dev/null 2>&1
    [[ $? -eq 0 ]] && {
      # no need password
      # dumpinfo "no need password for svn user ${svn_user}"
      svn --non-interactive "$@"
    } || {
      # need password
      # dumpinfo "need password for svn user ${svn_user}"
      svn --username ${svn_user} --password 'aaAA11!!' --non-interactive "$@"
    }    
    donecmd
}

function commit_svn_change(){
    run_svn_cmd_need_pwd    up  $1
    run_svn_cmd_need_pwd    commit -m "${2:-update}"  $1
}

function show_svn_repo_status(){
    svn st | sed "s# \+#\t$(pwd -L)/#"
}

alias   svnip=relocate_svn_server_ip
alias   isvn='svn info'                                                                         # information for svn
alias   svni=isvn
alias   hsvn=show_svn_commit_id_related_cmd                             # help for svn
alias   hhsvn="list_function_in_script_file ${BASH_SOURCE[0]}"          # help for svn
alias   svnst='show_svn_repo_status'
alias   svnrm='svnst | grep "!" | cut -d"!" -f2 | xargs -I @ svn rm --keep-local @'
alias   svnadd='svnst | grep "?" | cut -d"?" -f2 | xargs -I @ svn add @'

alias   svnco='checkout_svn_repo'
alias   svna=commit_all_svn_repo_on_linux
alias   svnc="commit_svn_change ."
alias   svnsh='commit_svn_change ${BASH_DIR}'
# alias   svncsh='commit_svn_change ${HOME}/csh_env'
alias   svnup="run_svn_cmd_need_pwd up"

alias   mysvn="source ${BASH_DIR}/app/svn/info_svn.sh"

bash_script_o
