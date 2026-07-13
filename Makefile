

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_-]+:.*## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: squash-git
squash-git:  ## squash all commits avoid unsigned git commits
	git reset --soft main
	git commit -m "Branding Alignment & UI Refinement: Update typography to Quicksand & Plus Jakarta Sans, localize external image assets, integrate brand logo and sea glass banner, and optimize mobile responsive vertical stacking"
