# Yay! High voltage and arrows!

prompt_setup_pygmalion(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  base_prompt='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}'
  post_prompt='%{$fg[magenta]%} $ %{$reset_color%}'

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}
  local rvm='%{$fg[magenta]%}$(getrvmversion)%{$reset_color%}'
#  local dm='%{$fg[cyan]%}$(docker-machine status)%{$reset_color%}'
  local nl=""

  #if [[ $prompt_length -gt 40 ]]; then
  #  nl=$'\n%{\r%}';
  #fi

  PROMPT="$base_prompt$nl$post_prompt"

  #if [[ $(git status) =~ [*fatal*] ]]; then
    #RPROMPT="D:$dm R:$rvm G:$gitinfo"
    RPROMPT="R:$rvm G:$gitinfo"
  #else
  #  RPROMPT="D:$dm R:$rvm"
  #fi

}

prompt_setup_pygmalion
