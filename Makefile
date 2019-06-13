.PHONY: test release upload
test:
	rake

release:
	gem build objectia.gemspec

upload:
	gem push objectia-0.9.2.gem	