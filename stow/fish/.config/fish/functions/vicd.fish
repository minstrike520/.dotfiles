function vicd
    set -l args $argv
    if test -z "$args"
        set args "."
    end

    set -l dst (command vifm --choose-dir - $args)

    if test -z "$dst"
        echo 'Directory picking cancelled/failed'
        return 1
    end

    if cd "$dst"
        # cd was successful
    else
        # Fish automatically handles error reporting for 'cd', 
        # but here is your custom error logic:
        echo "Error changing directory --"
        echo $dst
    end
end
