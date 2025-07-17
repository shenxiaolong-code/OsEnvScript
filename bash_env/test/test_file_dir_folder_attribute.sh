
# https://www.linuxtechi.com/compare-numbers-strings-files-in-bash-script/

# -d file                  checks if the file exists and is it’s a directory
# -e file                  checks if the file exists on system
# -w file                  checks if the file exists on system and if it is writable
# -r file                  checks if the file exists on system and it is readable
# -s file                  checks if the file exists on system and it is not empty
# -f file                  checks if the file exists on system and it is a file
# -O file                  checks if the file exists on system and if it’s is owned by the current user
# -G file                  checks if the file exists and the default group is the same as the current user
# -x file                  checks if the file exists on system and is executable
# file A -nt file B        checks if file A is newer than file B
# file A -ot file B        checks if file A is older than file B

[[ -L "${file%/}" ]] && echo "is symbol link"

dir=/home/linuxtechi
if [ -d $dir ] ; then
        echo "$dir is a directory"
        cd $dir
        ls -a
else
        echo "$dir is not exist"
fi