#!/bin/bash
echo -e "\n\
 \n\
  ▞▚ ▚▗▘▛▚ ▛▀ ▛▚ ▛▚ ▌▐ ▙▐ ▌▞  ▞▚ ▞▚ ▙▟ ▛▚ ▞▚ ▙▐ ▚▗▘\n\
  ▌▗  ▌ ▛▚ ▛  ▛▚ ▛▘ ▌▐ ▌▜ ▛▖  ▌▗ ▌▐ ▌▐ ▛▘ ▛▜ ▌▜  ▌ \n\
  ▝▘  ▘ ▀▘ ▀▀ ▘▝ ▘  ▝▘ ▘▝ ▘▝ ▘▝▘ ▝▘ ▘▝ ▘  ▘▝ ▘▝  ▘ \n\
        https://cyberpunk.company/tixlegeek\n\
      Copyright© 2024 Cyberpunk.company GPLv3\n\
           This program is free software\n\
                  See LICENSE.txt \n\
 \n\
---------------------------------------------------\n\
 Vulc4nT00l is a full-BASH minifier for HTML/CSS/JS\n\
\n"

INPUT_FILE="${1}"
OUTPUT_FILE="${2}"
# Check if input file is provided
function usage () {
  echo "Usage: ./vulc4n.sh INPUT_FILE OUTPUT_FILE"
}
if [ -z "$INPUT_FILE" ]; then
    echo "ERROR: No input file specified."
    usage
    exit 1
fi
if [ -z "$OUTPUT_FILE" ]; then
    echo "ERROR: No output file specified."
    usage
    exit 1
fi

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: File $INPUT_FILE does not exist."
    exit 1
fi
    # Set of rules that results in a minifying of about any web file
    # Removing comments, redundant characters, and unefficient stuffs
    cat $INPUT_FILE | \
    sed -e '/<!--/,/-->/d' \
    -e "s|/\*\(\\\\\)\?\*/|/~\1~/|g"  \
    -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \
    -e "s|\([^:/]\)//.*$|\1|" -e "s|^//.*$||" | \
    tr '\n' ' ' |  \
    sed -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \
    -e "s|/\~\(\\\\\)\?\~/|/*\1*/|g"  \
    -e "s|\s\+| |g"  \
    -e "s| \([{;:,]\)|\1|g"  \
    -e "s|\([{;:,]\) |\1|g" > "$OUTPUT_FILE"
