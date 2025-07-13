
# https://stackoverflow.com/questions/5676241/tell-gdb-to-skip-standard-files
# Step instructions and skip all files without source
# This will be too slow for most applications, but it is fun!

import os.path

print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

class ContinueUntilSource(gdb.Command):
    def __init__(self):
        super().__init__(
            'cus',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, argument, from_tty):
        argv = gdb.string_to_argv(argument)
        if argv:
            gdb.write('Does not take any arguments.\n')
        else:
            done = False
            thread = gdb.inferiors()[0].threads()[0]
            while True:
                message = gdb.execute('si', to_string=True)
                if not thread.is_valid():
                    break
                try:
                    path = gdb.selected_frame().find_sal().symtab.fullname()
                except:
                    pass
                else:
                    if os.path.exists(path):
                        break
ContinueUntilSource()

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')