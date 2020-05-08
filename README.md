# rootless-podman-dockerfiles

Dockerfiles to build OCI images shipped with [Podman container
runtine](https://podman.io/) in _rootless mode_.

I've been using these images to __test__ how Podman behaves when running inside
containers. To be more specific, I'm trying to use them to __build images inside
containers__ as an alternative to Docker in Docker (DinD).

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

* __Ubuntu-based/Docker-managed containers__: _privileged mode_ is required to
  build images inside a given container and works as expected.

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

* __Ubuntu-based/Podman-managed containers__: _privileged mode_ is required to
  build images inside a given container, but I receive the following error
  message when trying to do that:

  ```
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
