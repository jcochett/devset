#!/bin/bash
echo "DevSet Check ---------------- "

VIM_DIR="$HOME/.vim"
EXTRAS_DIR="./extras"

# Color Scheme
TARGET_DIR_COLORS="$VIM_DIR/colors"
SOURCE_DIR_COLORS=$EXTRAS_DIR
FILES_COLOR=("gruvbox.vim")

# Pylint
TARGET_DIR_COMPILER="$VIM_DIR/compiler"
SOURCE_DIR_COMPILER=$EXTRAS_DIR
FILES_COMPILER=("pylint.vim")

# ASCII chart popup
TARGET_DIR_CHARTAB="$VIM_DIR/plugin"
SOURCE_DIR_CHARTAB=$EXTRAS_DIR
FILES_CHARTAB=("chartab.vim")

# Super Tab: Tab autocomplete
TARGET_DIR_SUPERTAB="$VIM_DIR/pack/default/start/supertab/plugin"
FILES_SUPERTAB="supertab.vim"
FILE_PATH_SUPERTAB="$TARGET_DIR_SUPERTAB/$FILES_SUPERTAB"

# Vimrc
TARGET_DIR_VIMRC="$HOME/"
SOURCE_DIR_VIMRC="."
FILES_VIMRC=(".vimrc")

# Vim Help
TARGET_DIR_VIMHELP="$VIM_DIR"
SOURCE_DIR_VIMHELP="."
FILES_VIMHELP=("vim-mem.txt" "vimhelp.txt")

# File Checking Function
check_files() {

    local source_dir="$1"
    local target_dir="$2"
    shift 2
    local files=("$@")

    # Check if source and target directories exist
    if [ ! -d "$source_dir" ]; then
        echo "Source directory does not exist: $source_dir"
        return 1
    fi

    if [ ! -d "$target_dir" ]; then
        echo "Target directory does not exist: $target_dir"
        return 1
    fi

    for file in "${files[@]}"; do
        local src_file="$source_dir/$file"
        local tgt_file="$target_dir/$file"

        # Check if file exists in both locations
        if [ ! -f "$tgt_file" ]; then
            echo "Missing in target: $file"
            continue
        fi

        if [ ! -f "$src_file" ]; then
            echo "Missing in source: $file"
            continue
        fi

        # Compare the files
        if diff -q "$src_file" "$tgt_file" > /dev/null; then
            echo -e "$file \t good"
        else
            echo -e "$file \t differs"
        fi
    done
}

# Check if target directory exists
if [ ! -d "$VIM_DIR" ]; then
    echo "User Vim directory does not exist: $VIM_DIR"
    exit 1
fi

# Super Tab plugin: <TAB> for autocomplete
if [ ! -d "$TARGET_DIR_SUPERTAB" ]; then
    echo "SuperTab directory does not exist: $VIM_DIR"
    exit 1
else
    # Check if the file exists
    if [ -f "$FILE_PATH_SUPERTAB" ]; then
        echo -e "$FILES_SUPERTAB \t good"
    else
        echo -e "$FILES_SUPERTAB \t differs"
    fi
fi


check_files "$TARGET_DIR_COLORS" "$SOURCE_DIR_COLORS" "${FILES_COLOR[@]}"
check_files "$TARGET_DIR_COMPILER" "$SOURCE_DIR_COMPILER" "${FILES_COMPILER[@]}"
check_files "$TARGET_DIR_CHARTAB" "$SOURCE_DIR_CHARTAB" "${FILES_CHARTAB[@]}"
check_files "$TARGET_DIR_VIMHELP" "$SOURCE_DIR_VIMHELP" "${FILES_VIMHELP[@]}"
check_files "$TARGET_DIR_VIMRC" "$SOURCE_DIR_VIMRC" "${FILES_VIMRC[@]}"
