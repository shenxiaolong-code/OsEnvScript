
# bash  ${BASH_DIR}/test/align_format_string.sh
# https://www.runoob.com/linux/linux-shell-printf.html
# https://stackoverflow.com/questions/6345429/how-do-i-print-some-text-in-bash-and-pad-it-with-spaces-to-a-certain-width



echo -e
# use "" for string with blank space
dumpinfox "align with \\"
{
    printf "%-124s\\\\\\n"  "stdbuf -oL cmake ${cmake_debug}"   \
    "-S ${cur_repo_dir}"                                        \
    "-B ${cur_build_dir}"                                       \
    -DCMAKE_BUILD_TYPE=Debug                                    \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON                          \
    -DCMAKE_POLICY_DEFAULT_CMP0025=NEW                          \
    -DCMAKE_C_COMPILER=gcc                                      \
    -DCMAKE_CXX_COMPILER=g++                                    \
    -DCMAKE_INSTALL_PREFIX=${cur_build_dir}/install             \
    -DDKG_ENABLE_ASSERTIONS=ON                                  \
    -DCASK_API_RUN_CUDA_SM100_TESTS=ON                          \
    -DDKG_ENABLE_TESTING=ON                                     \
    -DCASK_API_INCLUDE_TESTS=ON                                 \
    -DCASK_API_BUILD_REFERENCE_KERNELS=ON                       \
    -DCASK_API_BUILD_LLVM_JIT_EXECUTION=ON                      \
    "-DDKG_ENABLE_PROJECTS='cutlass_ir;cask_api'"
    echo
}
{
  echo_align "cmake ${cmake_debug}"       \
  "-S ${cur_repo_dir}"                    \
  "-B ${cur_build_dir}"                   \
  "-DCMAKE_BUILD_TYPE=Debug"              \
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"    \
  "-DCMAKE_POLICY_DEFAULT_CMP0025=NEW"
  echo  
}

# if replaced string includes speci chars, need ''
dumpinfox "formant enviromnet LD_LIBRARY_PATH:"
echo -e "LD_LIBRARY_PATH   : ${LD_LIBRARY_PATH//:/'\r\n                    '}"
dumpinfo "formant enviromnet PATH:"
echo -e "PATH              : ${PATH//:/'\r\n                    '}"

echo -e

y="-DXMMA_KERNELS_ENABLED='sm90_xmma_gemm_f64f64_f64f64_f64_nt_n_tilesize128x128x16_stage3_warpsize4x2x1_tensor16x8x16|cask_core_gemm_generic_ref_gpu_f64f64_f64_f64_nt_n_bias_f64'"
function wrap_string() {  
  raw_string=$1
  lineLength=${2:-50}  
  dumpinfo " align string to $lineLength length wrap to multiple lines : "
  i=0
  while [[ -n "${y:$((lineLength*i)):$lineLength}" ]]; do
    # echo -e  "$((lineLength*i)):$lineLength"
    printf "\t%s\n" "${y:$((lineLength*i)):$lineLength}"
    ((i++))
  done  
}
wrap_string "${y}"  "50"
wrap_string "${y}"  "80"
wrap_string "${y}"  "120"


echo -e
dumpinfox -n printf "|%-10s|"
printf "|%-10s|\n" a ab abc abcd abcde

echo -e
dumpinfox -n printf "|%10s|"
printf "|%10s|\n" a ab abc abcd abcde


echo -e
dumpinfox -n trunc : printf "|%.4s|"
printf "|%.4s|\n" a ab abc abcd abcde

echo -e
dumpinfox "expand tab char to 20 column:"
printf "${green}Network %s\t: %s\n${end}"     "$(hostname)"   "state"   | expand -t 20
printf "${green}Network %s\n: %s\n${end}"     "$(hostname)"   "state"   | pr -at2

echo -e
dumpinfox "auto align"
{
  echo -e "-DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc   \\"
  echo -e "-DCUDA_VERSION_ERROR_CHECK_ENABLED=OFF   \\"
} | column -t

echo -e
dumpinfox "auto align with split char"
{
  echo -e "-DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc  =\\"
  echo -e "-DCUDA_VERSION_ERROR_CHECK_ENABLED=OFF =\\"
} | column -t -s'='

echo
dumpinfox "format string"
echo -e "column1  column2"   | xargs -l bash -c ' printf "1st : %-15s  2nd : %s   \n"  $0  $1 '
echo -e "111  2222  333 "    | xargs -l bash -c ' printf "1st : %-15s  2nd : %s   \n"  $0  $1 '      # process one line per this usage
echo -e "222  555  666 "     | xargs -l bash -c ' printf "1st : %-15s  2nd : %s   \n"  $0  $1 '

 
echo -e
dumpinfox "align multiple column"
echo -e "dockerName  cask-build:gcc_6.3.1-cmake_3.24.2-python_3.8.2-cuda_gpgpu_33322260-fc284aef"  | xargs -l bash -c ' printf "keyname : %-16s  keyval : %-s\n"  $0  $1 '

echo -e
echo -e "${green}${BASH_SOURCE[0]}${end}:${brown_L}$LINENO${end}"
echo -e


