TEMPLATES = \
	template/formal-letter.typ \
	template/formal-cv.typ \
	template/formal-poster.typ

DOCS = $(patsubst template/%.typ,docs/%.png,$(TEMPLATES))

all: docs

docs: $(DOCS)

docs/%.png: template/%.typ
	@mkdir -p docs
	typst compile --root . $< $@ --format png --pages 1 --ppi 250
	oxipng -o 4 --strip safe --alpha docs/*.png

clean:
	rm -f docs/*.png

check:
	typst-package-check check

.PHONY: all docs clean check
