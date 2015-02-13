#!/bin/bash

if [ -f ~/bin/paths-12.0.sh ]; then
    source ~/bin/paths-12.0.sh
fi

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

if [ "${android}" = "" ]; then
    android="${PWD}"
fi

# linker: restore prelink support
cherries+=(78604)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(79136)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(81758)

# SystemUI: allow devices to use a custom torch sysfs path instead of camera iface
cherries+=(81074)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/build/tools/repopick.py -b ${cherries[@]}
fi
