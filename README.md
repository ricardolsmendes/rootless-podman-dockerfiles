# rootless-podman-dockerfiles

Dockerfiles to build OCI images shipped with [Podman container
runtine](https://podman.io/) in _rootless mode_.

![CI](https://github.com/ricardolsmendes/rootless-podman-dockerfiles/workflows/CI/badge.svg)

I've been using these images to **test** how Podman behaves when running inside
containers. To be more specific, I'm trying to use them to **build images inside
containers** as an alternative to Docker in Docker (DinD).

Instructions and results are presented below.

## 1. Docker usage

### 1.1. Build a Podman image in _rootless mode_

```sh
cd <BASE-LINUX-FLAVOR> # e.g. fedora
docker build --rm -t rootless-podman .
```

### 1.2. Run a container

```sh
docker run -it --rm rootless-podman /bin/bash
```

### 1.3. Run a container in _privileged mode_

```sh
docker run -it --privileged --rm rootless-podman /bin/bash
```

### 1.4. Build image inside a container results

- **Docker-managed containers**: _privileged mode_ is required to build images
  inside a given container and works as expected.

## 2. Podman usage

### 2.1. Build a Podman image in _rootless mode_

```sh
cd <BASE-LINUX-FLAVOR> # e.g. fedora
podman build --rm -t rootless-podman .
```

### 2.2. Run a container

```sh
podman run -it --rm rootless-podman /bin/bash
```

### 2.3. Run a container in _privileged mode_

```sh
podman run -it --privileged --rm rootless-podman /bin/bash
```

### 2.4. Build image inside a container results

- **Podman-managed containers**: _privileged mode_ is required to build images
  inside a given container, but I receive the following error message when
  trying to do that:

  ```text
  Error: error creating build container: The following failures happened while trying to pull
  image specified by <IMAGE-NAME> based on search registries in /etc/containers/registries.conf:

  * "localhost/<IMAGE-NAME>": Error initializing source docker://localhost/<IMAGE-NAME>: error
  pinging docker registry localhost: Get https://localhost/v2/: dial tcp 127.0.0.1:443: connect:
  connection refused

  * "docker.io/library/<IMAGE-NAME>": Error committing the finished image: error adding layer with
  blob "sha256:997...": Error processing tar file (exit status 1): there might not be enough IDs
  available in the namespace (requested 0:42 for /etc/gshadow): lchown /etc/gshadow: invalid
  argument

  * "quay.io/<IMAGE-NAME>": Error initializing source docker://quay.io/<IMAGE-NAME>: Error reading
  manifest <IMAGE-VERSION> in quay.io/<IMAGE-BASE_NAME>: error parsing HTTP 404 response body:
  invalid character '<' looking for beginning of value: "<...404 Not Found..."
  ```

## 3. How to contribute

Please make sure to take a moment and read the [Code of
Conduct](https://github.com/ricardolsmendes/rootless-podman-dockerfiles/blob/master/.github/CODE_OF_CONDUCT.md).

### 3.1. Report issues

Please report bugs and suggest features via the [GitHub
Issues](https://github.com/ricardolsmendes/rootless-podman-dockerfiles/issues).

Before opening an issue, search the tracker for possible duplicates. If you find a duplicate, please
add a comment saying that you encountered the problem as well.

### 3.2. Contribute code

Please make sure to read the [Contributing
Guide](https://github.com/ricardolsmendes/rootless-podman-dockerfiles/blob/master/.github/CONTRIBUTING.md)
before making a pull request.
