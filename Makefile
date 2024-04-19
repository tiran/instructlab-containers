ROCM_CONTAINERFILE = instructlab/containers/rocm/Containerfile
CPU_CONTAINERFILE = containers/cpu/Containerfile

CONTAINERFILES = Containerfile.gfx1100 Containerfile.gfx1030 Containerfile.cpu

.PHONY: all
all: $(CONTAINERFILES)

.PHONY: rebuild
rebuild:
	rm $(CONTAINERFILES)
	$(MAKE) all

# set AMDGPU_ARCH default
# set HSA override
# Remove caching optimizations:
#   remove cache mount (,z is not supported on Ubuntu)
#   don't cache RPM packages
#   don't cache pip pachages
define mkcontainerfile =
	sed -E \
		-e 's|^(ARG AMDGPU_ARCH)=.*|\1=$(1)|g' \
		-e 's|(ARG HSA_OVERRIDE_GFX_VERSION)=.*|\1=$(2)|g' \
		-e 's|--mount=type=cache,.*,z||g' \
		-e 's|--setopt=keepcache=True||g' \
		-e 's|/tmp/remove-gfx\.sh|/tmp/remove-gfx.sh \&\& dnf clean all|g' \
		-e 's|PIP_NO_CACHE_DIR=|PIP_NO_CACHE_DIR=off|g' \
		-e '/pip cache remove/d' \
		$(3) > $(4)
endef

Containerfile.gfx1100: $(ROCM_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,gfx1100,11.0.0,$<,$@)

Containerfile.gfx1030: $(ROCM_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,gfx1030,10.3.0,$<,$@)

Containerfile.cpu: $(CPU_CONTAINERFILE) $(MAKEFILE_LIST)
	$(call mkcontainerfile,,,$<,$@)
