dialog --title "歡迎使用" --msgbox "這是一個簡易計算機" 10 50
while true; do
    operation=$(dialog --title "選擇要進行的運算" --menu "可上下進行選擇" 12 80 4 \
        1 "+" \
        2 "-" \
        3 "x" \
        4 "/" \
        3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        dialog --title "操作取消" --msgbox "您已取消操作" 10 50
        exit 0
    fi
    firstnum=$(dialog --title "進行運算的第一個數字" --inputbox "請輸入第一個數字：" 10 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        dialog --title "操作取消" --msgbox "您已取消操作" 10 50
        exit 0
    fi
    secondnum=$(dialog --title "進行運算的第二個數字" --inputbox "請輸入第二個數字：" 10 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ]; then
        dialog --title "操作取消" --msgbox "您已取消操作" 10 50
        exit 0
    fi
    case $operation in
        1) 
            operation_str="$firstnum + $secondnum"
            ;;
        2) 
            operation_str="$firstnum - $secondnum"
            ;;
        3) 
            operation_str="$firstnum * $secondnum"
            ;;
        4) 
            operation_str="$firstnum / $secondnum"
            ;;
    esac
    dialog --title "確認運算式" --yesno "您輸入的運算式是：$operation_str，是否繼續？" 10 50
    if [ $? -ne 0 ]; then
        dialog --title "操作取消" --msgbox "您已取消操作" 10 50
        exit 0
    fi
    case $operation in
        1) 
            result=$(echo "$firstnum + $secondnum" | bc)
            ;;
        2) 
            result=$(echo "$firstnum - $secondnum" | bc)
            ;;
        3) 
            result=$(echo "$firstnum * $secondnum" | bc)
            ;;
        4) 
            if [ "$secondnum" -eq 0 ]; then
                result="無法除以零"
            else
                result=$(echo "scale=2; $firstnum / $secondnum" | bc)
            fi
            ;;
    esac
    dialog --title "計算結果" --msgbox "結果: $result" 10 50
    dialog --title "繼續運算" --yesno "是否繼續進行其他計算？" 10 50
    if [ $? -ne 0 ]; then
        rating=$(dialog --title "請給予評價" --radiolist "請選擇您對計算機的滿意度：" 15 50 4 \
            1 "非常滿意" off \
            2 "滿意" off \
            3 "一般" off \
            4 "不滿意" off \
            3>&1 1>&2 2>&3)
        case $rating in
            1) rating_text="非常滿意" ;;
            2) rating_text="滿意" ;;
            3) rating_text="一般" ;;
            4) rating_text="不滿意" ;;
        esac

        dialog --title "感謝評價" --msgbox "感謝您的評價!$rating_text\n感謝使用簡易計算機！" 10 50
        exit 0
    fi
done

