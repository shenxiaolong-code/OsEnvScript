

# https://stackoverflow.com/questions/667540/full-command-line-as-it-was-typed
# test : python3 /home/xiaolongs/linuxRepo/python_test/utils/print_full_cmdline.py 1 2 3 4 5

import sys
import inspect
from print_python_color import *
print(f'\033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

# suggested :
def printFullCmdline():    
    import sys
    import os
    import shlex
    import inspect
    print(f'cmdline: {sys.argv}')
    print(f'show cmdline :\033[93m  {inspect.stack()[0][1]}:{inspect.stack()[0][2]}  \033[0m')
    print(f'PYTHONPATH   :\033[95m  {os.environ.get("PYTHONPATH")}  \033[0m')
    print("full cmdline :\033[92m ", sys.executable, " ".join(map(shlex.quote, sys.argv)),"  \033[0m")
    print("full cmdline :\033[94m ", ' '.join(sys.argv),"  \033[0m")
    # add two blank chars to easy copy content
    # debug print data
    # print(inspect.getmembers(self.data))
    # exit()  

def cmdline():
    print(f'\r\ncmd: python {" ".join(sys.argv)}\r\n{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')

def printFullCmdline_other_ways():    
    import psutil               # pip install psutil
    import os
    import sys
    my_process = psutil.Process( os.getpid() )
    print("No 1 : ",  my_process.cmdline() )

    my_parent_process = psutil.Process( my_process.ppid() )
    print("\nNo 2 : ",  my_parent_process.cmdline() )

    commandstring = '';
    for arg in sys.argv:
        if ' ' in arg:
            commandstring += '"{}"  '.format(arg);
        else:
            commandstring+="{}  ".format(arg);
    print("\nNo 3 : ", commandstring);


printFullCmdline()
print(f'\033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
print(f'\r\ncmd: python {" ".join(sys.argv)}\r\n{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')

