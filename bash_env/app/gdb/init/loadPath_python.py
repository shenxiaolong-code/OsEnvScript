
# https://stackoverflow.com/questions/9814185/how-to-access-environment-variables-inside-gdbinit-and-inside-gdb-itself
import sys
import os
import inspect
from exception_handler import pauseInvalidPathError
from script_path_config import *

print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
# all device entry function : ${CUDA_PATH}/include/cuda_runtime.h
# need the environment var ' CUDA_PATH ' is set
# use below cmd to check whether environment var is defined
# show env
# gdb.execute('directory' + os.environ['CUDA_PATH'] + '/include')
# run below cmd to check the result :
# show directories

python_paths = ''

# set environment PYTHONPATH /path/to/your/modules
# show environment PYTHONPATH
# Check if the environment variable exists
def setup_python_paths():
    global python_paths  # declare the variable as global
    if 'PYTHONPATH' in os.environ:
        python_paths = os.environ['PYTHONPATH'] + f':{DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util'
        # print(f"PYTHONPATH = {python_paths}")
        return python_paths
    else:
        raise pauseInvalidPathError("Environment variable 'PYTHONPATH' is not defined.")  # Raise error if not defined

setup_python_paths()
# print(f"PYTHONPATH = {python_paths}")
# test error
# python_paths = f'/home/utils/Python-3.9.1:{DEPENDENCY_DIR}/tools/python_cusotmized_lib_dir:{EXT_DIR}/repo/linux_pratice/linuxRepo/python_pratice/utils:{DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util_error'
# load normal
# python_paths = f'/home/utils/Python-3.9.1:{DEPENDENCY_DIR}/tools/python_cusotmized_lib_dir:{EXT_DIR}/repo/linux_pratice/linuxRepo/python_pratice/utils:{DEPENDENCY_DIR}/gdb_pretty_printer/gdb_python_api/gdb_util'

# Check if all paths are valid
def check_paths_validity(load_paths):
    for path in load_paths.split(':'):
        if not os.path.exists(path):
            raise pauseInvalidPathError(path)

# replace the sys.path with the path from environment variable
def replace_sys_path_with_env_var(load_paths):
    check_paths_validity(load_paths)  # Check for invalid paths
    sys.path = load_paths.split(':')    

# insert the path at the beginning of sys.path
def insert_path_at_beginning_of_sys_path(load_paths):    
    check_paths_validity(load_paths)  # Check for invalid paths
    for path in load_paths.split(':'):
        sys.path.insert(0, path)  # Insert each path at the beginning of sys.path

# Call the function to insert paths
insert_path_at_beginning_of_sys_path(python_paths)

def debug_imported_module_error(module_name):
    # Print current sys.path to verify
    print("Current sys.path:")
    for p in sys.path:
        print(p)

    # Attempt to import the specified module
    try:
        module = __import__(module_name)
        print(f"\n\033[92mSuccessfully imported module : \033[93m {module_name} \033[0m")
        return module  # Return the imported module for further use
    except ModuleNotFoundError as e:
        print(f"\033[91mError:\033[93m {e}\033[0m")

# Example usage
# if __name__ == "__main__":
#     debug_imported_module_error('print_python_color')

# debug_imported_module_error('print_python_color')
# debug_imported_module_error('print_python_color_error')
# print(sys.path)

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

