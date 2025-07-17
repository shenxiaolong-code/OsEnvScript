bash_script_i
echo

# ? auditd
# auditd is /usr/sbin/auditd

# You must be root to run this program.
# sudo auditctl -w ${BASH_DIR}/nvidia/build/buildkit/rebuild.sh -p wa -k file_change

# or use read-only to check who change my file , it needn't sudo
# chmod 444 ${BASH_DIR}/nvidia/build/buildkit/rebuild.sh

# search file change log:
# sudo ausearch -k file_change

echo
bash_script_o
