@echo off
:: sshcmd "cat /home/scratch.xiaolongs_gpu_1/build/_lastBuildDir.ini"
:: sshcmd "ls ~"
echo ssh %USERNAME%@computelab-303.nvidia.com  %*
ssh %USERNAME%@computelab-303.nvidia.com  %*