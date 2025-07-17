
#!/bin/bash

# 定义目标文件路径
TARGET_FILE="${TEMP_DIR}/to_del/exist_or_non_exist_file.txt"

# 向文件追加多行内容
cat << EOF >> "$TARGET_FILE"
line1
line2
line3
EOF

(
    echo
    echo "line4"
    echo "line5"
    echo "line6"

) >> "$TARGET_FILE"


dumpinfo "write multiple lines into file : ${TARGET_FILE}"