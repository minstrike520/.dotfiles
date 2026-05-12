function fish_greeting
    echo (set_color yellow)"現在時間："(date +'%Y年%m月%d日（%a）%H:%M GMT%:z')
    echo (set_color cyan)"祝你有美好的一天！"

    set motto_folder "$HOME/random-motd/files/"
    set pics_folder "$HOME/pics/random-favicon/"
    if not test -d "$motto_folder"
        echo "Error: Directory $motto_folder not found."
        return
    end
    if not test -d "$pics_folder"
        echo "Error: Directory $pics_folder not found."
        return
    end
    set random_motto (ls -p "$motto_folder" | grep -v / | awk 'BEGIN{srand();} {a[NR]=$0} END{if(NR>0) print a[int(rand()*NR)+1]}')
    set random_pic (ls -p "$pics_folder" | grep -v / | awk 'BEGIN{srand();} {a[NR]=$0} END{if(NR>0) print a[int(rand()*NR)+1]}')

    if test -n "$random_motto"; and test -n "$random_pic"
        paste -d "    " \
            (chafa -s 25x20 --format symbols "$pics_folder/$random_pic" | psub) \
            (cat "$motto_folder/$random_motto" | psub)
    else
        echo "Error: Could not find random motto or picture."
    end

end

