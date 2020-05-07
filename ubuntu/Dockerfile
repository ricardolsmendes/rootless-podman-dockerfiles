# ---------------------------------------------------------------------------- #
# Build crun from sources because it's not provided as a Ubuntu package yet.   #
# github.com/containers/crun#build                                             #
# ---------------------------------------------------------------------------- #
FROM ubuntu:20.04 AS crun-builder

RUN apt-get update -qq \
    && apt-get install -qq -y make git gcc build-essential pkgconf libtool \
    && apt-get install -qq -y libsystemd-dev libcap-dev libseccomp-dev libyajl-dev \
    && apt-get install -qq -y go-md2man libtool autoconf python3 automake \
    && git clone https://github.com/containers/crun.git

WORKDIR /crun

RUN ./autogen.sh \
    && ./configure \
    && make \
    && make install

FROM ubuntu:20.04
LABEL author="Ricardo Mendes <ricardolsmendes@gmail.com>"

# ---------------------------------------------------------------------------- #
# Install podman.                                                              #
# The Kubic project provides packages for Ubuntu 18.04, 19.04, 19.10 and       #
# 20.04.                                                                       #
#                                                                              #
# Set up podman to run in rootless mode.                                       #
# github.com/containers/libpod/blob/master/docs/tutorials/rootless_tutorial.md #
# ---------------------------------------------------------------------------- #
COPY --from=crun-builder /usr/local/bin/crun /usr/local/bin/

RUN apt-get update -qq \
    && apt-get install -qq -y ca-certificates curl gnupg \
    && . /etc/os-release \
    && echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list \
    && curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add - \
    && apt-get update -qq \
    && apt-get install -qq -y fuse-overlayfs podman \
    && sed -i s/'^runtime = "runc"'/'runtime = "crun"'/ /usr/share/containers/libpod.conf

# ---------------------------------------------------------------------------- #
# Add useful development tools.                                                #
# ---------------------------------------------------------------------------- #
RUN apt-get install -qq -y git

# ---------------------------------------------------------------------------- #
# Create and activate an unprivileged user.                                    #
# ---------------------------------------------------------------------------- #
ENV IMAGE_BUILDER_USERNAME=imagebuilder

RUN useradd $IMAGE_BUILDER_USERNAME \
    && mkdir -p /home/${IMAGE_BUILDER_USERNAME} \
    && chown -R $IMAGE_BUILDER_USERNAME /home/${IMAGE_BUILDER_USERNAME}

USER $IMAGE_BUILDER_USERNAME
WORKDIR /home/${IMAGE_BUILDER_USERNAME}
