#!/bin/sh

# Get the latest release version number

get_release() {
  release=$(\
    curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest \
    | grep tag_name \
    | cut -d '"' -f 4)
}
