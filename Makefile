SHELL=/bin/sh


GRAPHICS:=test-environment.eps target-positions.eps \
	throughput.eps movement-time.eps error-rate.eps \
	combobox-learning.eps checkbox-learning.eps \
	combobox-step1.eps combobox-step2.eps


IwC_paper.pdf: IwC_paper.ps

IwC_paper.ps: IwC_paper.dvi

IwC_paper.dvi: IwC_paper.tex bib $(GRAPHICS)
	latex $<
	latex $<

bib: IwC_paper.bbl


test-screenshot.eps: test-screenshot.tif

throughput.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Throughput (bps)" field=throughput

movement-time.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Movement time (s)" field=movement_time

error-rate.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 85" ystubfmt="%g" ylabel="Error rate (%)" field=error_rate

combobox-learning.eps: linechart.plo
	ploticus -eps -tightcrop -o $@ $< field1=combo_mouse_move field2=combo_touch_move label1=Mouse label2=Touch

checkbox-learning.eps: linechart.plo
	ploticus -eps -tightcrop -o $@ $< field1=check_mouse_move field2=check_touch_move label1=Mouse label2=Touch


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
