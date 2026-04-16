#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 file1.txt file2.txt ..."
    exit 1
fi

if ! command -v paru &> /dev/null; then
    echo "Error: 'paru' is not installed. Please install it first."
    exit 1
fi

PACKAGES=()

for file in "$@"; do
    if [[ -f "$file" ]]; then
        echo "Reading packages from: $file"
        while IFS= read -r line || [[ -n "$line" ]]; do
            pkg=$(echo "$line" | xargs)
            [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
            PACKAGES+=("$pkg")
        done < "$file"
    else
        echo "Warning: File '$file' not found. Skipping..."
    fi
done

if [ ${#PACKAGES[@]} -gt 0 ]; then
    echo "Found ${#PACKAGES[@]} targets." 
    paru -S --needed "${PACKAGES[@]}"
else
    echo "No packages found to install."
fi
