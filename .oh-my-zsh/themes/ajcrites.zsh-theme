randomize_prompt_color () {
   PROMPT="%{$fg_bold[green]%}%n%F{$((RANDOM % 8))}@%{$fg[magenta]%}mob %{$fg_bold[cyan]%}%~ %{$fg_bold[red]%}%(!.#.\$) %{$reset_color%}"
}

add-zsh-hook precmd randomize_prompt_color

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

