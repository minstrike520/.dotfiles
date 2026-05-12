function fish_greeting
    echo (set_color yellow)"現在時間："(date +'%Y年%m月%d日（%a）%H:%M GMT%:z')
    set_color cyan

    set motto_folder "/home/blade520/random-motd/files/"
    if not test -d "$motto_folder"
        echo "Error: Directory $motto_folder not found."
        return
    end
    set random_motto (ls -p "$motto_folder" | grep -v / | awk 'BEGIN{srand();} {a[NR]=$0} END{if(NR>0) print a[int(rand()*NR)+1]}')

    if test -n "$random_motto"
        cat "$motto_folder/$random_motto" 
    else
        echo "Error: Could not find random motto."
    end
end

