FROM ubuntu:20.04
LABEL author="Ricardo Mendes <ricardolsmendes@gmail.com>"

# ---------------------------------------------------------------------------- #
# Install fuse-overlayfs & podman.                                             #
#                                                                              #
# References:                                                                  #
# github.com/containers/libpod/blob/master/docs/tutorials/rootless_tutorial.md #
# podman.io/blogs/2019/10/29/podman-crun-f31.html                              #
# ---------------------------------------------------------------------------- #

RUN apt-get update -qq \
    && apt-get install -qq -y ca-certificates curl gnupg \
    && . /etc/os-release \
    && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add - \
    && apt-get update -qq \
    && apt-get install -qq -y podman

# ---------------------------------------------------------------------------- #
# Create and activate an unprivileged user.                                    #
# ---------------------------------------------------------------------------- #
ARG IMAGE_BUILDER_USERNAME=imagebuilder

RUN useradd $IMAGE_BUILDER_USERNAME

USER $IMAGE_BUILDER_USERNAME
WORKDIR /home/${IMAGE_BUILDER_USERNAME}
