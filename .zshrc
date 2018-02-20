# ZSH DIRECTORY
export ZSH=~/.oh-my-zsh

# DEFAULT EDITOR
export VISUAL=vim
export EDITOR="$VISUAL"

# THEME
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_CHAR="→"
#BULLETTRAIN_CUSTOM_MSG="λ"
if [ -z ${MINIMAL_THEME+x} ]
then
    BULLETTRAIN_PROMPT_ORDER=(
      time
      status
      #custom
      context
      dir
      #screen
      #virtualenv
      git
      cmd_exec_time
    )
else
    BULLETTRAIN_PROMPT_ORDER=(
      status
      dir
    )
fi
if ! [ -z ${LIGHT_THEME+x} ]
then
    BULLETTRAIN_TIME_BG="black"
    BULLETTRAIN_TIME_FG="white"
    BULLETTRAIN_CONTEXT_BG="white"
    BULLETTRAIN_CONTEXT_FG="black"
    BULLETTRAIN_DIR_BG="cyan"
    BULLETTRAIN_DIR_FG="white"
fi

# IN-CASESENSITIVE COMMAND SEARCHING
CASE_SENSITIVE="false"

# AUTO COMMAND CORRECTION
ENABLE_CORRECTION="true"

# LOADED PLUGINS
plugins=(
  git
  fast-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias python=python3
alias pip=pip3
