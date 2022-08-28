#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_CLONE_URL=

if [[ "$SPIN" == "1" ]]; then
    ZINIT_CLONE_URL="https://github.com/zdharma-continuum/zinit.git"
else
    ZINIT_CLONE_URL="git@github.com:zdharma-continuum/zinit.git"
fi;

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone "$ZINIT_CLONE_URL" "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# aliases
# alias ls='ls --color=auto'

source ~/.git-aliases

alias reload='source ~/.zshrc'
alias gcp='gcloud'
alias gcp-switch='gcloud config configurations activate'


export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt appendhistory
alias history='history 1'

if [[ "$SPIN" == "1" ]]; then
    source ~/.kasey-spin
fi;

if [[ ! -f "~/.shopify" ]]; then
    source ~/.secrets
    export GOPATH="${HOME}/go"
    export PATH="${PATH}:${GOPATH}/bin"
    export PATH="$HOME/binaries:$PATH"

    export PATH=/usr/bin:/usr/local/bin:$HOME/bin:/opt/homebrew/bin:$PATH

    if type "jenv" > /dev/null; then
        export PATH="$HOME/.jenv/bin:$PATH"
        eval "$(jenv init -)"
    fi

    eval "$(rbenv init - zsh)"

    if [ "$(uname -s)" = "Linux" ]; then
        source /usr/share/nvm/init-nvm.sh
    fi;

    if [ "$(uname -s)" = "Darwin" ]; then 
        source $HOME/.cargo/env
        
        export NVM_DIR="$HOME/.nvm"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

        export PQ_LIB_DIR="$(brew --prefix libpq)/lib"
    fi;

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/kasey/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kasey/google-cloud-sdk/path.zsh.inc'; fi

    # The next line enables shell command completion for gcloud.
    if [ -f '/Users/kasey/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kasey/google-cloud-sdk/completion.zsh.inc'; fi
fi;