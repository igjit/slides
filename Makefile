MDS = $(wildcard */*/*/index.md)
HTMLS = $(MDS:.md=.html)
DOTS = $(wildcard */*/*/images/*.dot)
SVGS = $(DOTS:.dot=.svg)

all: $(HTMLS) $(SVGS)

PANDOC_OPTS = --template=templates/custom.html --metadata=meta-image:'https://igjit.github.io/images/avatar.png'

REVEAL_OPTS = --slide-level=1 --highlight-style=zenburn
2017/12/r_users/index.html 2018/01/tiny_pipe/index.html: REVEAL_OPTS = --slide-level=1

DOT_OPTS = -Tsvg -Nfontname=sans-serif -Nfontsize=22

%.svg: %.dot
	dot $(DOT_OPTS) $^ -o $@

%/index.html: %/index.md
	pandoc -s -t revealjs $(PANDOC_OPTS) $(REVEAL_OPTS) -o $@ $^

.PHONY: all
