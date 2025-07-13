# https://stackoverflow.com/questions/9814185/how-to-access-environment-variables-inside-gdbinit-and-inside-gdb-itself

print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

import os

# use below cmd to check whether environment var is defined
# show env
# need the environment var ' CMAKE_PATH ' is set
gdb.execute('directory' + os.environ['CMAKE_PATH'] + '/bin')

# run below cmd to check the result :
# show directories

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')