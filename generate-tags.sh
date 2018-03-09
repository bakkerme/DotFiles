#!/bin/bash
LC_COLLATE=C find . -type f -iregex ".*\.js$" -not -path "**/node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | sort > newtags
mv newtags tags
