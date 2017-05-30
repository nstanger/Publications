.SUFFIXES: .eps .dvi .ps .bbl .bib .tex .plo .tif .pdf


SHELL=/bin/sh


lineplot = ploticus -eps -tightcrop -o $(1).eps lineplot.plo infile=$(2) \
	title=$(3) ytitle=$(4) ymin=$(5) ymax=$(6); \
	epstopdf $(1).eps; \
	rm -f $(1).eps



GRAPHICS:=otago_growth.pdf otago_items.pdf growth_comparison.pdf


OCLC.pdf: OCLC.tex OCLC.bib $(GRAPHICS)
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<


otago_growth.pdf: otago_growth.plo
	ploticus -eps -croprel 0,0.2,0.7,0 -o $*.eps $<
	epstopdf $*.eps
	rm -f $*.eps

otago_items.pdf: otago_items.plo
	ploticus -eps -croprel 0.2,0,0,0 -o $*.eps $<
	epstopdf $*.eps
	rm -f $*.eps

growth_comparison.plo: chunk_logstubs chunk_logtics

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ps OCLC.pdf


%.pdf: %.plo
	ploticus -eps -tightcrop -o $*.eps $<
	epstopdf $*.eps
	rm -f $*.eps

%.pdf: %.svg
	inkscape --file=$< --export-text-to-path --without-gui --export-eps=$*.eps
	ps2eps --ignoreBB --nohires --loose --gsbbox < $*.eps | ps2pdf -dEPSCrop - $@
	rm -f $*.eps

%.pdf: %.ps
	ps2pdf -dNOCACHE $< $@

%.ps: %.dvi
	dvips -o $@ $<

%.dvi: %.tex
	latex $<
	latex $<

%.eps: %.tif
	convert $< $@
