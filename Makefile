ROCM_CONTAINERFILE = instructlab/containers/rocm/Containerfile
CPU_CONTAINERFILE = containers/cpu/Containerfile

CONTAINERFILES = Containerfile.gfx1100 Containerfile.gfx1030 Containerfile.rocm-ubi9 Containerfile.cpu

.PHONY: all
all: $(CONTAINERFILES)

.PHONY: rebuild
rebuild:
	rm $(CONTAINERFILES)
	$(MAKE) all

# set AMDGPU_ARCH default
# set HSA override
# SELinux context from cache mount (,z is not supported on Ubuntu)
define mkcontainerfile =
	sed -E \
		-e 's|^(ARG AMDGPU_ARCH)=.*|\1=$(1)|g' \
		-e 's|(ARG HSA_OVERRIDE_GFX_VERSION)=.*|\1=$(2)|g' \
		-e 's|(--mount=type=cache,.*),z|\1|g' \
		$(3) > $(4)
endef

Containerfile.gfx1100: $(ROCM_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,gfx1100,11.0.0,$<,$@)

Containerfile.gfx1030: $(ROCM_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,gfx1030,10.3.0,$<,$@)

Containerfile.cpu: $(CPU_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,,,$<,$@)

.PHONY: hack-submodule
hack-submodule:
	if [ -f instructlab/.git ]; then mv instructlab/.git instructlab/.git.bak; fi
	rm -rf instructlab/.git
	cp -r .git/modules/instructlab instructlab/.git
	sed -i '/worktree =/d' instructlab/.git/config
	cp -a containers/rocm/*.repo instructlab/containers/rocm/
