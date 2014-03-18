set_current_branch () {
    # `curb` executable determines current branch IF in a git repo
    CURRENT_BRANCH=$(curb)
}

create_prompt () {
    git=$(git_prompt_info)
    if [ -n "$git" ]; then
        git="$git "
    fi
    # Randomize @ in prompt color
    PROMPT="%{$fg_bold[green]%}%n%F{$((RANDOM % 8))}@%{$fg[magenta]%}???? %{$fg_bold[cyan]%}%~ %{$fg_bold[blue]%}$git%{$fg_bold[red]%}%(!.#.\$) %{$reset_color%}"
    if [ -n "$VIRTUAL_ENV" ]; then
        PROMPT="(pyvenv: $(basename $VIRTUAL_ENV)) $PROMPT"
    fi
}

# Display three levels of changes simultaneously:
# * untracked (red)
# * unstaged, but tracked (yellow)
# * staged (green)
parse_git_dirty() {
    local GIT_DIRTY=''

    cd "$(command git rev-parse --show-toplevel)"
    if [[ -n $(command git ls-files -o --exclude-standard) ]]; then
        GIT_DIRTY="$GIT_DIRTY$ZSH_THEME_GIT_PROMPT_DIRTY_UNTRACKED"
    fi
    if [[ -n $(command git ls-files -md) ]]; then
        GIT_DIRTY="$GIT_DIRTY$ZSH_THEME_GIT_PROMPT_DIRTY_TRACKED"
    fi
    if [[ -n $(command git diff --name-only --cached) ]]; then
        GIT_DIRTY="$GIT_DIRTY$ZSH_THEME_GIT_PROMPT_DIRTY_STAGED"
    fi
    cd - >/dev/null

    echo -n $ZSH_THEME_GIT_PROMPT_SUFFIX_START
    if [[ -n $GIT_DIRTY ]]; then
        echo -n "%{$reset_color%} $GIT_DIRTY"
    fi
}

# Override git/hub command to allow for
# * `git help` -- colored man
# * PREVIOUS_BRANCH settings
# * override of git native commands
git() {
    if ! (( $+_has_working_hub  )); then
        hub --version &> /dev/null
        _has_working_hub=$(($? == 0))
    fi
    if [[ "$1" == "help" && $# > 1 ]]; then
        # colored man for git
        man "git-$2"
    elif (( $_has_working_hub )); then
        oper="hub"
    else
        oper="command git"
    fi

    if [ -n $oper ]; then
        if [[ "$1" == "checkout" || "$1" == "co" || "$1" == "d" ]]; then
            # set previous branch when checking out another branch
            export PREVIOUS_BRANCH=$(curb)
            if [[ "$1" == "d" ]]; then
                $oper checkout develop
            else
                shift
                $oper checkout "$@"
            fi
        else
            # allow override of git native commands
            typeset -r git_alias="git-$1"
            if 'which' "$git_alias" >/dev/null 2>&1; then
                shift
                "$git_alias" "$@"
            else
                $oper "$@"
            fi
        fi
    fi
}

add-zsh-hook precmd create_prompt
add-zsh-hook precmd set_current_branch

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_UNTRACKED="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_TRACKED="%{$fg_bold[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY_STAGED="%{$fg_bold[green]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX_START="%{$fg[blue]%})"
