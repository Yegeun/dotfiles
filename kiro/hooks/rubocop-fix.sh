#!/bin/bash
# Post-write hook: run rubocop --autocorrect on Ruby files

EVENT=$(cat)
FILE=$(echo "$EVENT" | grep -o '"path":"[^"]*"' | head -1 | sed 's/"path":"//;s/"//')

if [[ "$FILE" == *.rb ]]; then
  bundle exec rubocop -A "$FILE" 2>&1
fi

exit 0
