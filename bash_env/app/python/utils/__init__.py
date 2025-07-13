


import os
from setuptools import setup, find_packages
# setup(name = 'package_utils', packages = find_packages())
# easy use to use utils , instead of package_utils
setup(name = 'utils', packages = find_packages())

from .color import *
from script_path_config             import *    # import BASH_DIR, ...

# print(f'import package : {os.path.dirname(__file__)}')



