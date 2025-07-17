bash_script_i
echo
# https://stackoverflow.com/questions/7131670/make-a-bash-alias-that-takes-a-parameter
# usage : myfunction  abc

# the char ; MUST exists in line tail
myfunction()    { echo mv "$1" "$1.bak" ; }
junk()          { for item in "$@" ; do echo "Trashing: $item" ; echo mv "$item" ~/.Trash/; done; }

# bash function must be end with ; , else error :   syntax error: unexpected end of file
myfunction()    {  mv "$1" "$1.bak" ;    cp "$2" "$1" ; }

myfunction() {
    #do things with parameters like $1 such as
    mv "$1" "$1.bak"
    cp "$2" "$1"
}


echo
bash_script_o