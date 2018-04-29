all: */*/*/index.html

REVEAL_OPTS = --slide-level=1 --highlight-style=zenburn
2017/12/r_users/index.html 2018/01/tiny_pipe/index.html: REVEAL_OPTS = --slide-level=1

%/index.html: %/index.md
	pandoc -s -t revealjs $(REVEAL_OPTS) -o $@ $^
