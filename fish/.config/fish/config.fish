set CUSTOM_PATHS ~/bin /usr/local/py-utils/bin

# Customize $PATH but allow backwards compatibility
# for fish in older Debian versions.
if type -q fish_add_path
   fish_add_path $CUSTOM_PATHS
else
   set -Up fish_user_paths $CUSTOM_PATHS
end

# Commands to run in interactive sessions can go here
if status is-interactive
    # Disable greeting on startup
    set -U fish_greeting

    # Set important variables
    set -gx EDITOR nvim

    # Enable colors for ls in kitty
    dircolors -c | source

    starship init fish | source

    function switch_terraform --on-event fish_postexec
        string match --regex '^cd\s' "$argv" > /dev/null
        set --local is_command_cd $status

        if test $is_command_cd -eq 0 
            if count *.tf > /dev/null
                grep -c "required_version" *.tf > /dev/null
                set --local tf_contains_version $status
                
                if test $tf_contains_version -eq 0      
                    command tfswitch
                end
            end
        end
    end
end
