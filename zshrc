# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# fzf key bindings and completion
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# aliases
alias zshconfig="nvim ~/.zshrc"
alias lg="lazygit"
alias t="$HOME/dotfiles/tmux-sessionizer"
alias ta="tmux attach"
alias tn="tmux new-session"
alias updatenotes='cd ~/Vault/cs-notes && git pull && git add . && git commit -m "$(date +%Y-%m-%d)" && git push'

# Lazy load rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
alias rbenv="unalias rbenv; eval \"\$(command rbenv init -)\"; rbenv \$@"

# Lazy load nvm
export NVM_DIR="$HOME/.nvm"
alias nvm="unalias nvm; [ -s \"$(brew --prefix nvm)/nvm.sh\" ] && . \"$(brew --prefix nvm)/nvm.sh\"; nvm \$@"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
export PATH="$HOME/.local/bin:$PATH"
