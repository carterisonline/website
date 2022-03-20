#!/usr/bin/fish

set m_program mam
set m_desc "The Molecular Application Manager"
set m_author "Carter Reeb <me@carteris.online>"
set m_version "0.2.1"
set m_year (date +"%Y")

function m_help
    echo -e "\
		$m_program v$m_version
		$m_desc
		© $m_year $m_author

		COMMANDS:
		<@ run <cmd><~<~ Runs the specified command
		<@ stop <alias><~ Stops the specified process
		<@ open <alias><~ Switches to the process' shell (^B-d to exit)
		<@ ls<~<~ Lists currently running processes' aliases

		RECIPES:
		<@ recipe create <name> <cmd> Creates a new recipe
		<@ recipe run <name><~<~ Runs the specified recipe
		<@ recipe remove <name><~ Removes the specified recipe
		<@ recipe ls<~<~<~ Displays a list of recipes
		\
		" | awk '{$1=$1};1' | sd '<@' "  mam" | sd '<~' "\t"
end

switch $argv[1]
    case stop kill
        tmux kill-session -t $argv[2]
    case goto open
        tmux attach -t $argv[2]
    case ls list up procs
        tmux ls
    case run start
        set cmd (echo $argv[2] | awk '{print $1}')
        set relativedir (echo $PWD | awk -F/ '{print $NF}')
        tmux new -s "$relativedir/$cmd" -d $argv[2]
        printf "$relativedir/$cmd"
        sleep 0.1
        if test (tmux ls | grep "$relativedir/$cmd")
            echo " is now running"
        else
            echo " exited immediately. Try running in your own shell to see what the issue is."
            exit 1
        end
    case recipe
        switch $argv[2]
            case ls list up
                cd "$HOME/.local/share/mam/recipes"
                for f in (find . -type f)
                    printf $f | sd '\./(\w+)' '$1'
                    printf " - "
                    echo (sed -n '2p' $f | awk '{print $NF}')
                end
            case run start
                cd "$HOME/.local/share/mam/recipes"
                if not test -e $argv[3]
                    echo "Recipe $argv[3] does not exist."
                    exit 1
                else
                    tmux new -s "$argv[3]" -d "fish $PWD/$argv[3]"
                    printf "Recipe $argv[3]"
                    sleep 0.1
                    if test (tmux ls | grep "$argv[3]")
                        echo " is now running"
                    else
                        echo " exited immediately. Try running in your own shell to see what the issue is."
                    end
                end

            case create new
                cd "$HOME/.local/share/mam/recipes"
                if test -e $argv[3]
                    echo "Recipe $argv[3] already exists."
                    exit 1
                else
                    mkdir -p (echo $argv[3] | awk -F/ 'BEGIN{FS=OFS="/"}{NF--; print}')
                    echo -e "#!/usr/bin/fish\n$argv[4]" >"$argv[3]"
                end
            case remove delete rem del
                cd "$HOME/.local/share/mam/recipes"
                if not test -e $argv[3]
                    echo "Recipe $argv[3] does not exist."
                    exit 1
                else
                    rm $argv[3]
                    find . -type d -empty -delete
                end
            case '*'
                m_help
        end

    case '*'
        m_help
end
