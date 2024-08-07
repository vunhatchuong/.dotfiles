#!/usr/bin/env sh

if [ -z "$XDG_PICTURES_DIR" ]; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

scrDir=$(dirname "$(realpath "$0")")
swpy_dir="${HOME}/.config/swappy"
save_dir="${XDG_PICTURES_DIR}/Screenshots"
save_file=$(date +'%Y%m%d-%H:%M:%S_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir
mkdir -p $swpy_dir
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >$swpy_dir/config

grimblast --freeze copysave area $temp_screenshot && swappy -f $temp_screenshot

rm "$temp_screenshot"

if [ -f "${save_dir}/${save_file}" ]; then
    notify-send -a "t1" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
fi
