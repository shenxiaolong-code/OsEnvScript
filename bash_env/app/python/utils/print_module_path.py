
import sys
import inspect
print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
print(f'\033[90m90 \033[91m91 \033[92m92 \033[93m93 \033[94m94 \033[95m95 \033[96m96 \033[97m97 \033[0m')
# print(f'\033[91mLog\033[0m \033[90m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')
# valStr="\033[91m{}\033[0m  {} ".format(self.val['start_'],f'\033[90m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

def showModulePath(module):
    if (hasattr(module, '__name__') is False):
        print ('Error: ' + str(module) + ' is not a module object.')
        return None
    moduleName = module.__name__
    modulePath = None
    if importlib.is_builtin(moduleName):
        modulePath = sys.modules[moduleName];
    else:
        modulePath = inspect.getsourcefile(module)
        modulePath = '<module \'' + moduleName + '\' from \'' + modulePath + 'c\'>'
    print (modulePath)
    return modulePath

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')