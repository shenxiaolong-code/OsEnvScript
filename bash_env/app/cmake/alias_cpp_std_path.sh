#!/bin/bash

bash_script_i

# search cpp std path
# in general, it is /usr/include/c++/
# gcc -v  or g++ -v or  clang++ -v -E clang++
# g++ -E -v -xc++ /dev/null
# search vector under /usr/include/
function init_cpp_dev_path(){
    local cpp_filter_cmd="echo '#include <type_traits>' | g++ -v -x c++ -c - 2>&1 | sed -n '/search starts here:/,/End of search list/{/search starts here:/b;/End of search list/b;p}'"
    # gcc C++ standard library path , e.g. /usr/include/c++/9
    CPP_INCLUDE_PATH=$(eval ${cpp_filter_cmd} | xargs )
    CPP_STD_LIB_PATH=$(eval ${cpp_filter_cmd} | grep -v "x86_64-linux-gnu" | xargs )
    # gcc platform specific path, include arch spec, os spec, platform spec type etc. e.g. /usr/include/x86_64-linux-gnu/c++/9
    CPP_PLATFORM_LIB_PATH=$(eval ${cpp_filter_cmd} | grep "x86_64-linux-gnu" | xargs )
    export CPP_INCLUDE_PATH
    export CPP_STD_LIB_PATH
    export CPP_PLATFORM_LIB_PATH
    [[ ! -z STD_LIB_PATH ]] && {
        dumpkey CPP_STD_LIB_PATH 
        dumpkey CPP_PLATFORM_LIB_PATH
    }
}

function show_cpp_dev_info() {
    dumppos
    dumpkey STD_LIB_PATH 
    dumpkey PLATFORM_LIB_PATH
    echo '#include <type_traits>' | g++ -v -x c++ -c - 2>&1 # | grep -A 20 "#include <...>"
}

function find_cpp_header_compile_denpendency() {
    local header_file=${1:-type_traits}
    dumpinfo "compile std file${red} ${header_file} ${blue}without link"
    echo "#include <${header_file}>" | g++ -v -x c++ -c - 2>&1 | grep -A 20 "#include <...>"
}

init_cpp_dev_path
alias icpp=show_cpp_dev_info
alias xcpp=find_cpp_header_compile_denpendency

bash_script_o
