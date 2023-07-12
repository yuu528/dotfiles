#!/bin/bash

LOCAL_BASHRC="$HOME/.bashrc"
LOCAL_CONFIG="$HOME/.config"
REPO_BASHRC="$(cd $(dirname $0); pwd)/.bashrc"
REPO_CONFIG="$(cd $(dirname $0); pwd)/.config"

function askyn() {
	local prompt=""
	local rev=0
	case $# in
		0)
			prompt="[y/N]: ";;

		1)
			prompt="$1 [y/N]: ";;

		2)
			case $1 in
				"-y")
					prompt="$2 [Y/n]"
					rev=1;;

				*)
					prompt="$2 [y/N]";;
			esac;;
	esac
	read -n1 -p "$prompt" yn

	case "$yn" in
		"")
			if [ $rev -eq 1 ]; then
				true
			else
				false
			fi;;

		[yY]*)
			echo ""
			true;;

		*)
			echo ""
			false;;
	esac
}

function mvbak() {
	if [ -e "$1" ]; then
		mv -bi "$1" "$1.bak"
	fi
}

function mklink() {
	pushd "$LOCAL_CONFIG"
	ln -s "$REPO_CONFIG/$1" "$1"
	popd
}

echo "First time setup wizard of dotfiles"

askyn "Install .bashrc?" && {
	mvbak "$LOCAL_BASHRC"
	pushd "$HOME"
	ln -s "$REPO_BASHRC" ".bashrc"
}

askyn "Install CUI app configs?" && {
	mvbak "$LOCAL_CONFIG/coc"
	mvbak "$LOCAL_CONFIG/nvim"
	mvbak "$LOCAL_CONFIG/powerline-shell"
	mklink coc
	mklink nvim
	mklink powerline-shell
}

askyn "Install GUI configs?" && {
	mvbak "$LOCAL_CONFIG/alacritty"
	mvbak "$LOCAL_CONFIG/i3"
	mklink alacritty
	mklink i3
}

echo "Complete! Bye!"
