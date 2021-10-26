#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk


zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# aliases
# alias ls='ls --color=auto'
alias reload='source ~/.zshrc'
alias gcp='gcloud'
alias gcp-switch='gcloud config configurations activate'



source ~/.secrets

export EDITOR=vim
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt appendhistory

export PATH=/usr/bin:$HOME/bin:$PATH

if type "jenv" > /dev/null; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

export GOPATH="${HOME}/go"
export PATH="${PATH}:${GOPATH}/bin"
export PATH="$HOME/binaries:$PATH"

if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then 
  source '/opt/google-cloud-sdk/completion.zsh.inc'; 
fi
GENIE_AC_ZSH_SETUP_PATH=/Users/kaseyreed/Library/Caches/genie/autocomplete/zsh_setup && test -f $GENIE_AC_ZSH_SETUP_PATH && source $GENIE_AC_ZSH_SETUP_PATH;


if [ "$(uname -s)" = "Linux" ]; then 
  # To address issues with bswpm and intellij
  # TODO: is this still necessary ...
  export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
  export PATH=$HOME/.config/rofi/bin:$PATH
  export DOCKER_HOST=unix:///${XDG_RUNTIME_DIR}/docker.sock
  source /usr/share/nvm/init-nvm.sh
fi;
