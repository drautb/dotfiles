PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'
RPROMPT="[%{$fg_bold[cyan]%}$USER%{$reset_color%}@%{$fg_bold[green]%}%m%{$reset_color%}][%{$fg_bold[blue]%}%D{%m/%f/%y}%{$reset_color%}|%{$fg_bold[yellow]%}%T%{$reset_color%}]"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
