echo \r\n\033[36m+++++++++ loading \033[35m/home/xlshen/scratch/bash_env/app/gdb/cuda_gdb/gdb_init_nvidia.gdb \033[37m...\r\n
# run single breakpoint in gdb test cmd

# nvidia project related common breakpoint
# all device entry function : ${CUDA_PATH}/include/cuda_runtime.h
# source /home/xlshen/scratch/myTasks/curTask/cfk_10179_Port_SM90_strided_dgrad_kernels/breakpoint.gdb

# /home/xlshen/scratch/repo/cask6_2/include/cask/cask.hpp:183
# b *ErrorCuda

# source /home/xlshen/scratch/bash_env/app/gdb/cmds/load_possible_not_existing_script.py  ./cmds/gdb_breakpoints.ini

source /home/xlshen/scratch/bash_env/app/gdb/feature/bp/load_app_spec_breakpoint.py

# source /home/xlshen/scratch/third_part_dependency/gdb_nvidia/breakpoint/bp_except_launch.gdb

break Options::parse
  commands
    set m_allow_unrecognised=1
    continue
  end

# **************************************************************  host code breakpoint, gdb is ok **********************************************************
if 0
    # /home/xlshen/scratch/repo/cask6_2/include/cask/trace.hpp
    # /home/xlshen/scratch/repo/cask6_2/include/cask/cask.hpp
    # use * to avoid @plt breakpoint
    b *ErrorConstraint
    b *ErrorCuda
    b *ErrorAlignment
    b *ErrorInvalidArgument
    b *ErrorTypeMismatch
    b *ErrorNotImplemented
    b *ErrorCompilation
end

if 0
    # cask6
    # /home/xlshen/scratch/repo/cask6_2/frameworks/cutlass3x/lib/adapters/common/cask_cuda_host_adapter.cu:116
    # b cask6::cutlass3x::CaskCudaHostAdapter::launch
    b cask6::ModuleCudaDriverApi::launch
end

if 0
    # cutlass
    # /home/xlshen/scratch/dbg_investigate/repo/cutlass/include/cutlass/device_kernel.h:64
    b  cutlass::Kernel
end

if 0
    # device memory allocate
    b cudaMalloc
    b cudaFree
    b cudaMallocAsync
end

# ********************************************************* override bps cmd to project related script ****************************************************************
define bps
    # $argc can only be used in gdb function, it can't be used in gdb init procedure
    if $argc == 0
        load_breakpoint_hints
    else
        source /home/xlshen/scratch/bash_env/app/gdb/cuda_gdb/gdb_init_nvidia.gdb
        load_app_breakpoint
        # load_breakpoint_hints
    end
end
document bps
	reload gdb breakpoints : /home/xlshen/scratch/bash_env/app/gdb/cuda_gdb/gdb_init_nvidia.gdb
end

echo \033[36m\r\n--------- leaving \033[35m/home/xlshen/scratch/bash_env/app/gdb/cuda_gdb/gdb_init_nvidia.gdb:15  \033[37m ...\r\n
