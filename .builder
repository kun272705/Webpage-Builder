
build_js() {

  local input="$1"
  local output="$2"

  if [ -f "$input" ]; then

    echo -e "\n$input -> $output\n"

    npx rollup --jsx preserve -i "$input" -o "${output/%.js/.combined.js}" --failAfterWarnings

    npx swc "${output/%.js/.combined.js}" -o "${output/%.js/.transpiled.js}"
    
    sed -i -e "/^import/d" "${output/%.js/.transpiled.js}"

    npx terser "${output/%.js/.transpiled.js}" -o "${output/%.js/.compressed.js}" -c -m

    cp "${output/%.js/.compressed.js}" "$output"

    rm "${output/%.js/.combined.js}"
    rm "${output/%.js/.transpiled.js}"
    rm "${output/%.js/.compressed.js}"
  fi
}
