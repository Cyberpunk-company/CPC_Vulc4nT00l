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
if [ -z "${INPUT_FILE}" ]; then
    echo "ERROR: No input file specified."
    usage
    exit 1
fi
if [ -z "${OUTPUT_FILE}" ]; then
    echo "ERROR: No output file specified."
    usage
    exit 1
fi

# Check if the input file exists
if [ ! -f "${INPUT_FILE}" ]; then
    echo "ERROR: File ${INPUT_FILE} does not exist."
    exit 1
fi
    # Set of rules that results in a minifying of about any web file
    # Removing comments, redundant characters, and unefficient stuffs

    # Rules:
    #   sed -e '/<!--/,/-->/d' \                          # Delete HTML comment blocks that start with <!-- and end with -->
    #   -e "s|/\*\(\\\\\)\?\*/|/~\1~/|g"  \               # Temporarily replace escaped block comment endings (*/) with a placeholder /~1~/
    #   -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \      # Remove CSS/JS block comments, but not the ones replaced in the previous step
    #   -e "s|\([^:/]\)//.*$|\1|" -e "s|^//.*$||" | \     # Remove single-line comments, taking care not to remove URLs or other instances of double slashes within code
    #   tr '\n' ' ' |  \                                  # Replace all newlines with spaces, effectively putting the code on a single line
    #   sed -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \  # Again, remove CSS/JS block comments that might have been missed
    #   -e "s|/\~\(\\\\\)\?\~/|/*\1*/|g"  \               # Restore temporarily replaced block comment endings with their original form (*/)
    #   -e "s|\s\+| |g"  \                                # Collapse multiple spaces into a single space
    #   -e "s| \([{;:,]\)|\1|g"  \                        # Remove spaces before certain punctuation characters
    #   -e "s|\([{;:,]\) |\1|g" > "$OUTPUT_FILE"          # Remove spaces after certain punctuation characters, then output to file

    cat ${INPUT_FILE} | \
    sed -e '/<!--/,/-->/d' \
    -e "s|/\*\(\\\\\)\?\*/|/~\1~/|g"  \
    -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \
    -e "s|\([^:/]\)//.*$|\1|" -e "s|^//.*$||" | \
    tr '\n' ' ' |  \
    sed -e "s|/\*[^*]*\*\+\([^/][^*]*\*\+\)*/||g"  \
    -e "s|/\~\(\\\\\)\?\~/|/*\1*/|g"  \
    -e "s|\s\+| |g"  \
    -e "s| \([{;:,]\)|\1|g"  \
    -e "s|\([{;:,]\) |\1|g" > "${OUTPUT_FILE}"
    echo "Result wrote to ${OUTPUT_FILE}"

    # Get file sizes using `stat`
    OUTPUT_SIZE=$(stat -c%s "${OUTPUT_FILE}")
    INPUT_SIZE=$(stat -c%s "${INPUT_FILE}")

    # Calculate the difference
    DIFF=$((OUTPUT_SIZE - INPUT_SIZE))
    echo -e "IN: ${INPUT_SIZE}b\tOUT:${OUTPUT_SIZE}b \t"$(echo "scale=2; (${DIFF} / ${INPUT_SIZE}) * 100" | bc)"%"
