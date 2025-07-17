
# https://www.runoob.com/linux/linux-shell-basic-operators.html

string="abc"

if [[ ${#string} <= 5 ]]; then
  echo "String length is less than or equal to 5"
else
  echo "String length is greater than 5"
fi


val=`expr 2 + 2`
echo "sum : $val"

echo "2+2 = $(( 2 + 2 ))"

a=10
b=20

echo "a+1 : $((  $a+1  ))"
echo "b+2 : $((  $b+1  ))"

echo "a + b = $(( $a + $b ))"
echo "b / a = $(( $b / $a ))"
echo "b % a = $(( $b % $a ))"

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a equal to b"
fi
if [ $a != $b ]
then
   echo "a not equal to b"
fi

# https://www.linuxtechi.com/compare-numbers-strings-files-in-bash-script/
# num1 -eq num2      #  num1 == num2  
# num1 -ge num2      #  num1 >= num2
# num1 -gt num2      #  num1 >  num2   
# num1 -le num2      #  num1 <= num2
# num1 -lt num2      #  num1 <  num2   
# num1 -ne num2      #  num1 != num2  

var1=10
var2=20
if [ $var2 -gt $var1 ] ; then
   echo "$var2 is greater than $var1"
fi

# Second comparison
if [ $var1 -gt 30 ] ; then
   echo "$var is greater than 30"
else
   echo "$var1 is less than 30"
fi

