#!/usr/bin/env bash

set -eux

target="$1"

change_display_inputs() {
  lenovo_target="$1"
  dell_target="$2"
  ssh drautb@bens-mac-mini.local 'lunar displays len input '"$1"' && lunar displays dell input '"$2"
}

if [ "$target" == "pc" ]; then 
  change_display_inputs "dp" "dp"
elif [ "$target" == "laptop" ]; then
  change_display_inputs "hdmi" "hdmi1"
elif [ "$target" == "mac-mini" ]; then
  change_display_inputs "usb-c" "hdmi2"
else
  echo "Unrecognized target: $target"
  exit 1
fi
