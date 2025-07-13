
# info pretty-printer
import sys 
import inspect
from exception_handler import pauseInvalidPathError, pauseGeneralError

# should copy from /usr/share/gcc/python
print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
# how to know current used printers.py path
# see ${BASH_DIR}/app/gdb/feature/pretty_printer/debug_pretty_printer.py
# next 
# > /usr/share/gcc/python/libstdcxx/v6/printers.py(1530)__call__()
# e.g. ${DEPENDENCY_DIR}/gdb_pretty_printer/python/libstdcxx/v6/printers.py

# need libstdcxx exist
# /home/utils/gdb-12.1-2  has not include libstdcxx
# sys.path.insert(0, '/home/utils/gdb-12.1-2/share/gdb/python')

try:
    sys.path.insert(0, '/home/utils/gcc-11.2.0/share/gcc-11.2.0/python')
except Exception as e:
    raise pauseInvalidPathError("Fails to set gdb python path.")

# make a copy because the original path is not editable. we need to update/log it
# sys.path.insert(0, f'{DEPENDENCY_DIR}/gdb_pretty_printer/python_from_gcc_1120')

if 0:
    # after 9.0 , register_libstdcxx_printers is loaded automatically.  previous gdb version need to be load manual.
    from libstdcxx.v6.printers import register_libstdcxx_printers
    register_libstdcxx_printers (None)


print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

# Note
# get the pretty printer for stl
# Ensure that the GDB version is 7.0 or later. This means it has support for Python scripting

# need to find the correct libstdcxx path , check /usr/share path for version of libstdstdc++ -
# dpkg -L libstdc++6 | grep python
# e.g. :
# /usr/share/gcc/python/libstdcxx
# /usr/share/gcc-5/python/libstdcxx
# see implement :  /usr/share/gcc/python/libstdcxx/v6/printers.py

# issue : RuntimeError: pretty-printer already registered: libstdc++-v6
# https://stackoverflow.com/questions/18289377/gdb-runtimeerror-pretty-printer-already-registered-libstdc-v6
# solution : comment out the line : register_libstdcxx_printers (None)

# get the newest stl pretty printer
# https://sourceware.org/gdb/wiki/STLSupport
# # https://codeyarns.com/tech/2014-07-17-how-to-enable-pretty-printing-for-stl-in-gdb.html#gsc.tab=0
# svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python stlprettyprinter



