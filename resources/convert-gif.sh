#!/bin/bash

MOV_FILE_NAME=$1
OUT_FILE_NAME=$2

echo "Mov to gif."

echo "Generate palette.."

ffmpeg -y -i $MOV_FILE_NAME -vf fps=10,palettegen palette.png

echo "Generate gif.."
ffmpeg -i $MOV_FILE_NAME -i ./palette.png -filter_complex "fps=10,paletteuse" $OUT_FILE_NAME

echo "Cleaning.."
rm -rf palette.png

echo "Done."


