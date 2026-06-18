function f
    set -l targe_excludes \
        ".config/Code - Insiders" \
        ".config/Code" \
        "Code Cache" \
        .SynologyDrive \
        .antigravity \
        .cache \
        .cargo/registry \
        .config/Antigravity \
        .config/Code \
        .config/google-chrome \
        .git \
        .local/share/klipper \
        .local/share/nvim \
        .local/share/osu \
        .local/share/pnpm \
        .local/share/zed \
        .meteor \
        .mozilla \
        .npm \
        .nv \
        .rustup/toolchains \
        .var \
        .vscode \
        .vscode-server \
        .wine \
        .yarn \
        .zig-cache \
        Cache \
        CacheStorage \
        Library \
        Trash \
        curseforge \
        go/pkg/mod \
        node_module \
        node_modules \
        sketchbook \

    set -l exclude_args
    for dir in $targe_excludes
        set exclude_args $exclude_args --exclude $dir
    end

    set -l target_dir (fd --type d --hidden -I $exclude_args | fzf | string collect)

    if test -n "$target_dir"
        cd "$target_dir"
    end
end
