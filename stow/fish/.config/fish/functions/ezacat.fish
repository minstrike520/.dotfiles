function ezacat --description "eza grouped by media and file type; section headers match eza's default theme (src/theme/default_theme.rs)"
    # Extension groups, aligned with the FileType categories in src/info/filetype.rs.
    # NOTE: fish expands globs only on literal tokens, so patterns must be written
    # out here rather than assembled from variables.
    set -l ext_images  png jpg jpeg gif webp
    set -l ext_videos  mp4 mkv avi mov
    set -l ext_music   mp3 flac m4a ogg wav wma aac
    set -l ext_archives zip tar gz 7z rar bz2 xz
    set -l ext_docs    pdf docx doc epub odt
    set -l ext_source  py rb js ts c cpp h hpp java go rs sh

    # Collect matching regular files in the current directory. Glob tokens are
    # expanded by fish; directories are dropped by -f; literal leftovers from
    # globs that matched nothing are dropped by path filter (path doesn't exist).
    set -l images    (path filter -f *.png *.jpg *.jpeg *.gif *.webp)
    set -l videos    (path filter -f *.mp4 *.mkv *.avi *.mov)
    set -l music     (path filter -f *.mp3 *.flac *.m4a *.ogg *.wav *.wma *.aac)
    set -l archives  (path filter -f *.zip *.tar *.gz *.7z *.rar *.bz2 *.xz)
    set -l docs      (path filter -f *.pdf *.docx *.doc *.epub *.odt)
    set -l sources   (path filter -f *.py *.rb *.js *.ts *.c *.cpp *.h *.hpp *.java *.go *.rs *.sh)

    # Ignore patterns (eza -I splits on '|') for the "Others" listing.
    set -l ignore_globs (for e in $ext_images $ext_videos $ext_music $ext_archives $ext_docs $ext_source; echo "*.$e"; end)
    set -l ignore_pattern (string join '|' $ignore_globs)

    # 1. Directories — filekinds.directory = Blue.bold (bold blue)
    set_color --bold blue; echo "=== Directories ==="; set_color normal
    eza -lD --icons=auto

    # 2. Images — FileType::image = Purple.normal (magenta)
    if test (count $images) -gt 0
        echo
        set_color magenta; echo "=== Images ==="; set_color normal
        eza -lf --icons=auto $images
    end

    # 3. Videos — FileType::video = Purple.bold (bold magenta)
    if test (count $videos) -gt 0
        echo
        set_color --bold magenta; echo "=== Videos ==="; set_color normal
        eza -lf --icons=auto $videos
    end

    # 4. Music — FileType::music = Cyan.normal (cyan)
    if test (count $music) -gt 0
        echo
        set_color cyan; echo "=== Music ==="; set_color normal
        eza -lf --icons=auto $music
    end

    # 5. Archives — FileType::compressed = Red.normal (red)
    if test (count $archives) -gt 0
        echo
        set_color red; echo "=== Archives ==="; set_color normal
        eza -lf --icons=auto $archives
    end

    # 6. Documents — FileType::document = Green.normal (green)
    if test (count $docs) -gt 0
        echo
        set_color green; echo "=== Documents ==="; set_color normal
        eza -lf --icons=auto $docs
    end

    # 7. Source code — FileType::source = Yellow.bold (bold yellow)
    if test (count $sources) -gt 0
        echo
        set_color --bold yellow; echo "=== Source ==="; set_color normal
        eza -lf --icons=auto $sources
    end

    # 8. Everything else — eza colors these with the default (normal) style
    echo
    echo "=== Others ==="
    eza -lf --icons=auto -I $ignore_pattern
end
