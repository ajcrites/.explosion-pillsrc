randomize_prompt_color () {
   git=$(git_prompt_info)
   if [ -n "$git" ]; then
      git="$git "
   fi
   PROMPT="%{$fg_bold[green]%}%n%F{$((RANDOM % 8))}@%{$fg[magenta]%}mob %{$fg_bold[cyan]%}%~ %{$fg_bold[blue]%}$git%{$fg_bold[red]%}%(!.#.\$) %{$reset_color%}"
   if [ -n "$VIRTUAL_ENV" ]; then
      PROMPT="(pyvenv: $(basename $VIRTUAL_ENV)) $PROMPT"
   fi
}

add-zsh-hook precmd randomize_prompt_color

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

