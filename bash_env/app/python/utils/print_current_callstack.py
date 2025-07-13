
import os
import inspect
import traceback
from   print_python_color import *    # import  {py_xxx}, e.g. {py_blue}, {py_end}

# https://docs.python.org/3/tutorial/inputoutput.html
# print(f'\033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

def python_script_i():
    # print(f'# +++++++++ loading {inspect.stack()[1][1]}:{inspect.stack()[1][2]}' + os.path.basename({inspect.stack()[2][1]}) + f':{inspect.stack()[2][2]}')
    stack = inspect.stack()
    print(f'# +++++++++ loading {stack[1][1]}:{stack[1][2]} ' + (f'{os.path.basename(stack[2][1])}:{stack[2][2]}' if len(stack) >= 3 else ''))

def python_script_o():
    print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

def print_stack_all():
    traceback.print_stack()

def print_stack_from_level(level):
    # 获取当前栈帧
    current_frame = inspect.currentframe()
    
    # 向上移动到所需的级别
    for _ in range(level):
        if current_frame is not None:
            current_frame = current_frame.f_back
    
    # 打印从指定级别开始的堆栈跟踪
    traceback.print_stack(f=current_frame)

def dumpstack(level=2):    
    print_stack_from_level(level)
    # traceback.print_stack()
    print('\n')

def dumppos(offset=0):
    funcName = '__main__' if inspect.stack()[1 + offset][3] == '<module>' else inspect.stack()[1][3]
    print(f'# [{py_black} dumppos  {py_end}] {funcName} {py_black}{inspect.stack()[1 + offset][1]}:{inspect.stack()[1 + offset][2]} {py_end}')

def dumpinfo(msg):
    print(f'# [{py_green_L} dumpinfo {py_end}]{py_blue} {msg}{py_end}')

def dumpinfox(msg):
    dumppos(1)
    dumpinfo(msg)

def dumperr(msg):
    dumppos(1)
    print(f'# [{py_red_L} dumperr {py_end}]{py_blue} {msg}{py_end}')
    dumpstack(3)

def ut_dumperr():
    dumperr("test dumperr")

def ut_dump_xxxx():
    print(f'\n{py_blue}test {py_red}dumppos{py_end}')
    dumppos()
    print(f'\n{py_blue}test {py_red}dumpstack{py_end}')
    dumpstack()
    # print("full dumpstack : ",str(inspect.stack())+" : end\n")
    ut_dumperr()

if __name__ == "__main__":
    ut_dump_xxxx()

# print(f'\033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')