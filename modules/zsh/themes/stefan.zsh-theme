function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

NEWLINE=$'\n'
PROMPT="%F{magenta}%~% %f% %F{yellow}% ${NEWLINE}λ %b%f%"
RPROMPT='$(virtualenv_info)% $(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
