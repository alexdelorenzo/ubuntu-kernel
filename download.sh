#!/usr/bin/env bash
EXCLUDE=lowlatency
VERSION="${1:-5.6}"
URL="https://kernel.ubuntu.com/~kernel-ppa/mainline/v$VERSION"

curl -s "$URL/" \
  | pup 'a:contains("amd64") text{}' \
  | grep deb | sort | uniq \
  | while read file; do
      if ! test -e "$file" && ! [[ "$file" =~ "$EXCLUDE" ]]; then
        wget "$URL/$file"
      fi
    done

rm -v *$EXCLUDE*
sudo dpkg -i *.deb
