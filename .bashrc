# .bashrc

# iオプションがない場合.bashrcを実行しない
case $- in
    *i*) ;;
      *) return;;
esac

# historyに空白で始めたコマンドと連続した同じコマンドを残さない
HISTCONTROL=ignoreboth

# .bash_historyを上書きせずに追記する
shopt -s histappend

# メモリ上のhistoryリスト数
HISTSIZE=1000

# .bash_historyのリスト数
HISTFILESIZE=2000

# ウィンドウサイズを$LINES, $COLUMNSに反映させる
shopt -s checkwinsize

# **(globstar)を有効化
shopt -s globstar

# lesspipeを有効化
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# chrootを実行した場合にプロンプトに表示するためにdebian_chrootを取得
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# PS1...プロンプト表示を設定
# カラー対応端末ならプロンプトもカラーに
case "$TERM" in
    xterm-color|*-256color)
		PS1='\[\e[38;5;160m\e[48;5;236m\] \t \[\e[48;5;083m\e[38;5;236m\]$(case $? in 0) echo "\[\e[38;5;208m\] ☀ ";; 1) echo "\[\e[38;5;027m\] ☂ ";; *) printf "\[\e[31m\]%4d" $?;; esac)\[\e[m\]${debian_chroot:+($debian_chroot)}\[\e[38;5;083m\e[48;5;156m\]\[\e[38;5;022m\] \u \[\e[38;5;156m\e[48;5;192m\]\[\e[38;5;022m\] \h \[\e[38;5;192m\e[48;5;228m\]\[\e[38;5;022m\] \w $(if [ ${EUID:-${UID}} -eq 0 ]; then echo "\[\e[38;5;228m\e[41m\]\[\e[38;5;214m\] ⚠ \[\e[m\e[31m\] "; else echo "\[\e[m\e[38;5;228m\] "; fi)\[\e[m\]'
		# GCCをカラーに
		export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
		# grepをカラーに
		export GREP_OPTIONS='--color=auto';;

    *) PS1='$(echo $?):${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ';;
esac

# xterm系列端末ならウィンドウのタイトルも変更する
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1";;
esac

# ディレクトリのカラー設定をし、ls, grep等のコマンドをカラーに
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
fi

# 時間がかかるコマンドのあとに通知を行えるalertエイリアスを作成
# ex: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# .bash_aliasesがある場合実行
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# POSIXモードでない場合TAB補完を有効化
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
