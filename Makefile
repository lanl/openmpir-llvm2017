# Standard Makefile for compiling LaTeX documents in the Supertech
# group.

DOC=$(shell basename $(CURDIR))

# This line is intentionally blank.

#TARGETS=$(patsubst %,%.pdf,$(DOC))

OTHERS = Makefile # plain-url.bst supertech.sty allpapers.bib

DEPS_DIR = .deps

INCLUDE_DIR=.

LATEXMK = TEXINPUTS=$(INCLUDE_DIR)/: BIBINPUTS=$(INCLUDE_DIR)/: BSTINPUTS=$(INCLUDE_DIR)/: latexmk
LATEXMK_FLAGS = -pdflatex="pdflatex --shell-escape %O %S" -pdf -dvi- -ps- -recorder -M -MP \
                  -e 'show_cus_dep();' -r latexmkrc \

all: paper.pdf

-include $(DEPS_DIR)/$(DOC).pdfP

ifneq (,$(findstring B,$(MAKEFLAGS)))
LATEXMK_FLAGS += -gg
endif

$(DEPS_DIR) :
	if [ ! -d $(DEPS_DIR) ]; then mkdir $@; fi

$(DOC).pdf : $(OTHERS)

###########################################################################
## Make targets for cleaning

clean%:
	rm -f $*.aux $*.ps $*.pdf $*.dvi $*.bbl $*.blg $*.tmp $*.lof $*.log $*.toc $*.out $*.fls $*.fdb_latexmk $(DEPS_DIR)/$*.pdfP *~ *.tex.bak

clean: clean$(DOC)

allclean:
	rm -f *.aux *.dvi *.bbl *.blg *.tmp *.lof *.log *.toc *.out *.fls *.fdb_latexmk $(DEPS_DIR)/*.pdfP $(DOC).pdf *~



###########################################################################
## Make targets for document

pdf : $(DOC).pdf

%.pdf : %.tex $(OTHERS)
	if [ ! -e $(DEPS_DIR) ]; then mkdir $(DEPS_DIR); fi
	$(LATEXMK) $(LATEXMK_FLAGS) -MF $(DEPS_DIR)/$@P $<
	if [ -e $@ ]; then touch $@; fi

# Some nonsense that latexmk doesn't understand with minted can be fixed by telling that these rules are easy.
%.w18 %.out.pyg %.aex: %.tex
	@echo > /dev/null
# remake :
# 	if [ ! -e $(DEPS_DIR) ]; then mkdir $(DEPS_DIR); fi
# 	$(LATEXMK) -g -deps-out=$(DEPS_DIR)/$(DOC).pdfP $(DOC).tex
# 	if [ -e $(DOC).pdf ]; then touch $(DOC).pdf; fi
