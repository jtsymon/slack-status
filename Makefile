OUTPUT ?= build

all: build
build: prepare $(OUTPUT)/slack-status.user.js

prepare:
	[ -d $(OUTPUT) ] || mkdir $(OUTPUT)

clean:
	rm -r $(OUTPUT) || :

$(OUTPUT)/%.js: %.coffee
	( \
	cat userscript-header.js; \
	coffee --no-header -cs <$<; \
	) >$@

.PHONY: all build prepare clean
