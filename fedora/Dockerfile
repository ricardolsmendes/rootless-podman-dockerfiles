# ---------------------------------------------------------------------------- #
# quay.io/podman/stable is based on registry.fedoraproject.org/fedora:latest.  #
#                                                                              #
# Please refer to                                                              #
# github.com/containers/libpod/blob/master/contrib/podmanimage/stable/Dockerfile
# for details.                                                                 #
# ---------------------------------------------------------------------------- #
FROM quay.io/podman/stable
LABEL author="Ricardo Mendes <ricardolsmendes@gmail.com>"

# ---------------------------------------------------------------------------- #
# Create and activate an unprivileged user.                                    #
# ---------------------------------------------------------------------------- #
ENV IMAGE_BUILDER_USERNAME=imagebuilder

RUN useradd $IMAGE_BUILDER_USERNAME

USER $IMAGE_BUILDER_USERNAME
WORKDIR /home/${IMAGE_BUILDER_USERNAME}
