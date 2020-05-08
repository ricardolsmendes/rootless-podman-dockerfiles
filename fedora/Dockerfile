# ---------------------------------------------------------------------------- #
# quay.io/podman/stable is based on registry.fedoraproject.org/fedora:latest.  #
#                                                                              #
# Please visit                                                                 #
# github.com/containers/libpod/blob/master/contrib/podmanimage/stable/Dockerfile
# for reference                                                                #
# ---------------------------------------------------------------------------- #
FROM quay.io/podman/stable
LABEL author="Ricardo Mendes <ricardolsmendes@gmail.com>"

# ---------------------------------------------------------------------------- #
# Create and activate an unprivileged user.                                    #
# ---------------------------------------------------------------------------- #
ENV IMAGE_BUILDER_USERNAME=imagebuilder

RUN useradd $IMAGE_BUILDER_USERNAME \
    && mkdir -p /home/${IMAGE_BUILDER_USERNAME}/ \
    && chown -R $IMAGE_BUILDER_USERNAME /home/${IMAGE_BUILDER_USERNAME}

USER $IMAGE_BUILDER_USERNAME
WORKDIR /home/${IMAGE_BUILDER_USERNAME}
