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
alias vim="nvim"
alias g='git'
alias tree='tree -N'
alias note='cd ~/Documents/note/ && tree -N'
alias today='cd ~/Documents/note/ && nvim 01_journal/$(date +%m-%d).md'
alias todo='nvim -O ~/Documents/note/00_todo/{inbox,todo,done}.md -c "windo normal zR" -c "wincmd h"'


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
