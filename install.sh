#!/bin/bash

DIR_PATH="${HOME}/.config/zsh"
ZSHRC_PATH="${HOME}/.zshrc"

FILES=(
	"./zsh/zcompdump"
	"./zsh/zhistory"
)

function load_config_file {
	cp "zshrc" "$ZSHRC_PATH"
	echo "The file .zshrc successful loaded :)"
} 

function check_exist_file {
	if [ -f "$ZSHRC_PATH" ]; then
		read -p "The file .zshrc exist. Make a backup copy and upload a new one? [Y/n]: " -n 1 -r
		echo

		if [[ ! $REPLY =~ ^[Nn]$ ]]; then
			BACKUP_FILE="$ZSHRC_PATH.bak.$(date +%Y%m%d_%H%M%S)"
			mv "$ZSHRC_PATH" "$BACKUP_FILE"
			echo "Backup save as: $BACKUP_FILE"

			echo "Load new .zshrc file..."
			load_config_file
		else
			echo "Googbuy :("
			exit 0
		fi
	else
		echo "Load .zshrc file..."
		load_config_file
	fi
}

function create_dir {
	if [ ! -d "$DIR_PATH" ]; then
		echo "Folder $DIR_PATH not found. Creating..."
		mkdir -p "$DIR_PATH"
		if [ $? -ne 0 ]; then
			echo "Error: failed to create folder $DIR_PATH"
			exit 1
		fi

		echo "Folder has been created."
	else
		echo "Folder $DIR_PATH exist."
	fi
}

function copy_files {
	for file in "${FILES[@]}"; do
		if [ -f "$file" ]; then
			echo "Coping $file in $DIR_PATH"
			cp "$file" "$DIR_PATH"

			if [ $? -ne 0 ]; then
				echo "Error while coping $file"
			fi
		else
			echo "File $file not found"
		fi
	done	
}

function change_default_shell_for_current_user {
	chsh -s /usr/bin/zsh	
}

check_exist_file	
create_dir
copy_files
change_default_shell_for_current_user
