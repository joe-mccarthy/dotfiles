if [ -r "$HOME/.config/secrets/env" ]; then
  . "$HOME/.config/secrets/env"
fi

alias lg="lazygit"
alias ap="ansible-playbook --ask-vault-pass --ask-become-pass -e @~/ansible/vault.yml -i ~/ansible/homelab.yml"

# Terminal toolkit
if command -v batcat >/dev/null 2>&1 && ! command -v bat >/dev/null 2>&1; then
  alias bat="batcat"
fi

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  alias fd="fdfind"
fi

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --group-directories-first --color=auto"
  alias l="eza -lah --group-directories-first --git --color=auto"
  alias ll="eza -lah --group-directories-first --git --color=auto"
  alias la="eza -la --group-directories-first --git --color=auto"
  alias lt="eza --tree --level=2 --group-directories-first --color=auto"
fi

if command -v bat >/dev/null 2>&1 || command -v batcat >/dev/null 2>&1; then
  alias catp="bat --style=plain --paging=never"
  alias preview="bat --style=numbers,changes,header"
fi

if command -v btop >/dev/null 2>&1; then
  alias top="btop"
fi

if command -v duf >/dev/null 2>&1; then
  alias df="duf"
fi

if command -v procs >/dev/null 2>&1; then
  alias ps="procs"
fi

if command -v nvim >/dev/null 2>&1; then
  alias vim="nvim"
  alias vi="nvim"
  alias v="nvim"
fi

alias g="git"
alias gs="git status --short --branch"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --decorate --graph --all -20"
alias gd="git diff"
alias gds="git diff --staged"
alias ff="fastfetch"

# Fuzzy finder defaults
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
elif command -v fdfind >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_DEFAULT_OPTS="--height=45% --layout=reverse --border=rounded --ansi --prompt='> ' --pointer='>' --marker='+' --color=bg+:#282828,bg:#151819,spinner:#fabd2f,hl:#83a598,fg:#ebdbb2,header:#83a598,info:#d3869b,pointer:#8ec07c,marker:#8ec07c,fg+:#fbf1c7,prompt:#8ec07c,hl+:#83a598"

if [ -r /usr/share/doc/fzf/examples/key-bindings.bash ]; then
  . /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -r /usr/share/doc/fzf/examples/completion.bash ]; then
  . /usr/share/doc/fzf/examples/completion.bash
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
