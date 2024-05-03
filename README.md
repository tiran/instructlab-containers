# Unofficial containers for InstructLab on AMD ROCm GPUs and CPU

**NOTE** This is a personal project to test my container files. It is not endorsed by [InstructLab](https://github.com/instructlab).

The ROCm container file is designed for AMD GPUs with RDNA3 architecture (`gfx1100`). The container can be build for RDNA2 (`gfx1030`) and older GPUs, too. Please refer to [AMD's system requirements](https://rocm.docs.amd.com/projects/install-on-linux/en/develop/reference/system-requirements.html) for a list of officially supported cards. ROCm is known to work on more consumer GPUs. The container file creates a [toolbox](https://github.com/containers/toolbox) container for [`toolbox(1)`](https://www.mankier.com/1/toolbox) command line tool. A toolbox containers has seamless access to the entire system including user's home directory, networking, hardware, SSH agent, and more.

The container comes with a Python virtual env that is already activated.

## Images

Images are hosted on [ghcr.io](https://ghcr.io/tiran/instructlab-containers)

```shell
toolbox create ...
toolbox enter instructlab
```

### AMD ROCm GFX 1100 (Navi 3x / Radeon RX 7000 series)

```shell
toolbox create --image ghcr.io/tiran/instructlab-containers:rocm-fc40-gfx1100 instructlab
```

### AMD ROCm GFX 1030 (Navi 2x / Radeon RX 6000 series)

```shell
toolbox create --image ghcr.io/tiran/instructlab-containers:rocm-fc40-gfx1030 instructlab
```

### CPU (UBI 9)

```shell
podman pull ghcr.io/tiran/instructlab-containers:cpu-ubi9
```

### NVIDIA CUDA 12.4 (UBI 9)

```shell
podman pull ghcr.io/tiran/instructlab-containers:cuda-ubi9
```

### AMD ROCm 6.0.2 (c9s)

```shell
podman pull ghcr.io/tiran/instructlab-containers:rocm-c9df
```

### HPU (Intel Gaudi), HabanaLabs 1.15.1 (RHEL 9)

```shell
podman pull ghcr.io/tiran/instructlab-containers:hpu-rhel-hl1.15.1
```

### Without toolbox

```shell
podman run -ti -v./src:/opt/app-root/src:z --device /dev/dri --device /dev/kfd ...
```
