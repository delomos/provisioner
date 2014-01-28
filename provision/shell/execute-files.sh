#!/bin/bash

VAGRANT_CORE_FOLDER=$(cat "/.provision-stuff/vagrant-core-folder.txt")

shopt -s nullglob
files=("${VAGRANT_CORE_FOLDER}"/files/exec-once/*)

if [[ ! -f /.provision-stuff/exec-once-ran && (${#files[@]} -gt 0) ]]; then
    echo 'Running files in files/exec-once'
    find "${VAGRANT_CORE_FOLDER}/files/exec-once" -maxdepth 1 -type f \( ! -iname ".gitignore" \) -exec chmod +x '{}' \; -exec {} \;
    echo 'Finished running files in files/exec-once'
    echo 'To run again, delete file /.provision-stuff/exec-once-ran'
    touch /.provision-stuff/exec-once-ran
fi

echo 'Running files in files/exec-always'
find "${VAGRANT_CORE_FOLDER}/files/exec-always" -maxdepth 1 -type f \( ! -iname ".gitignore" \) -exec chmod +x '{}' \; -exec {} \;
echo 'Finished running files in files/exec-always'
