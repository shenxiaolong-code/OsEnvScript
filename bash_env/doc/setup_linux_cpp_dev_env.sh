
#!/bin/bash
# This script is used to set up a Linux C++ development environment.
sudo apt update
sudo apt upgrade -y

sudo apt install build-essential -y         # Install essential packages for building software (includes g++, make, etc.)
sudo apt install g++ -y                     # Install the GNU C++ compiler
sudo apt install gdb -y                     # Install the GNU Debugger
sudo apt install make -y                    # Install the Make build automation tool (optional)
sudo apt install cmake -y                   # Install CMake, a cross-platform build system (generator)
sudo apt install python3 -y
sudo apt install python3-pip -y             # install python2 pip componment

# sudo apt install clang -y                 # Install the Clang C++ compiler (optional)
# sudo apt install gcc -y                   # Install the GNU C compiler (optional, usually g++ is sufficient)
# sudo apt install git -y                   # Install Git version control system (optional)
# sudo apt install libtool -y               # Install GNU Libtool, a generic library support script (optional)
# sudo apt install autoconf -y              # Install Autoconf, a tool for generating configuration scripts (optional)
# sudo apt install automake -y              # Install Automake, a tool for automatically generating Makefile.in files (optional)
# sudo apt install pkg-config -y            # Install pkg-config, a helper tool for compiling applications and libraries (optional)
# sudo apt install libboost-dev -y          # Install Boost libraries, a collection of portable C++ source libraries (optional)
# sudo apt install valgrind -y              # Install Valgrind, a tool for memory debugging, memory leak detection, and profiling (optional)
# sudo apt install libstdc++-12-dev -y      # Install the GNU Standard C++ Library development files (optional)
# sudo apt install libboost-all-dev -y      # Install all Boost libraries (optional)
# sudo apt install libssl-dev -y            # Install OpenSSL development files (optional)
# sudo apt install libcurl4-openssl-dev -y  # Install cURL development files (optional)
# sudo apt install libreadline-dev -y       # Install Readline development files (optional)
# sudo apt install libncurses5-dev -y       # Install ncurses development files (optional)
# sudo apt install libncursesw5-dev -y      # Install wide-character ncurses development files (optional)
# sudo apt install libxml2-dev -y           # Install libxml2 development files (optional)
# sudo apt install libsqlite3-dev -y        # Install SQLite3 development files (optional)
# sudo apt install libz-dev -y              # Install zlib development files (optional)
# sudo apt install libbz2-dev -y            # Install bzip2 development files (optional)
# sudo apt install liblzma-dev -            # Install LZMA development files (optional)  



