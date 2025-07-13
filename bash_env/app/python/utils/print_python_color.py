

# https://stackoverflow.com/questions/287871/how-do-i-print-colored-text-to-the-terminal

import sys
import inspect

py_end         = '\033[0m'
py_black       = '\033[30m'
py_black_L     = '\033[90m'
py_red         = '\033[31m'
py_red_L       = '\033[91m'    
py_green       = '\033[32m'
py_green_L     = '\033[92m'
py_brown       = '\033[33m'
py_brown_L     = '\033[93m'
py_blue        = '\033[34m'
py_blue_L      = '\033[94m'
py_purple      = '\033[35m'
py_purple_L    = '\033[95m'
py_cyan        = '\033[36m'
py_cyan_L      = '\033[96m'
py_white       = '\033[37m'
py_white_L     = '\033[97m'
py_underline   = '\033[4m'
py_bold        = '\033[1m'

__all__ = ['py_end','py_black','py_black_L','py_red','py_red_L','py_green','py_green_L','py_brown','py_brown_L','py_blue','py_blue_L','py_purple','py_purple_L','py_cyan','py_cyan_L','py_white','py_white_L','py_underline','py_bold']

def dump_python_color():    
    print(f'cmd: python {" ".join(sys.argv)}\r\n{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')
    print(py_end        + "py_end       : " + repr(py_end)          + py_end)
    print(py_black      + "py_black     : " + repr(py_black)        + py_end)
    print(py_black_L    + "py_black_L   : " + repr(py_black_L)      + py_end)
    print(py_red        + "py_red       : " + repr(py_red)          + py_end)
    print(py_red_L      + "py_red_L     : " + repr(py_red_L)        + py_end)
    print(py_green      + "py_green     : " + repr(py_green)        + py_end)
    print(py_green_L    + "py_green_L   : " + repr(py_green_L)      + py_end)
    print(py_brown      + "py_brown     : " + repr(py_brown)        + py_end)
    print(py_brown_L    + "py_brown_L   : " + repr(py_brown_L)      + py_end)
    print(py_blue       + "py_blue      : " + repr(py_blue)         + py_end)
    print(py_blue_L     + "py_blue_L    : " + repr(py_blue_L)       + py_end)
    print(py_purple     + "py_purple    : " + repr(py_purple)       + py_end)
    print(py_purple_L   + "py_purple_L  : " + repr(py_purple_L)     + py_end)
    print(py_cyan       + "py_cyan      : " + repr(py_cyan)         + py_end)
    print(py_cyan_L     + "py_cyan_L    : " + repr(py_cyan_L)       + py_end)
    print(py_white      + "py_white     : " + repr(py_white)        + py_end)
    print(py_white_L    + "py_white_L   : " + repr(py_white_L)      + py_end)
    print(py_underline  + "py_underline : " + repr(py_underline)    + py_end)
    print(py_bold       + "py_bold      : " + repr(py_bold)         + py_end)
    
    print(f'{py_red}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}\r\n')
    print('\r\nhttps://stackoverflow.com/questions/287871/how-do-i-print-colored-text-to-the-terminal')
    print('\x1b[6;30;42m' + '6;30;42m' + '\x1b[0m')
    print('\x1b[6;31;46m' + '6;31;46m' + '\x1b[0m')
    print('\x1b[37;188;36m' + '37;188;36m' + '\x1b[0m')

    print(f'cmd: python {" ".join(sys.argv)}\r\n{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')

if __name__ == "__main__":
    if len(sys.argv) > 1:
        dump_python_color()


