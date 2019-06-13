.PHONY: test release upload
test:
	rake

release:
	@rm -rf objectia-*.gem
	gem build objectia.gemspec

upload:
	gem push objectia-*.gem	