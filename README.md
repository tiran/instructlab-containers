# Unofficial containers for InstructLab on AMD ROCm GPUs and CPU

**NOTE** This is a personal project to test my container files. It is not endorsed by [InstructLab](https://github.com/instructlab).

The ROCm container file is designed for AMD GPUs with RDNA3 architecture (`gfx1100`). The container can be build for RDNA2 (`gfx1030`) and older GPUs, too. Please refer to [AMD's system requirements](https://rocm.docs.amd.com/projects/install-on-linux/en/develop/reference/system-requirements.html) for a list of officially supported cards. ROCm is known to work on more consumer GPUs. The container file creates a [toolbox](https://github.com/containers/toolbox) container for [`toolbox(1)`](https://www.mankier.com/1/toolbox) command line tool. A toolbox containers has seamless access to the entire system including user's home directory, networking, hardware, SSH agent, and more.

The container comes with a Python virtual env that is already activated.

## Quay.io images

Images are hosted on [Quay.io](https://quay.io/repository/tiran/instructlab-containers)

```
toolbox create ...
toolbox enter instructlab
```

### AMD ROCm GFX 1100 (Navi 3x / Radeon RX 7000 series)
```
toolbox create --image quay.io/tiran/instructlab-containers:rocm-gfx1100 instructlab
```

### AMD ROCm GFX 1100 (Navi 2x / Radeon RX 6000 series)
```
toolbox create --image quay.io/tiran/labrador-gpu:instructlab-containers instructlab
```

### CPU
```
toolbox create --image quay.io/tiran/instructlab-containers:cpu instructlab
```
