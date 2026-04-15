#!/usr/bin/env bash

X86_ROSETTA_BINARY=/usr/local/bin/media-control ### aarch64だと動作しなかった 2026.04

# Check if required commands exist
[ ! -f "$X86_ROSETTA_BINARY" ] && echo "Error: $X86_ROSETTA_BINARY not found. Install media-control via Homebrew with Rosetta 2." && exit 1
command -v jq &> /dev/null || { echo "Error: jq is not installed."; exit 1; }
command -v awk &> /dev/null || { echo "Error: awk is not installed."; exit 1; }
command -v open &> /dev/null || { echo "Error: 'open' command of MacOS not found."; exit 1; }

# output example: 地03：封じられた妖怪　～ Lost Place,上海アリス幻樂団,東方地霊殿
NOWPLAYING_CSV=$($X86_ROSETTA_BINARY get | jq -r '[.title,.artist,.album]|join(",")' | awk -F',' '{ print "なうぷれ: " $1 "\nArtist: " $2 "\nAlbum: " $3 }')

open $(jq --arg t "$NOWPLAYING_CSV" -nr '@uri "https://misskey.io/share?text=\($t)"')

exit 0

