#
# utils.sh
#

echo_warn() {
  echo -e "${YELLOW}[WARN]${RESET} $@"
}

echo_error() {
  echo -e "${RED}[ERROR]${RESET} $@"
}

get-ipv4() {
  ip a |\
    grep "inet " |\
    grep ".*127\.0\.0\.1.*" -v |\
    sed 's/\/19.*//' |\
    sed 's/.*inet //' |\
    sed 's/\/24.*//'
}

#
# gitndiff: Compares the contents of two directories or files
# using 'git diff --no-index'.
#
# Usage: gitndiff <dir_or_file_A> <dir_or_file_B>
#
gitndiff() {
    # Check if exactly two arguments were provided
    if [ $# -ne 2 ]; then
        echo "Usage: gitndiff <path/to/A> <path/to/B>"
        echo "Compares two directories or files using 'git diff --no-index'."
        return 1
    fi

    local pathA="$1"
    local pathB="$2"

    # Use 'git diff --no-index' to compare the two paths
    # The '--' ensures paths starting with '-' are handled correctly
    echo "--- Comparing $pathA and $pathB ---"
    git diff --no-index --ignore-cr-at-eol -- "$pathA" "$pathB"
}

#
# lsdiff: Compares the file listings (names only) of two directories.
# It uses 'ls -A' (lists all files, including dotfiles, but excludes . and ..)
# and the 'diff' utility with process substitution.
#
# Usage: lsdiff <dir_A> <dir_B>
#
lsdiff() {
    # Check if exactly two arguments were provided
    if [ $# -ne 2 ]; then
        echo "Usage: lsdiff <dir_A> <dir_B>"
        echo "Compares file listings of two directories."
        return 1
    fi

    local pathA="$1"
    local pathB="$2"

    # --- EXISTENCE AND DIRECTORY CHECK ---
    # Check if the first path exists and is a directory
    if [ ! -d "$pathA" ]; then
        echo "Error: Path A ('$pathA') must be a directory and must exist." >&2
        return 2
    fi

    # Check if the second path exists and is a directory
    if [ ! -d "$pathB" ]; then
        echo "Error: Path B ('$pathB') must be a directory and must exist." >&2
        return 2
    fi
    # -------------------------------------

    echo "--- Comparing file listings of $pathA and $pathB ---"

    # Compare the file listings using diff and process substitution
    # ls -A lists all files, excluding "." and ".."
    diff --color=auto <(ls -A "$pathA") <(ls -A "$pathB")
}

cat-slice() {
  if [ $# -ne 3 ]; then
    echo "Usage: cat-slice <FILE> <START> <END>"
    return 1
  fi

  local FILE=$1
  local START=$2
  local END=$3

  exec head $FILE -n $END | tail -n $(($END - $START + 1))
}

mdgcc() {
  local MDGCC_SOURCE=$(mktemp)
  local MDGCC_BIN=$(mktemp)
  if [ $# -ne 1 ]; then
    echo "Usage: mdgcc <MARKDOWN_FILE>"
    echo "Reads from a markdown file, extract the first coming C code block, compile, and execute."
    return 1
  fi
  local MARKDOWN_FILE="$1"

  # 1. Check if the file exists
  if [ ! -f "$MARKDOWN_FILE" ]; then
    echo "Error: File '$MARKDOWN_FILE' not found."
    return 1
  fi

  ## 📝 Code Extraction
  # Use awk to extract the content between the first '```c' and the next '```'
  # The 'NR>1' in the print statement prevents printing the starting '```c' line itself.
  awk '
    /```c/{
      p=1; # Set print flag to true
      next; # Skip the line containing "```c"
    }
    /```/{
      if (p==1) exit; # Stop reading/printing on the closing "```"
    }
    {
      if (p==1) print; # Print lines only when the flag is set
    }
  ' "$MARKDOWN_FILE" > "$MDGCC_SOURCE"
  
  # Check if code was extracted
  if [ ! -s "$MDGCC_SOURCE" ]; then
    echo "Error: No C code block (\`\`\`c ... \`\`\`) found in '$MARKDOWN_FILE'."
    rm "$MDGCC_SOURCE"
    return 1
  fi

  echo "Successfully extracted C code to: $MDGCC_SOURCE"

  # ---

  ## 🛠️ Compilation (GCC)
  # Compile the extracted C code
  # -o "$MDGCC_BIN" specifies the output binary name
  # -Wall enables all common warnings
  if ! gcc -x c -Wall "$MDGCC_SOURCE" -o "$MDGCC_BIN"; then
    echo "Error: C compilation failed."
    # Clean up temporary files before returning
    rm -f "$MDGCC_SOURCE" "$MDGCC_BIN"
    return 1
  fi

  echo "Compilation successful. Binary saved to: $MDGCC_BIN"
  
  # ---

  ## 🚀 Execution
  echo ""
  echo "--- OUTPUT ---"
  # Execute the compiled binary
  "$MDGCC_BIN"
  local EXIT_CODE=$?
  echo "--------------"
  
  # Clean up temporary files
  rm -f "$MDGCC_SOURCE" "$MDGCC_BIN"

  # Return the exit code of the executed C program
  return $EXIT_CODE
}

