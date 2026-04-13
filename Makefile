ROOT_DIR := $(CURDIR)
PACKAGE_NAME := formal
VERSION := $(shell grep '^version = ' typst.toml | sed 's/version = "\(.*\)"/\1/')
UNAME := $(shell uname -s 2>/dev/null)

TEMPLATES = \
	template/formal-text.typ \
	template/formal-letter.typ \
	template/formal-cv.typ \
	template/formal-poster.typ

WEBP_DOCS = $(patsubst template/%.typ,docs/%.webp,$(TEMPLATES))

all: docs

docs: $(WEBP_DOCS)

docs/%.webp: template/%.typ
	@mkdir -p docs
	typst compile --root . $< docs/$*.png --format png --pages 1 --ppi 200
	cwebp -q 90 docs/$*.png -o $@
	rm -f docs/$*.png

clean:
	rm -f docs/*.png docs/*.webp

check:
	typst-package-check check

build:
	zip -r formal.zip src/ template/ docs/ LICENSE README.md typst.toml

link:
ifeq ($(OS),Windows_NT)
	$(MAKE) link-windows
else ifeq ($(UNAME),Darwin)
	$(MAKE) link-macos
else ifeq ($(UNAME),Linux)
	$(MAKE) link-linux
else
	@echo "Unsupported OS"
	@exit 1
endif

link-macos:
	mkdir -p ~/Library/Caches/typst/packages/preview/$(PACKAGE_NAME)
	ln -sfn $(ROOT_DIR) ~/Library/Caches/typst/packages/preview/$(PACKAGE_NAME)/$(VERSION)

link-linux:
	mkdir -p ~/.cache/typst/packages/preview/$(PACKAGE_NAME)
	ln -sfn $(ROOT_DIR) ~/.cache/typst/packages/preview/$(PACKAGE_NAME)/$(VERSION)

# TODO: Test on Windows.
link-windows:
	if not exist "%LOCALAPPDATA%\typst\packages\preview\$(PACKAGE_NAME)" mkdir "%LOCALAPPDATA%\typst\packages\preview\$(PACKAGE_NAME)"
	mklink /D "%LOCALAPPDATA%\typst\packages\preview\$(PACKAGE_NAME)\$(VERSION)" "$(ROOT_DIR)"

.PHONY: all docs clean check build link link-macos link-linux link-windows
