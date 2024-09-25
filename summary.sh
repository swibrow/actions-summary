#!/bin/bash
# Process the input string and filter to only contain ASCII characters
ASCII_STRING=$(echo "$INPUT_STRING" | tr -cd '\11\12\15\40-\176')  # Only keep ASCII chars

# Get the length of the ASCII string
STRING_LENGTH=${#ASCII_STRING}

# Check if content exceeds the max length (1MB)
if [ "$STRING_LENGTH" -gt "$MAX_LENGTH" ]; then
  echo ":warning: String content is too long to be displayed (${STRING_LENGTH} chars) after filtering. It exceeds the 1MB limit."
  echo ":warning: Skipping content display due to size."
  exit 0
fi

# Generate a unique delimiter
delimiter=$(openssl rand -hex 8)

# Write the ASCII content to GitHub step summary with a custom header
{
  echo "## $SUMMARY_HEADER"
  echo "summary<<${delimiter}"
  echo "$SUMMARY_HEADER"
  echo "<details><summary>Click to expand</summary>"
  echo '```'
  echo "$ASCII_STRING"
  echo '```'
  echo "</details>"
  echo "${delimiter}"
} >> $GITHUB_STEP_SUMMARY
