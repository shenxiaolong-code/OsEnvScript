#!/usr/bin/env python3

import os
import sys
import inspect
from print_python_color             import *    # import  {py_xxx}, e.g. {py_green}, {py_end}

# from print_python_color             import *    # import  {py_xxx}, e.g. {py_green}, {py_end}
# from customized_common_function     import *    # import  addPath2Env

print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

# Print member of self
def example_func():
    print( f"\033[92m ******************* example_func ******************* \033[0m")


print( f"\r\n\033[92mDone : \033[90m{inspect.stack()[0][1]}:{inspect.stack()[0][2]} \033[0m")