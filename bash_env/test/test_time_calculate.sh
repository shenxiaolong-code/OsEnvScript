bash_script_i
# https://stackoverflow.com/questions/8903239/how-can-i-calculate-time-elapsed-in-a-bash-script
# echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."


echo current time : $(date +"%T")                               # 05:47:59    
echo current time : $(date +"%Y/%m/%d %T")                      # 2022/07/05 05:47:59
echo current time string : $(date +"%Y%m%d_%H%M%S")             # 20220705_055016


time_work_begin=`date "+%Y.%m.%d   %H.%M.%S"`
SECONDS=0

# do some time-consuming work
sleep 5

time_work_during=${SECONDS}
time_work_end=`date "+%Y.%m.%d   %H.%M.%S"`

time_work_during_str="$(( $time_work_during / 3600 )) h : $(( $time_work_during / 60 )) m : $(( $time_work_during / 3600 )) s"
echo "${green}during time : ${brown}${time_work_during_str} ${end}\nbegin      : ${time_work_begin}\nend        : ${time_work_end}"

# show the duration time of run a script or cmd
time source ${BASH_DIR}/bin/clean_system.sh
# real    21m1.559s
# user    216m20.767s
# sys     14m55.142s

time (
    echo "block time"
    cat ${BASH_DIR}/bin/clean_system.sh
    echo "block time end"
)

bash_script_o
