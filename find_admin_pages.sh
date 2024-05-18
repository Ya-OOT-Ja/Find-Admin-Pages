#!/bin/bash

# Define the directory to search. Default to current directory if not provided.

DIRECTORY=${1:-.}

# Define an array of keywords to search for.

KEYWORDS=("admin" "administrator" "dashboard" "manage" "controlpanel" "useradmin")

# Check if the provided directory exists.

if [ ! -d "$DIRECTORY" ]; then
  echo "Directory $DIRECTORY does not exist."
  exit 1
fi

# Temporary file to store results

TEMP_FILE=$(mktemp)

# Search for files containing any of the keywords.

echo "Searching for admin-related pages in directory: $DIRECTORY"
for keyword in "${KEYWORDS[@]}"; do
  echo "Searching for keyword: $keyword"
  grep -ril --include=\*.{php,html,js,css} "$keyword" "$DIRECTORY" >> "$TEMP_FILE"
done

# Remove duplicate entries

sort -u "$TEMP_FILE" -o "$TEMP_FILE"

# Display results

echo "Search completed. Admin-related pages found:"
if [ -s "$TEMP_FILE" ]; then
  cat "$TEMP_FILE"
else
  echo "No admin-related pages found."
fi

# Clean up

rm "$TEMP_FILE"

#---- Explanation : ----#

#---- DIRECTORY: Sets the directory to search. It defaults to the current directory (.) if not provided as an argument.

#---- KEYWORDS: An array of keywords that are commonly found in admin pages.

#---- Directory Check: Verifies if the specified directory exists.

#---- Search Loop: Loops through each keyword and uses grep to search recursively (-r) for the keyword, ignoring case (-i), and includes files with extensions .php, .html, .js, and .css.

#---- Usage:Save the script to a file, for example, find_admin_pages.sh.

#---- Make the script executable:chmod +x find_admin_pages.sh

#---- Run the script, optionally providing a directory:./find_admin_pages.sh /path/to/source/codeIf no directory is provided, it will search in the current directory.

#---- Yautja ----#


