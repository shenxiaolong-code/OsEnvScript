#!/usr/bin/env python3

import os
import sys
import inspect
from print_current_callstack import print_stack_all
# from exception_handler import pauseInvalidPathError,pauseGeneralError

print( f"\033[92m+++++++++ loading \033[90m{inspect.stack()[0][1]}:{inspect.stack()[0][2]} ...\033[0m")

# Custom exception for invalid paths
# class pauseInvalidPathError(Exception):
#     pass

# Custom exception for invalid paths
class pauseInvalidPathError(Exception):
    def __init__(self, path):
        # super().__init__(f"{py_red}Invalid path:{py_brown} {path} {py_end}")
        super().__init__(f"\033[91mInvalid path :\033[93m {path} \033[0m")
        self.path = path
        self.handle_error()  # call the method to handle the error

    def handle_error(self):
        print(f"\033[91mError: {self}")
        # print(f'\033[94m       PYTHONPATH   :\033[92m {os.environ['PYTHONPATH']}\033[0m')
        print(f'\033[94m       PYTHONPATH   :\033[92m {os.environ["PYTHONPATH"]}\033[0m')
        # pdb.post_mortem()  # pause the program and enter pdb debugger
        print(f'\033[94m       Position     :\033[92m {inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
        print_stack_all()
        input("\n\033[95mpause to check error\n\n\033[0m")  # pause the program and wait for user input

class pauseGeneralError(Exception):
    def __init__(self, path):
        # super().__init__(f"{py_red}Invalid path:{py_brown} {path} {py_end}")
        super().__init__(f"\033[91mGeneral error :\033[93m {path} \033[0m")
        self.path = path
        self.handle_error()  # call the method to handle the error

    def handle_error(self):
        print(f"\033[91mError: {self}")
        # print(f'\033[94m       PYTHONPATH   :\033[92m {os.environ['PYTHONPATH']}\033[0m')
        print(f'\033[94m       PYTHONPATH   :\033[92m {os.environ["PYTHONPATH"]}\033[0m')
        # pdb.post_mortem()  # pause the program and enter pdb debugger
        print(f'\033[94m       Position     :\033[92m {inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
        print_stack_all()
        input("\n\033[95mpause to check error\n\n\033[0m")  # pause the program and wait for user input

def tc_usage_pauseInvalidPathError():
    if 'PYTHONPATH' in os.environ:
        python_paths = os.environ['PYTHONPATH'] + ':/home/possible_not_existing_dir'
        # print(f"PYTHONPATH = {python_paths}")
        return python_paths
    else:
        raise pauseInvalidPathError("Environment variable 'PYTHONPATH' is not defined.")

def tc_usage_pauseGeneralError():
    try:
        open(f'/home/not_existing_dir/not_existing_file.txt')
    except Exception as e:
        raise pauseGeneralError(f"Fails to open file.")


# tc_usage_pauseInvalidPathError()
# tc_usage_pauseGeneralError()

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
