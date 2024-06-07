# 针对个人邮箱的谷歌搜集语法，@符号的变种没有加入；
#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 'LastName,FirstName'"
    exit 1
fi

input_name="$1"
last_name=$(echo "$input_name" | awk -F',' '{print $1}')
first_name=$(echo "$input_name" | awk -F',' '{print $2}')

first_name_lower=$(echo "$first_name" | tr '[:upper:]' '[:lower:]')
last_name_lower=$(echo "$last_name" | tr '[:upper:]' '[:lower:]')
first_initial=$(echo "$first_name_lower" | cut -c 1)

google_dork="intext:\"${last_name_lower}${first_name_lower}@\" | \"${last_name_lower}@\" | \"${first_name_lower}@\" | \"${last_name_lower}.${first_name_lower}@\" | \"${first_name_lower} ${last_name_lower}@\" | \"${first_name_lower}.${last_name_lower}@\" | \"${first_name_lower}-${last_name_lower}@\" | \"${last_name_lower}-${first_name_lower}@\" | \"${first_initial}.${last_name_lower}.????@\" | \"${first_initial}.${last_name_lower}@\" | \"${first_initial}.${last_name_lower}.*@\" | \"${first_initial}-${last_name_lower}.????@\" | \"${last_name_lower}.${first_initial}.????@\" | \"${last_name_lower}.${first_initial}@\" | \"${last_name_lower}.${first_initial}.*@\" | \"${first_initial}-${last_name_lower}.*@\" | \"${last_name_lower}-${first_initial}.*@\" | \"${last_name_lower}-${first_initial}.????@\""
echo "$google_dork"
