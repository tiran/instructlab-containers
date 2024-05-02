.PHONY: all
all:

.PHONY: hack-submodule
hack-submodule:
	if [ -f instructlab/.git ]; then mv instructlab/.git instructlab/.git.bak; fi
	rm -rf instructlab/.git
	cp -r .git/modules/instructlab instructlab/.git
	sed -i '/worktree =/d' instructlab/.git/config
	cp -a containers/rocm/rocm60.repo instructlab/containers/rocm/
	cp -a containers/rocm/de-vendor-torch.sh instructlab/containers/rocm/
