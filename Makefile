default: smirak


main.dvi: *.tex *.bib komlogo-new.eps Makefile images/*
	rm -f *.toc
	cslatex main
	bibtex main
	cslatex main
	cslatex main

main.ps: main.dvi
	dvips main.dvi

main.pdf: *.tex *.bib komlogo-new.pdf Makefile images/*
	rm -f *.toc
	pdfcslatex main
	bibtex main
	pdfcslatex main
	pdfcslatex main

smirak.pdf: *.tex *.bib komlogo-new.pdf Makefile images/*
	rm -f *.toc
	pdfcslatex smirak
	bibtex smirak
	pdfcslatex smirak
	pdfcslatex smirak

only: smirak.pdf

smirak: smirak.pdf commit

commit:
	git commit -a

dvi: main.dvi

ps: main.ps

pdf: main.pdf

all: ps pdf

final: pdf
	cp main.pdf hozza-bc.pdf

clean: 
	rm -f *.log *.aux *.toc *.bbl *.blg *.slo *.srs *.out

dist-clean:
	rm -f *.log *.aux *.toc *.bbl *.blg *.slo *.srs *.out main.ps main.pdf

booklet: main.ps
	cat main.ps | psbook | psnup -2 >main-booklet.ps

