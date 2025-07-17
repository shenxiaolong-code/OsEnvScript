bash_script_i
echo

# see ${BASH_DIR}/test/test_echo.sh
# set -B            # Enable brace expansion (default setting = on)
echo {a..z}         # a b c d e f g h i j k l m n o p q r s t u v w x y z
echo {1..8}         # 1 2 3 4 5 6 7 8
echo {1..8} | xargs -n3 echo $1
echo {1..8} | xargs -n2 sh -c 'echo "the number $1 comes before $2"' sh

find * -prune -type d | while IFS= read -r d; do 
    echo "${d}"
done

ll | while read -r per_line; do
    echo "${per_line}"
done | head -n 3

# git status --porcelain 
echo  M cmake/Download.cmake | while read -r status file ; do
    echo "status: $status, file: $file"
done
echo  11 22 33 | while read -r col1 col2 col3 ; do
    echo "col2: $col2, col1: $col1,  col3: $col3"
done

for per_word in $(ls) ; do
    echo ${per_word}
done

for i in {1..3}; do
  for j in {1..3}; do
    if [ "$j" -eq 2 ]; then
      break 2                     # exit 2 layer loop
    fi
    echo "i=$i, j=$j"
  done
done

# process folder
for d in */ ; do
    echo "folder : ${d}"
done

for file in `ls .` ; do
    echo "file : ${file}"
done

for d in */ ; do
    # exclude symlinks, 
    [ -L "${d%/}" ] && continue
    echo "${d}"
done

my_array=(foo bar)
my_array=("cat" "dog" "mouse" "frog")

echo array legnth : ${#my_array[@]}
echo all array element : ${my_array[@]}
echo all array element : ${my_array[*]}
echo 1st element : ${my_array[0]}           # bash array index begin from 0,    tcsh array index begin from 1
echo 2nd element :${my_array[1]}

for i in "${my_array[@]}"; do echo "$i"; done
for i in "${my_array[*]}"; do echo "$i"; done

for str in ${my_array[@]}; do
  echo "current element value is ${str}"
done

for i in ${!my_array[@]}; do
  echo "element index $i is ${my_array[$i]}"
done

search_dir="${HOME}shell_script/bash_env/nvidia/bash/init"
for entry in `ls ${search_dir}`; do
    echo cur file : ${search_dir}/${entry}
done

read_variable  multi_kernel_family  multi_kernel_family
testKernelArray=( $(echo ${multi_kernel_family} | sed 's/|/ /' | sed 's/*//g') )
kernel_sm70=${testKernelArray[0]}

echo "multi_kernel_family : ${multi_kernel_family}"
echo "testKernelArray   : ${testKernelArray[*]}"
echo "kernel_sm70         : ${kernel_sm70}"


cd  ${cur_build_dir}/install/bin
echo

for i in ${testKernelArray[@]}; do
    echo "./cask-sdk-cask-tester  print_kernel_info ${i}   | grep STRIDE "
    echo
done



# https://www.yiibai.com/bash/bash-case-statement.html
if [[ "$1" == "" ]]; then
  echo "no option"
else 
  case $1 in
    pattern-1)
      commands
      ;;
    pattern-2)
      commands
      ;;
    pattern-3)
      commands
      ;;
    pattern-N)
      commands
      ;;
    *)
    commands
    ;;
  esac
fi


echo
bash_script_o
