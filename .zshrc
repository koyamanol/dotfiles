#=========================================================================
# zsh prompt
#=========================================================================
# Load and format version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{magenta}%*%f %F{cyan}%n:%f%F{yellow}%~%f%F{red}${vcs_info_msg_0_}%f%F{yellow}%#%f '


#=========================================================================
# zsh setting
#=========================================================================
autoload -Uz compinit && compinit            # Enhancement of complement function

export PATH="$PATH:$HOME/bin"                # Add PATH for my script
export CLICOLOR=1                            # Configure command line colors
export LSCOLORS=gxfxcxdxbxegedabagacad

setopt correct                               # Spell check command
setopt noclobber                             # Prevent overwriting files with redirection

HISTSIZE=100000                              # Change command history limit
SAVEHIST=100000                              # Change .zsh_history limit
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
alias g='git'
alias todo='vim -O3 ~/Documents/note/todo/{inbox.md,todo.txt,done.txt}'
alias ob="cd ~/Documents/my_vault && tree -I '.obsidian' -L 2"
alias today="cd ~/Documents/my_vault/daily && vim \$(date +%Y-%m-%d).md"


#=========================================================================
# Homebrew
#=========================================================================
export PATH="/opt/homebrew/bin:$PATH"        # Add PATH for Homebrew

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi


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

# fzf function to search text in files
f() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "

  fzf --disabled --query "$*" \
      --bind "start:reload:$RG_PREFIX ''" \
      --bind "change:reload:$RG_PREFIX {q} || true" \
      --delimiter : \
      --preview 'bat --color=always --style=numbers --highlight-line {2} -- {1}' \
      --preview-window '+{2}+3/3' \
      --bind 'ctrl-o:execute(vim {1} +{2})'
}


#=========================================================================
# Ocaml
#=========================================================================
[[ ! -r /Users/norihiro/.opam/opam-init/init.zsh ]] || source /Users/norihiro/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval $(opam env)


#=========================================================================
# python
#=========================================================================
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"   # Make python3 default
export PATH="$PATH:$HOME/.poetry/bin"                          # Add PATH for poetry

export LC_ALL=en_US.UTF-8                                      # Set the locale for Python
export LANG=en_US.UTF-8


#=========================================================================
# nvm
#=========================================================================
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


#=========================================================================
# ChordPro
#=========================================================================
export PATH="/opt/homebrew/Cellar/perl/5.32.1_1/bin/:$PATH"    # Add PATH for ChordPro
