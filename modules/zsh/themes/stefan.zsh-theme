function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function gitstatus_prompt_update() {
  typeset -g GITSTATUS_PROMPT=''
  local p

  gitstatus_query 'MY' || return 1 # we could use -c to do async
  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0 # not in a repo


  local green='%{%F{green}%}'
  local red='%{%F{red}%}'
  local yellow='%{%F{yellow}%}'
  local blue='%{%F{blue}%}'

  local name
  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
    name=$VCS_STATUS_LOCAL_BRANCH
  elif [[ -n $VCS_STATUS_TAG ]]; then 
    p+='%f#'
    name="${VCS_STATUS_TAG}"
  else
    p+='%f@'
    name="#${VCS_STATUS_COMMIT[1,8]}"
  fi

  (( $#name > 32 )) && name[13,-13]="…"  # truncate long branch names and tags
  p+="${green}${name//\%/%%}"            # escape %

   # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ${green}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+="${green}⇡${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${green}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="${green}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  (( VCS_STATUS_STASHES        )) && p+=" ${green}*${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n $VCS_STATUS_ACTION     ]] && p+=" ${red}${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" ${red}~${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && p+=" ${yellow}+${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" ${yellow}!${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" ${blue}?${VCS_STATUS_NUM_UNTRACKED}"

  GITSTATUS_PROMPT="%f${p}%f"
}

source "$(gitstatus-share)/gitstatus.plugin.zsh" || return

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'

autoload -Uz add-zsh-hook
add-zsh-hook precmd gitstatus_prompt_update

setopt prompt_subst prompt_percent no_prompt_bang

NEWLINE=$'\n'
GIT_PROMPT_INFO=${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}
PROMPT="%F{magenta}%~% %f% %F{yellow}% ${NEWLINE}λ %b%f%"
RPROMPT='$(virtualenv_info)% ${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
