.PHONY: squash-git

squash-git:
	git reset --soft main
	git commit -m "Branding Alignment & UI Refinement: Update typography to Quicksand & Plus Jakarta Sans, localize external image assets, integrate brand logo and sea glass banner, and optimize mobile responsive vertical stacking"
