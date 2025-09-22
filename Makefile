TEMPLATES = \
	template/formal-letter.typ \
	template/formal-cv.typ \
	template/formal-poster.typ

DOCS = $(patsubst template/%.typ,docs/%.png,$(TEMPLATES))

all: docs

docs: $(DOCS)

docs/%.png: template/%.typ
	@mkdir -p docs
	typst compile --root . $< $@ --format png

clean:
	rm -f docs/*.png

.PHONY: all docs clean
