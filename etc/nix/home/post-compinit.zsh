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

/t/update.sh

eval "$(starship init zsh)"

