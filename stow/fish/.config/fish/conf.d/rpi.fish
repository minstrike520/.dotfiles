if test -e /proc/cpuinfo && grep -q "Raspberry Pi" /proc/cpuinfo
    alias temp="vcgencmd measure_temp"
    alias fd="fdfind"
    # Fish handles PATH as a list; fish_add_path is the cleanest way to append
    fish_add_path /opt/nvim/ /opt/zellij/
end
