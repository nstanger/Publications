SHELL=/bin/sh


GRAPHICS:=test-screenshot.eps target-positions.eps \
	throughput.eps movement-time.eps error-rate.eps


IwC_paper.pdf: IwC_paper.ps

IwC_paper.ps: IwC_paper.dvi

IwC_paper.dvi: IwC_paper.tex $(GRAPHICS)
	latex $<
	latex $<

IwC_paper.tex: IwC_paper.bbl


test-screenshot.eps: test-screenshot.tif

throughput.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Throughput (bps)" fieldname=throughput

movement-time.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Movement time (s)" fieldname=movement_time

error-rate.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 100" ystubfmt="%g" ylabel="Error rate (%)" fieldname=error_rate


clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ps


%.bbl: %.bib
	latex $*
	bibtex $*

%.pdf: %.ps
	ps2pdf $< $@

%.ps: %.dvi
	dvips -o $@ $<

%.dvi: %.tex
	latex $<
	latex $<

%.eps: %.tif
	convert $< $@

%.eps: %.sxd
	$(error Re-export $@ from $<)
