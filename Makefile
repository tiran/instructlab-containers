# SPDX-License-Identifier: Apache-2.0

BUILD_ARGS =
CENGINE ?= podman
CONTAINER_PREFIX ?= localhost/instructlab

.PHONY: all
all:

.PHONY: hack-submodule
hack-submodule:
	set -e; \
	if [ -f instructlab/.git ]; then mv instructlab/.git instructlab/.git.bak; fi
	rm -rf instructlab/.git
	cp -r .git/modules/instructlab instructlab/.git
	sed -i '/worktree =/d' instructlab/.git/config
	cp -a containers/rocm/rocm60.repo instructlab/containers/rocm/
	cp -a containers/rocm/de-vendor-torch.sh instructlab/containers/rocm/

.PHONY: update
update:
	rm -rf instructlab
	git submodule update --init
	# git submodule set-branch --branch main instructlab
	git -C instructlab fetch --all
	git -C instructlab checkout main
	git -C instructlab reset --hard origin/main

# create image as root
# Error: creating build container: writing blob: adding layer with blob "sha256:e506774bddd3253e705843304288d418a3b20069c7641ef4e2d9d6a4e02da09a": processing tar file(potentially insufficient UIDs or GIDs available in user namespace (requested 10688888:100 for /tmp/libfabric-1.20.0): Check /etc/subuid and /etc/subgid if configured locally and run "podman system migrate": lchown /tmp/libfabric-1.20.0: invalid argument): exit status 1
.PHONY: hpu
hpu: containers/hpu/Containerfile
	$(CENGINE) build $(BUILD_ARGS) \
	    -t $(CONTAINER_PREFIX):$@ \
	    -f $< \
		instructlab-hpu
