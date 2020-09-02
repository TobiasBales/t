autoload -Uz promptinit
promptinit
# zsh-mime-setup
autoload colors
colors
autoload -Uz zmv # move function
autoload -Uz zed # edit functions within zle
zle_highlight=(isearch:underline)

zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

typeset WORDCHARS="*?_-.~[]=&;!#$%^(){}<>"

function t {
  PROJECT=$(basename $(pwd))
  SESSION=$(tmux ls | grep "${PROJECT}")
  if [[ -z "${SESSION}" ]]; then
    tmux new -s "${PROJECT}"
  else
    tmux attach -t "${PROJECT}"
  fi
}

if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

/opt/t/update.sh

if [ -z "${TMUX}" ]; then
  t
fi

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

eval "$(starship init zsh)"

eval "$(direnv hook zsh)"

function tc {
  tmux new-session -s "${1}-2" -t "${1}"
}

echo "Things to not forget:"
echo "- git trim"
echo "- git codeowners <file>"
