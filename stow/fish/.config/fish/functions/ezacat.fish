function ezacat --description "eza grouped by media and file types"
    set -l images (path filter -f *.png *.jpg *.jpeg *.gif *.webp)
    set -l videos (path filter -f *.mp4 *.mkv *.avi *.mov)
    set -l docs   (path filter -f *.pdf *.txt *.md *.docx)

    # 1. 目錄
    set_color --bold blue; echo "=== Directories ==="; set_color normal
    eza -lD --icons always

    # 2. 圖片類
    if test (count $images) -gt 0
        echo
        set_color --bold magenta; echo "=== Images ==="; set_color normal
        eza -lf --icons always $images
    end

    # 3. 影片類
    if test (count $videos) -gt 0
        echo
        set_color --bold cyan; echo "=== Videos ==="; set_color normal
        eza -lf --icons always $videos
    end

    # 4. 文件類
    if test (count $docs) -gt 0
        echo
        set_color --bold green; echo "=== Documents ==="; set_color normal
        eza -lf --icons always $docs
    end

    # 5. 其餘檔案（排除上述已列出的副檔名）
    echo
    set_color --bold white; echo "=== Others ==="; set_color normal
    eza -lf --icons always -I "*.png|*.jpg|*.jpeg|*.gif|*.webp|*.mp4|*.mkv|*.avi|*.mov|*.pdf|*.txt|*.md|*.docx"
end
