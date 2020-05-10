#!/bin/sh

# ---------------------------------------------------------------------------- #
# Verify `imagebuilder` is the active user.                                    #
# If a different user is provided when starting a container (`--user, -u`      #
# option), this test will fail.                                                #
# ---------------------------------------------------------------------------- #
[ $(whoami) = 'imagebuilder' ] || exit 1

# ---------------------------------------------------------------------------- #
# Verify the current user is allowed call the `podman` binary.                 #
# ---------------------------------------------------------------------------- #
podman --version
[ $? -eq 0 ] || exit 1
