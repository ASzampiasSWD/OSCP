#!/bin/bash
# Remove Prohibited Files on a Business Computer.

fileName="prohibitedFiles.txt"
if [ -z "$1" ]
  then
    echo "No argument supplied. Please run ./find_prohibited_files.sh / OR ./find_prohibited_files /home instead."
	exit
fi

if [ "$EUID" -ne 0 ]
  then echo "Please run as sudo"
  exit
fi


find $1 -name "*.midi" -type f >> ~/Documents/$fileName
find $1 -name "*.mid" -type f >> ~/Documents/$fileName
find $1 -name "*.mod" -type f >> ~/Documents/$fileName
find $1 -name "*.mp3" -type f >> ~/Documents/$fileName
find $1 -name "*.mp2" -type f >> ~/Documents/$fileName
find $1 -name "*.mpa" -type f >> ~/Documents/$fileName
find $1 -name "*.abs" -type f >> ~/Documents/$fileName
find $1 -name "*.mpega" -type f >> ~/Documents/$fileName
find $1 -name "*.au" -type f >> ~/Documents/$fileName
find $1 -name "*.snd" -type f >> ~/Documents/$fileName
find $1 -name "*.wav" -type f >> ~/Documents/$fileName
find $1 -name "*.aiff" -type f >> ~/Documents/$fileName
find $1 -name "*.aif" -type f >> ~/Documents/$fileName
find $1 -name "*.sid" -type f >> ~/Documents/$fileName
find $1 -name "*.flac" -type f >> ~/Documents/$fileName
find $1 -name "*.ogg" -type f >> ~/Documents/$fileName
echo "All audio files has been listed."

find $1 -name "*.mpeg" -type f >> ~/Documents/$fileName
find $1 -name "*.mpg" -type f >> ~/Documents/$fileName
find $1 -name "*.mpe" -type f >> ~/Documents/$fileName
find $1 -name "*.dl" -type f >> ~/Documents/$fileName
find $1 -name "*.movie" -type f >> ~/Documents/$fileName
find $1 -name "*.movi" -type f >> ~/Documents/$fileName
find $1 -name "*.mv" -type f >> ~/Documents/$fileName
find $1 -name "*.iff" -type f >> ~/Documents/$fileName
find $1 -name "*.anim5" -type f >> ~/Documents/$fileName
find $1 -name "*.anim3" -type f >> ~/Documents/$fileName
find $1 -name "*.anim7" -type f >> ~/Documents/$fileName
find $1 -name "*.avi" -type f >> ~/Documents/$fileName
find $1 -name "*.vfw" -type f >> ~/Documents/$fileName
find $1 -name "*.avx" -type f >> ~/Documents/$fileName
find $1 -name "*.fli" -type f >> ~/Documents/$fileName
find $1 -name "*.flc" -type f >> ~/Documents/$fileName
find $1 -name "*.mov" -type f >> ~/Documents/$fileName
find $1 -name "*.qt" -type f >> ~/Documents/$fileName
find $1 -name "*.spl" -type f >> ~/Documents/$fileName
find $1 -name "*.swf" -type f >> ~/Documents/$fileName
find $1 -name "*.dcr" -type f >> ~/Documents/$fileName
find $1 -name "*.dir" -type f >> ~/Documents/$fileName
find $1 -name "*.dxr" -type f >> ~/Documents/$fileName
find $1 -name "*.rpm" -type f >> ~/Documents/$fileName
find $1 -name "*.rm" -type f >> ~/Documents/$fileName
find $1 -name "*.smi" -type f >> ~/Documents/$fileName
find $1 -name "*.ra" -type f >> ~/Documents/$fileName
find $1 -name "*.ram" -type f >> ~/Documents/$fileName
find $1 -name "*.rv" -type f >> ~/Documents/$fileName
find $1 -name "*.wmv" -type f >> ~/Documents/$fileName
find $1 -name "*.asf" -type f >> ~/Documents/$fileName
find $1 -name "*.asx" -type f >> ~/Documents/$fileName
find $1 -name "*.wma" -type f >> ~/Documents/$fileName
find $1 -name "*.wax" -type f >> ~/Documents/$fileName
find $1 -name "*.wmv" -type f >> ~/Documents/$fileName
find $1 -name "*.wmx" -type f >> ~/Documents/$fileName
find $1 -name "*.3gp" -type f >> ~/Documents/$fileName
find $1 -name "*.mov" -type f >> ~/Documents/$fileName
find $1 -name "*.mp4" -type f >> ~/Documents/$fileName
find $1 -name "*.avi" -type f >> ~/Documents/$fileName
find $1 -name "*.swf" -type f >> ~/Documents/$fileName
find $1 -name "*.flv" -type f >> ~/Documents/$fileName
find $1 -name "*.m4v" -type f >> ~/Documents/$fileName
echo "All video files have been listed."

find $1 -name "*.tiff" -type f >> ~/Documents/$fileName
find $1 -name "*.tif" -type f >> ~/Documents/$fileName
find $1 -name "*.rs" -type f >> ~/Documents/$fileName
find $1 -name "*.im1" -type f >> ~/Documents/$fileName
find $1 -name "*.gif" -type f >> ~/Documents/$fileName
find $1 -name "*.jpeg" -type f >> ~/Documents/$fileName
find $1 -name "*.jpg" -type f >> ~/Documents/$fileName
find $1 -name "*.jpe" -type f >> ~/Documents/$fileName
find $1 -name "*.png" -type f >> ~/Documents/$fileName
find $1 -name "*.rgb" -type f >> ~/Documents/$fileName
find $1 -name "*.xwd" -type f >> ~/Documents/$fileName
find $1 -name "*.xpm" -type f >> ~/Documents/$fileName
find $1 -name "*.ppm" -type f >> ~/Documents/$fileName
find $1 -name "*.pbm" -type f >> ~/Documents/$fileName
find $1 -name "*.pgm" -type f >> ~/Documents/$fileName
find $1 -name "*.pcx" -type f >> ~/Documents/$fileName
find $1 -name "*.ico" -type f >> ~/Documents/$fileName
find $1 -name "*.svg" -type f >> ~/Documents/$fileName
find $1 -name "*.svgz" -type f >> ~/Documents/$fileName
echo "All image files have been listed."


find $1 -name "*.m4b" -type f >> ~/Documents/$fileName
echo "All audiobook files have been listed."

echo "File Logs Located In: ~/Documents/$fileName" 


