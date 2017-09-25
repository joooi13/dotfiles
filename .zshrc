# 環境変数
export LANG=ja_JP.UTF-8

#zshのPATHここ？
export PATH=$PATH:/Users/yujoi/android-sdks/platform-tools
export PATH=$PATH:/Users/yujoi/android-sdks/tools
export PATH=$PATH:/Users/yujoi/android-sdks/tools/bin
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
PROMPT='%m:%F{green}%~%f %n %F{yellow}%f🎃   '
RPROMPT='${vcs_info_msg_0_}'
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae] 🤔 ? %{$reset_color%}"

# alias
alias ls='ls -aF'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias cat='cat -n'
alias less='less -NM'

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

#ghq+peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

#peco 履歴表示
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

#
setopt nonomatch


#test
PROMPT='%m:%F{green}%~%f %n %F{yellow}%f🎃   '
RPROMPT='${vcs_info_msg_0_}'
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae] 🤔 ? %{$reset_color%}"

case ${HOSTNAME} in 
    r*)
        local HOSTCOLOR=$'\e[30;48;5;183m'
        ;;
    N*)
        local HOSTCOLOR=$'\e[36;48;5;081m'
        ;;
esac

local COLOR_FG=$'\e[38;5;034m'
local COLOR_BG=$'\e[30;48;5;082m'
local COLOR_RESET=$'\e[0m'
# PROMPT="${COLOR_FG}[%h:%n@${COLOR_RESET}${HOSTCOLOR}%m${COLOR_RESET}${COLOR_FG}:%c]>${COLOR_RESET}"
#PROMPT="%{${COLOR_FG}%}[%h:%n@%{${COLOR_RESET}%}%{${HOSTCOLOR}%}%m%{${COLOR_RESET}%}%{${COLOR_FG}%}:%c]>%{${COLOR_RESET}%}"

