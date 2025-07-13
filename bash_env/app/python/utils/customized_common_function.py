
import  os
import sys
from print_python_color             import *    # import  {py_xxx}, e.g. {py_green}, {py_end}

# Global variable for verbose mode
bVerboseMode = False

def setVerboseMode(mode):
    global bVerboseMode
    bVerboseMode = mode
    if bVerboseMode: print(f"Verbose mode set to: {bVerboseMode}")

def addPath2Env(path):
    # Convert relative path to absolute path
    absolute_path = os.path.abspath(path)

    # Check if the path exists
    if not os.path.exists(absolute_path):
        print(f"{py_red}Path does not exist:{py_brown} {absolute_path} {py_end}")
        return

    # Get the current PATH
    current_path = os.environ.get('PATH')

    # Add the new path to the system PATH if it's not already in it
    if absolute_path not in current_path:
        os.environ['PATH'] = absolute_path + ':' + current_path
        if bVerboseMode: print(f"{py_green}Added to PATH:{py_brown} {absolute_path} {py_end}")
    else:
        if bVerboseMode: print(f"{py_blue}Path already exists in PATH:{py_brown} {absolute_path} {py_end}")

    # Add the path to sys.path if it's not already there
    if absolute_path not in sys.path:
        sys.path.append(absolute_path)
        if bVerboseMode: print(f"{py_green}Added to sys.path:{py_brown} {absolute_path} {py_end}")
    else:
        if bVerboseMode: print(f"{py_blue}Path already exists in sys.path:{py_brown} {absolute_path} {py_end}")

