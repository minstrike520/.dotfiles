function ezacat --description "eza grouped by media and file type; headers match eza's default theme (src/theme/default_theme.rs)"
    # Categories map 1:1 to the FileType enum in src/info/filetype.rs:
    #   image video music lossless crypto document compressed temp compiled build source
    # Extension lists below are copied verbatim from that file's EXTENSION_TYPES
    # and FILENAME_TYPES maps.

    # Extensions per category (used only to build the -I ignore pattern for "Others").
    set -l ext_images  arw avif bmp cbr cbz cr2 dvi eps fodg gif heic heif ico j2c j2k jfi jfif jif jp2 jpe jpeg jpf jpg jpx jxl kra krz nef odg orf pbm pgm png pnm ppm ps psd pxm qoi raw svg tif tiff webp xcf xpm
    set -l ext_videos  avi flv h264 heics m2ts m2v m4v mkv mov mp4 mpeg mpg ogm ogv video vob webm wmv
    set -l ext_music   aac m4a mka mp2 mp3 ogg opus wma
    set -l ext_lossless aif aifc aiff alac ape flac pcm wav wv
    set -l ext_crypto  age asc cer crt csr gpg kbx md5 p12 pem pfx pgp pub sha1 sha224 sha256 sha384 sha512 sig signature
    set -l ext_docs    djvu doc docx eml fodp fods fodt fotd gdoc key keynote numbers odp ods odt pages pdf ppt pptx rtf xls xlsm xlsx
    set -l ext_compressed 7z ar arj br bz bz2 bz3 cpio deb dmg gz iso lz lz4 lzh lzma lzo phar qcow qcow2 rar rpm tar taz tbz tbz2 tc tgz tlz txz tz vdi vhd vhdx vmdk xz z zip zst
    set -l ext_temp    bak bk bkp crdownload download fcbak fcstd1 fdmdownload part swn swo swp tmp
    set -l ext_compiled a bundle class cma cmi cmo cmx dll dylib elc elf ko lib o obj pyc pyd pyo so zwc
    set -l ext_build   ninja
    set -l ext_source  applescript as asa awk c c++ c++m cabal cc ccm clj cp cpp cppm cr cs css csx cu cxx cxxm cypher d dart di dpr el elm erl ex exs f f90 fcmacro fcscript fnl for fs fsh fsi fsx gd go gradle groovy gvy h h++ hc hh hpp hs htc hxx inc inl ino ipynb ixx java jl js jsx kt kts kusto less lhs lisp ltx lua m malloy matlab ml mli mn nb p pas php pl pm pod pp prql ps1 psd1 psm1 purs py r rb rq rs sass scad scala scm scss sld sql ss swift tcl tex ts v vb vsh zig

    # Build files are matched by exact filename (FILENAME_TYPES), plus any
    # "readme*" name (get_file_type checks this case-insensitively first).
    set -l build_filenames Brewfile bsconfig.json BUILD BUILD.bazel build.gradle build.sbt build.xml Cargo.toml CMakeLists.txt composer.json configure Containerfile Dockerfile Earthfile flake.nix Gemfile GNUmakefile Gruntfile.coffee Gruntfile.js jsconfig.json Justfile justfile Makefile makefile meson.build mix.exs package.json Pipfile PKGBUILD Podfile pom.xml Procfile pyproject.toml Rakefile RoboFile.php SConstruct tsconfig.json Vagrantfile webpack.config.cjs webpack.config.js WORKSPACE

    # --- Collect the actual files (literal globs: fish expands globs only on
    # unescaped tokens, not on variables or command substitution output).
    # `path filter -f` keeps existing regular files and drops directories,
    # leftover unmatched globs, and nonexistent build-file names.
    set -l images (path filter -f *.arw *.avif *.bmp *.cbr *.cbz *.cr2 *.dvi *.eps *.fodg *.gif *.heic *.heif *.ico *.j2c *.j2k *.jfi *.jfif *.jif *.jp2 *.jpe *.jpeg *.jpf *.jpg *.jpx *.jxl *.kra *.krz *.nef *.odg *.orf *.pbm *.pgm *.png *.pnm *.ppm *.ps *.psd *.pxm *.qoi *.raw *.svg *.tif *.tiff *.webp *.xcf *.xpm)
    set -l videos (path filter -f *.avi *.flv *.h264 *.heics *.m2ts *.m2v *.m4v *.mkv *.mov *.mp4 *.mpeg *.mpg *.ogm *.ogv *.video *.vob *.webm *.wmv)
    set -l music  (path filter -f *.aac *.m4a *.mka *.mp2 *.mp3 *.ogg *.opus *.wma)
    set -l lossless (path filter -f *.aif *.aifc *.aiff *.alac *.ape *.flac *.pcm *.wav *.wv)
    set -l crypto  (path filter -f *.age *.asc *.cer *.crt *.csr *.gpg *.kbx *.md5 *.p12 *.pem *.pfx *.pgp *.pub *.sha1 *.sha224 *.sha256 *.sha384 *.sha512 *.sig *.signature id_dsa id_ecdsa id_ecdsa_sk id_ed25519 id_ed25519_sk id_rsa)
    set -l docs    (path filter -f *.djvu *.doc *.docx *.eml *.fodp *.fods *.fodt *.fotd *.gdoc *.key *.keynote *.numbers *.odp *.ods *.odt *.pages *.pdf *.ppt *.pptx *.rtf *.xls *.xlsm *.xlsx)
    set -l compressed (path filter -f *.7z *.ar *.arj *.br *.bz *.bz2 *.bz3 *.cpio *.deb *.dmg *.gz *.iso *.lz *.lz4 *.lzh *.lzma *.lzo *.phar *.qcow *.qcow2 *.rar *.rpm *.tar *.taz *.tbz *.tbz2 *.tc *.tgz *.tlz *.txz *.tz *.vdi *.vhd *.vhdx *.vmdk *.xz *.z *.zip *.zst)
    set -l temp    (path filter -f *~ \#*\# *.bak *.bk *.bkp *.crdownload *.download *.fcbak *.fcstd1 *.fdmdownload *.part *.swn *.swo *.swp *.tmp)
    set -l compiled (path filter -f *.a *.bundle *.class *.cma *.cmi *.cmo *.cmx *.dll *.dylib *.elc *.elf *.ko *.lib *.o *.obj *.pyc *.pyd *.pyo *.so *.zwc)
    # Case-insensitive dedupe: on macOS APFS, e.g. both Makefile and makefile
    # resolve to the same inode, so path filter would hand eza duplicate names.
    # (Keeps the first spelling; on case-sensitive filesystems they are distinct.)
    set -l build   (path filter -f $build_filenames *.ninja readme* README* Readme* | awk '!seen[tolower($0)]++')
    set -l sources (path filter -f *.applescript *.as *.asa *.awk *.c *.c++ *.c++m *.cabal *.cc *.ccm *.clj *.cp *.cpp *.cppm *.cr *.cs *.css *.csx *.cu *.cxx *.cxxm *.cypher *.d *.dart *.di *.dpr *.el *.elm *.erl *.ex *.exs *.f *.f90 *.fcmacro *.fcscript *.fnl *.for *.fs *.fsh *.fsi *.fsx *.gd *.go *.gradle *.groovy *.gvy *.h *.h++ *.hc *.hh *.hpp *.hs *.htc *.hxx *.inc *.inl *.ino *.ipynb *.ixx *.java *.jl *.js *.jsx *.kt *.kts *.kusto *.less *.lhs *.lisp *.ltx *.lua *.m *.malloy *.matlab *.ml *.mli *.mn *.nb *.p *.pas *.php *.pl *.pm *.pod *.pp *.prql *.ps1 *.psd1 *.psm1 *.purs *.py *.r *.rb *.rq *.rs *.sass *.scad *.scala *.scm *.scss *.sld *.sql *.ss *.swift *.tcl *.tex *.ts *.v *.vb *.vsh *.zig)

    # --- Globs for the "Others" listing (eza -I splits patterns on '|'). ---
    # Everything classified above, plus temp suffixes and build filenames.
    set -l ignore_globs (for e in $ext_images $ext_videos $ext_music $ext_lossless $ext_crypto $ext_docs $ext_compressed $ext_temp $ext_compiled $ext_build $ext_source; echo "*.$e"; end)
    set -l ignore_pattern (string join '|' $ignore_globs '*~' '#*#' $build_filenames 'readme*' 'README*' 'Readme*')

    # 1. Directories — filekinds.directory = Blue.bold (bold blue)
    set_color --bold blue; echo "=== Directories ==="; set_color normal
    eza -lD --icons=auto

    # 2. Images — FileType::image = Purple.normal (magenta)
    if test (count $images) -gt 0
        echo
        set_color magenta; echo "=== Images ==="; set_color normal
        eza -lf --icons=auto --sort=ext $images
    end

    # 3. Videos — FileType::video = Purple.bold (bold magenta)
    if test (count $videos) -gt 0
        echo
        set_color --bold magenta; echo "=== Videos ==="; set_color normal
        eza -lf --icons=auto --sort=ext $videos
    end

    # 4. Music — FileType::music = Cyan.normal (cyan)
    if test (count $music) -gt 0
        echo
        set_color cyan; echo "=== Music ==="; set_color normal
        eza -lf --icons=auto --sort=ext $music
    end

    # 5. Lossless — FileType::lossless = Cyan.bold (bold cyan)
    if test (count $lossless) -gt 0
        echo
        set_color --bold cyan; echo "=== Lossless ==="; set_color normal
        eza -lf --icons=auto --sort=ext $lossless
    end

    # 6. Crypto — FileType::crypto = Green.bold (bold green)
    if test (count $crypto) -gt 0
        echo
        set_color --bold green; echo "=== Crypto ==="; set_color normal
        eza -lf --icons=auto --sort=ext $crypto
    end

    # 7. Documents — FileType::document = Green.normal (green)
    if test (count $docs) -gt 0
        echo
        set_color green; echo "=== Documents ==="; set_color normal
        eza -lf --icons=auto --sort=ext $docs
    end

    # 8. Compressed — FileType::compressed = Red.normal (red)
    if test (count $compressed) -gt 0
        echo
        set_color red; echo "=== Compressed ==="; set_color normal
        eza -lf --icons=auto --sort=ext $compressed
    end

    # 9. Temp — FileType::temp = Style::default().dimmed (dim)
    if test (count $temp) -gt 0
        echo
        set_color --dim; echo "=== Temp ==="; set_color normal
        eza -lf --icons=auto --sort=ext $temp
    end

    # 10. Compiled — FileType::compiled = Yellow.normal (yellow).
    #     (eza also flags no-extension files next to their sources as
    #     Compiled; that heuristic is not replicated here.)
    if test (count $compiled) -gt 0
        echo
        set_color yellow; echo "=== Compiled ==="; set_color normal
        eza -lf --icons=auto --sort=ext $compiled
    end

    # 11. Build — FileType::build = Yellow.bold().underline (bold underlined yellow)
    if test (count $build) -gt 0
        echo
        set_color --bold --underline yellow; echo "=== Build ==="; set_color normal
        eza -lf --icons=auto --sort=ext $build
    end

    # 12. Source — FileType::source = Yellow.bold (bold yellow)
    if test (count $sources) -gt 0
        echo
        set_color --bold yellow; echo "=== Source ==="; set_color normal
        eza -lf --icons=auto --sort=ext $sources
    end

    # 13. Everything else — unclassified files (eza renders them with the
    #     default/normal filekinds color)
    echo
    set_color normal; echo "=== Others ==="; set_color normal
    eza -lf --icons=auto --sort=ext -I $ignore_pattern
end
