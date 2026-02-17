#!/usr/bin/env bash

set -euo pipefail

source .builder.sh

npm install

mkdir -p tgt/

if [ -d src/pub.favicon/ ]; then

  for entry in src/pub.favicon/*; do

    copy_entry "$entry" "tgt/pub/${entry#src/pub.favicon/}" 
  done
fi

for dir in src/pub.lib.*/; do

  for entry in "${dir}"*; do

    copy_entry "$entry" "tgt/pub/lib/${entry#"${dir}"}"
  done
done

for dir in src/pub.*/; do
 
  dir="${dir%/}"
  
  name="${dir##*.}"

  dir2="${dir#src/}"
  dir2="${dir2%.*}"
  dir2="${dir2//.//}"
  
  if [ -f "$dir/$name.html" ]; then

    build_html "$dir/$name.html" "tgt/$dir2/$name.html"

    build_css "$dir/$name.css" "tgt/$dir2/$name.css"

    build_js "$dir/$name.js" "tgt/$dir2/$name.js"
  fi
done

echo -e "\nDone"
