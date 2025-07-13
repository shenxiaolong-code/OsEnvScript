
import sys
import inspect
from print_python_color             import *

print(f'+++++++++ loading \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')

def list_python_obj_member_name_and_protype(obj):
    print(f'{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')
    # Get the list of members of the object
    members = dir(obj)

    # Initialize an empty list to store the member names and prototypes
    member_info = []

    # Iterate over each member
    for member in members:
        # Get the attribute from the object
        attr = getattr(obj, member)

        # Check if the attribute is callable (i.e., a method)
        if callable(attr):
            # If it's a method, get its prototype (i.e., the signature of the function)
            try:
                prototype = str(inspect.signature(attr))
            except ValueError:
                prototype = "(...)"
            member_info.append((member, prototype))
        else:
            # If it's not a method, just get its type
            member_info.append((member, type(attr).__name__))

    # Return the list of member names and prototypes
    return member_info

def print_python_obj_member_name_and_protype(obj):
    print(f'{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')
    # Get the member names and prototypes using the first function
    members = list_python_obj_member_name_and_protype(obj)

    # Print each member name and prototype
    for name, protype in members:
        print(f"Name: {name}, Prototype/Type: {protype}")


def print_python_obj_data_member_name_and_value_and_type(obj):
    print(f'{py_green}{inspect.stack()[0][1]}:{inspect.stack()[0][2]}{py_end}')
    # Get the list of members of the object
    members = dir(obj)

    # Iterate over each member
    for member in members:
        # Get the attribute from the object
        attr = getattr(obj, member)

        # Check if the attribute is not callable (i.e., it's a data member)
        if not callable(attr):
            # Print the member name, value and type
            # print(f"Name: {member}, Value: {attr}, Type: {type(attr).__name__}")
            print(f"Name: {member}, Value: {attr}")

print(f'--------- leaving \033[92m{inspect.stack()[0][1]}:{inspect.stack()[0][2]}\033[0m')