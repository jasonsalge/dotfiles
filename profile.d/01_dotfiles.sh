export PATH=${HOME}/.local/bin:${PATH}

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

function tmac()
{
    echo -en "\033]0; $1 \a"
    tmux -2 attach -t $1 || tmux -2 new-session -s $1
    echo -en "\033]0; `hostname --short` \a"
}
