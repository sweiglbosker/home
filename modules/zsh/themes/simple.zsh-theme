function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# autoload -Uz add-zsh-hook

setopt prompt_subst prompt_percent no_prompt_bang

NEWLINE=$'\n'
PROMPT='%~% %f%  ${NEWLINE}%b%f% '
RPROMPT='$(virtualenv_info)% '
