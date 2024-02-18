function main() {
	## Install a good vim config
	if [ -d ~/.vim_runtime ]; then
		echo "vim_runtime already installed, skipping..."
	else
		git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
		sh ~/.vim_runtime/install_awesome_vimrc.sh
	fi
}

main

