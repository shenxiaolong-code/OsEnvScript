
# in csh  shell : source xxx.csh        |&      tee log.txt
# in bash shell : source xxx.sh  2>&1   |       tee log.txt

lscpu -dd       2>&1    |  tee      "${TEMP_DIR}/to_del/log1.txt"

# forece overwrite a file if it exists
echo "some text"      >|   ${TEMP_DIR}/existing_file.txt

# overwrite a existing file with echo show
echo "text" | tee "${TEMP_DIR}/to_del/TheAccount.txt"
# overwrite a existing file without echo show
echo "text" | tee "${TEMP_DIR}/to_del/TheAccount.txt" > /dev/null

echo content of log1.txt :
cat "${TEMP_DIR}/to_del/log1.txt"

# show and save
(                                                   \
    echo run multiple comand .                      \
    &&  echo use '\' to connect many command        \
    &&  lscpu                                       \
    &&  lscpu -dd                                   \
)  |  tee  "${TEMP_DIR}/to_del/mulLog.txt" 

echo "${TEMP_DIR}/to_del/mulLog.txt" 

# https://tldp.org/LDP/abs/html/special-chars.html#BRACEEXPREF
# only save without show 
{ # Begin code block.
  echo
  echo "Archive Description:"
  rpm -qpi $1       # Query description.
  echo
  echo "Archive Listing:"
  rpm -qpl $1       # Query listing.
  echo
  rpm -i --test $1  # Query whether rpm file can be installed.
  if [ "$?" -eq $SUCCESS ]
  then
    echo "$1 can be installed."
  else
    echo "$1 cannot be installed."
  fi  
  echo              # End code block.
} > "${TEMP_DIR}/to_del/$1.test"       # Redirects output of everything in block to file.

echo "${TEMP_DIR}/to_del/$1.test"