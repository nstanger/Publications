.SUFFIXES: .eps .dvi .ps .bbl .bib .tex .plo .tif .pdf


SHELL=/bin/sh


GRAPHICS:=test-environment.eps target-positions.eps \
	throughput.eps movement-time.eps error-rate.eps \
	combobox-learning.eps checkbox-learning.eps \
	combobox-step1.eps combobox-step2.eps \
	variation-text-mouse.eps variation-text-touch.eps \
	variation-combo-mouse.eps variation-combo-touch.eps


Gleeson_paper.pdf: Gleeson_paper.ps

Gleeson_paper.ps: Gleeson_paper.dvi

Gleeson_paper.dvi: Gleeson_paper.tex Gleeson_paper.bib $(GRAPHICS)
	latex $<
	bibtex $*
	latex $<
	latex $<


test-screenshot.eps: test-screenshot.tif

throughput.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Throughput (bps)" field=throughput

movement-time.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 2.25" ystubfmt="%2.1f" ylabel="Movement time (s)" field=movement_time

error-rate.eps: barchart.plo
	ploticus -eps -tightcrop -o $@ $< yrange="0 155" ystubfmt="%g" ylabel="Error rate (%)" field=error_rate

combobox-learning.eps: linechart.plo
	ploticus -eps -tightcrop -o $@ $< field1=combo_mouse_move field2=combo_touch_move label1=Mouse label2=Touch

checkbox-learning.eps: linechart.plo
	ploticus -eps -tightcrop -o $@ $< field1=check_mouse_move field2=check_touch_move label1=Mouse label2=Touch

variation-text-mouse.eps: variation.plo
	ploticus -eps -tightcrop -o $@ $< device=mouse target=text

variation-text-touch.eps: variation.plo
	ploticus -eps -tightcrop -o $@ $< device=touch target=text

variation-combo-mouse.eps: variation.plo
	ploticus -eps -tightcrop -o $@ $< device=mouse target=combo

variation-combo-touch.eps: variation.plo
	ploticus -eps -tightcrop -o $@ $< device=touch target=combo


clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ps


%.pdf: %.ps
	ps2pdf -dNOCACHE $< $@

%.ps: %.dvi
	dvips -o $@ $<

%.dvi: %.tex
	latex $<
	latex $<

%.eps: %.tif
	convert $< $@
