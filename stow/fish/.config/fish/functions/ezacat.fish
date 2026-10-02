function ezacat --description "eza grouped by media and file type; section headers match eza's default theme (src/theme/default_theme.rs)"
    # Extension groups, aligned with the FileType categories in src/info/filetype.rs.
    set -l ext_images  png jpg jpeg gif webp
    set -l ext_videos  mp4 mkv avi mov
    set -l ext_music   mp3 flac m4a ogg wav wma aac
    set -l ext_archives zip tar gz 7z rar bz2 xz
    set -l ext_docs    pdf docx doc epub odt
    set -l ext_source  py rb js ts c cpp h hpp java go rs sh

    # Build "*.ext" globs per group, then collect matching regular files in
    # the current directory. Literal globs that match nothing are dropped by
    # `path filter` because the path doesn't exist.
    set -l image_globs  (for e in $ext_images;  echo "*.$e"; end)
    set -l video_globs  (for e in $ext_videos;  echo "*.$e"; end)
    set -l music_globs  (for e in $ext_music;   echo "*.$e"; end)
    set -l archive_globs (for e in $ext_archives; echo "*.$e"; end)
    set -l docs_globs   (for e in $ext_docs;    echo "*.$e"; end)
    set -l source_globs (for e in $ext_source;  echo "*.$e"; end)

    set -l images    (path filter -f $image_globs)
    set -l videos    (path filter -f $video_globs)
    set -l music     (path filter -f $music_globs)
    set -l archives  (path filter -f $archive_globs)
    set -l docs      (path filter -f $docs_globs)
    set -l sources   (path filter -f $source_globs)

    # Everything listed above, joined for eza's -I ignore patterns (split on '|').
    set -l ignore_pattern (string join '|' $image_globs $video_globs $music_globs $archive_globs $docs_globs $source_globs)

    # 1. Directories — filekinds.directory = Blue.bold (bold blue)
    set_color --bold blue; echo "=== Directories ==="; set_color normal
    eza -lD --icons

    # 2. Images — FileType::image = Purple.normal (magenta)
    if test (count $images) -gt 0
        echo
        set_color magenta; echo "=== Images ==="; set_color normal
        eza -lf --icons $images
    end

    # 3. Videos — FileType::video = Purple.bold (bold magenta)
    if test (count $videos) -gt 0
        echo
        set_color --bold magenta; echo "=== Videos ==="; set_color normal
        eza -lf --icons $videos
    end

    # 4. Music — FileType::music = Cyan.normal (cyan)
    if test (count $music) -gt 0
        echo
        set_color cyan; echo "=== Music ==="; set_color normal
        eza -lf --icons $music
    end

    # 5. Archives — FileType::compressed = Red.normal (red)
    if test (count $archives) -gt 0
        echo
        set_color red; echo "=== Archives ==="; set_color normal
        eza -lf --icons $archives
    end

    # 6. Documents — FileType::document = Green.normal (green)
    if test (count $docs) -gt 0
        echo
        set_color green; echo "=== Documents ==="; set_color normal
        eza -lf --icons $docs
    end

    # 7. Source code — FileType::source = Yellow.bold (bold yellow)
    if test (count $sources) -gt 0
        echo
        set_color --bold yellow; echo "=== Source ==="; set_color normal
        eza -lf --icons $sources
    end

    # 8. Everything else — eza colors these with the default (normal) style
    echo
    echo "=== Others ==="
    eza -lf --icons -I $ignore_pattern
end
