#!/bin/bash

# --------------------------------------------------
# Copyright 2018 Source Foundry Authors
# MIT License
# Source: https://github.com/source-foundry/alt-hack
# ---------------------------------------------------

# 1. Set the path to the downloaded Hack repo here first
HACK_PATH="${HOME}/Downloads/fonts/Hack-git"

# 2. List your alternate glyphs here
declare -a alternates=(
    "u00EC-slab"
    "u00ED-slab"
    "u00EE-slab"
    "u00EF-slab"
    "u012B-slab"
    "u012D-slab"
    "u012F-slab"
    "u0030-forwardslash"
    "u0069-slab"
    "u0129-slab"
    "u0131-slab"
    "u0456-slab"
    "u0457-slab"
    "u0061-straightspur"
    "u00AA-straightspur"
    "u00E0-straightspur"
    "u00E1-straightspur"
    "u00E2-straightspur"
    "u00E3-straightspur"
    "u00E4-straightspur"
    "u00E5-straightspur"
    "u0101-straightspur"
    "u0103-straightspur"
    "u0105-straightspur"
    "u0430-straightspur"
    "u04D1-straightspur"
    "u04D3-straightspur"
)

# 3. Run this script and enjoy!

# ------------------------------------------------------------------------------------------------ #

if [ -z $HACK_PATH ]; then
    echo "❌ Set the HACK_PATH variable in this script to your downloaded Hack repo root."
    exit 1
fi

declare -a styles=("Regular" "Bold" "Italic" "BoldItalic")

for alternate in "${alternates[@]}"
do
    for style in "${styles[@]}"
    do
        stylePath="${HACK_PATH}/source/Hack-${style}.ufo/glyphs"
        lowercaseStyle=$(echo "$style" | tr '[:upper:]' '[:lower:]')
        alternatePath="./glyphs/${alternate}/${lowercaseStyle}"

        if ! cp "$alternatePath"/*.glif "$stylePath"; then
            echo "❌ Aborting patching of Hack, check errors above."
            exit 1
        fi
    done

    echo "✅ Patched $alternate"
done

echo
echo "All done! Now go to the Hack repo and build the font files."
