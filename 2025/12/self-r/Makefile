QUARTO = docker compose run --rm quarto quarto

.PHONY: all
all: index.html

%.html: %.qmd
	$(QUARTO) render $^

.PHONY: clean
clean:
	rm -rf index.html index_files/
