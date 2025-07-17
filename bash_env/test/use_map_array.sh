
echo "${BASH_DIR}/test/use_map_array.sh"
# very power bash array
# https://www.baeldung.com/linux/bash-array

echo
echo "---------------------------------- associative_array_map : map[key,value] --------------------------------------------------"
declare -A associative_array_map=(["one"]="Baeldung" ["two"]="is" ["three"]="cool")
associative_array_map["four"]="yeah"

idx=two
echo "${idx} : ${associative_array_map["${idx}"]}"          # is
echo "not exist key'abc' value : ${associative_array_map["abc"]}"
echo "Array elements : ${associative_array_map[@]}"
echo "Array elements : ${associative_array_map[*]}"
for element in ${associative_array_map[@]}
    do
        echo "["$element"]"
    done
echo
for element in "${associative_array_map[*]}"
    do
        echo "["$element"]"
    done
echo
for key in ${!associative_array_map[@]}
    do
        echo "["$key"]:["${associative_array_map[$key]}"]"
    done

echo
echo "---------------------------------- indexed_array : array[n] --------------------------------------------------"
declare -a indexed_array
declare -a indexed_array=("Baeldung" "is" "cool")
# indexed_array=([0]="Baeldung" [1]="is" [2]="cool")
# indexed_array=("Baeldung" "is" "cool")
indexed_array[0]="Baeldung"
indexed_array[1]="are"
indexed_array[2]="cool"

echo "No 0 element : ${indexed_array[0]}"          # Baeldung
echo "not exist No.11 value : ${indexed_array[11]}"
echo "Array elements : ${indexed_array[@]}"
echo "Array elements : ${indexed_array[*]}"

for element in ${indexed_array[@]}
    do
       echo "["$element"]"
    done
echo
for element in "${indexed_array[*]}"
    do
        echo "["$element"]"
    done
echo
for index in ${!indexed_array[@]}
    do
        echo "["$index"]:["${indexed_array[$index]}"]"
    done
echo
unset indexed_array[1]
echo "Size of array after removal: ${#indexed_array[@]}"
echo "Array elements after removal: ${indexed_array[@]}"


echo
echo "---------------------------------- Without quotes VS  With quotes in for loop --------------------------------------------------"
declare -a indexed_array=("Baeldung is" "so much" "cool")
echo "Array elements : ${indexed_array[@]}"
echo
echo "Without quotes:"
for element in ${indexed_array[@]}
    do
        echo "["$element"]"
    done
echo
# in general , with quotes is expected
echo "With quotes: in general , with quotes is expected"
for element in "${indexed_array[@]}"
    do
        echo "["$element"]"
    done


echo
echo "---------------------------------- Transforming Arrays  --------------------------------------------------"
# this kind of search is case-sensitive by default
declare -a indexed_array=("Baeldung is" "so much" "cool" "cool cool")
echo "Initial array : ${indexed_array[@]}"
echo "Replacing cool with better: ${indexed_array[@]/cool/better}"
echo "Replacing cool with better: ${indexed_array[@]//cool/better}"
echo "Replacing cool with nothing: ${indexed_array[@]//cool}"

echo
declare -a indexed_array=("Baeldung" "is" "cool")
echo "Initial array: ${indexed_array[@]}"
echo "Uppercasing sentence case: ${indexed_array[@]^}"
echo "Uppercasing all characters: ${indexed_array[@]^^}"

echo
indexed_array=("BAeldung" "Is" "COol")
echo "Initial array: ${indexed_array[@]}"
echo "Lowercasing sentence case: ${indexed_array[@],}"
echo "Lowercasing all characters: ${indexed_array[@],,}"

echo
echo "---------------------------------- Assignment Between Arrays  --------------------------------------------------"
indexed_array=("BAeldung" "Is" "COol")
echo "Initial array: ${indexed_array[@]}"
lowercased_array=(${indexed_array[@],})
echo "Lowercasing sentence case: ${lowercased_array[@]}"

echo
indexed_array=("Baeldung is" "so much" "cool")
echo "Initial array: ${indexed_array[@]}"
echo "Uppercasing sentence case1: ${indexed_array[@]^}"
echo "No of elements in first_array: ${#indexed_array[@]}"
second_array=(${indexed_array[@]})
echo "Uppercasing sentence case2: ${second_array[@]^}"
echo "No of elements in second_array: ${#second_array[@]}"

echo
declare -a fist_array=("Baeldung" "is" "cool")
declare -a second_array=("lorem" "ipsum")
declare -a merged=(${fist_array[@]} ${second_array[@]})
echo "First array : ${fist_array[@]}"
echo "Second array : ${second_array[@]}"
echo "Merged array : ${merged[@]}"

echo
echo "---------------------------------- Offset and Length Traversal  --------------------------------------------------"
declare -a indexed_array=("Baeldung" "is" "cool" "and" "better" "than" "before")
echo "Initial array: ${indexed_array[@]}"
echo "Offset 1 length 3: ${indexed_array[@]:1:3}"
echo "Offset 1 no length: ${indexed_array[@]:1}"
echo "Offset -1 length 3: ${indexed_array[@]: -4:3}"


echo "---------------------------------- Check if a Bash Array Contains a Value  --------------------------------------------------"
# https://www.baeldung.com/linux/check-bash-array-contains-value
array=("one" "two" "potatoes" "bananas" "three" "apples")
value="\<${1}\>" #the value variable is assigned a regex that matches the exact value of the first argument 

if [[ ${array[@]} =~ $value ]]
then
  echo "value found"
else
  echo "value not found"
fi

echo
echo "${BASH_DIR}/test/use_map_array.sh"