#=========================================================================
# zsh prompt
#=========================================================================
# Load and format version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{magenta}%*%f %F{cyan}%n:%f%F{yellow}%~%F{red}${vcs_info_msg_0_}%f%F{yellow}$%f '


#=========================================================================
# zsh setting
#=========================================================================
autoload -Uz compinit && compinit            # Enhancement of complement function
setopt correct                               # Spell check command
export PATH="$PATH:$HOME/bin"                # Add PATH for my script
export CLICOLOR=1                            # Configure command line colors
export LSCOLORS=gxfxcxdxbxegedabagacad
set -o noclobber                             # Prevent overwriting files with redirection
export HISTCONTROL=ignoreboth:erasedups      # Ignore duplicate commands
export HISTIGNORE=?:??:history               # Ignore specific commands
HISTSIZE=100000                              # Change command history limit
HISTFILESIZE=100000                          # Change .zsh_history limit
setopt share_history                         # Share the history
setopt hist_ignore_all_dups                  # Remove duplicate history
setopt hist_ignore_space                     # Delete history starts with space
export LESS=-R                               # Configure man colors
export LESS_TERMCAP_mb=$'\e[01;33m'          # Begin bold
export LESS_TERMCAP_md=$'\e[01;36m'          # Begin blink
export LESS_TERMCAP_me=$'\e[0m'              # Reset bold/blink
export LESS_TERMCAP_so=$'\e[00;47;30m'       # Begin standout mode
export LESS_TERMCAP_se=$'\e[0m'              # End standout mode
export LESS_TERMCAP_us=$'\e[01;35m'          # Begin underline
export LESS_TERMCAP_ue=$'\e[0m'              # End underline


#=========================================================================
# alias
#=========================================================================
alias tree='tree -N'
alias todo='vim ~/Documents/note/todo/todo.txt'
alias note='cd ~/Documents/note/'


#=========================================================================
# Homebrew
#=========================================================================
export PATH="/usr/local/sbin:$PATH"          # Add PATH for Homebrew


#=========================================================================
# fzf
#=========================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --color=always"
export FZF_DEFAULT_OPTS="--height 60% --multi --reverse --border
                         --bind ctrl-f:page-down,ctrl-b:page-up
                         --ansi
                         --preview 'bat --color=always {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

bindkey -r '^T'
bindkey '^O' fzf-file-widget
bindkey '^G' fzf-cd-widget


#=========================================================================
# python
#=========================================================================
export PATH="/usr/local/opt/python/libexec/bin:$PATH"  # Make python3 default
export PATH="$PATH:$HOME/.poetry/bin"                  # Add PATH for poetry

export LC_ALL=en_US.UTF-8                              # Set the locale for Python
export LANG=en_US.UTF-8
