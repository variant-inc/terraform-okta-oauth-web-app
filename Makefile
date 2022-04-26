.PHONY: changelog release docs

changelog:
	git-chglog -o CHANGELOG.md --next-tag `semtag final -s minor -o`

release:
	semtag final -s minor

docs:
	terraform-docs markdown table --output-file README.md --output-mode inject .