# Makefile für Latex
# Letztes Update: 24-Feb-2019
#
SHELL=/bin/bash
SRC=$(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF=$(SRC:%.tex=%.pdf)
DEP=$(SRC:%.tex=%.d)
SVG=$(shell find ./images -iname "*.svg")
PDFFIG=$(SVG:%.svg=%.pdf)
RM = rm -f

all: $(PDFFIG) $(PDF)

$(PDF): %.pdf: %.tex
	pdflatex $<
	pdflatex $<
	pdflatex $<
	$(RM) *.d *.log *.out *.aux *.run.xml *.toc *-blx.bib *.bcf tex/*.aux

$(PDFFIG): %.pdf : %.svg
	inkscape $< -E $@

$(DEP): %.d : %.tex
	export FIGPATH=$(FIGPATH); \
	$(get_dependencies) echo $$deps ; \
	$(getpdf) echo $$pdfes ; \
	echo "$*.pdf $@ : $< $$deps $$pnges $$pdfes" > $@

-include $(DEP)

clean:
	$(RM) $(PDF)
	$(RM) *.d *.log *.out *.aux *.run.xml *.toc *-blx.bib *.bcf tex/*.aux

.PHONY: clean # Phony Ziele sind immer veraltet

# make -p

# $@ Name des Ziels
# $< Die erste Abhängigkeit
# $+ Alle Abhängigkeiten
# $^ Alle Abhängigkeiten, ohne Dopplungen
# $? Alle ungültigen Abhängigkeiten
