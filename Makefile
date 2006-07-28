.SUFFIXES: .eps .dvi .ps .bbl .bib .tex .plo .tif .pdf


SHELL=/bin/sh


GRAPHICS:=ImageGeneration-full.png GoogleMap-full.png \
	jpeg_detail.png overlay_detail.png \
	tasmania_stats.pdf


Map_Visualisation.pdf: Map_Visualisation.tex Map_Visualisation.bib $(GRAPHICS)
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<


jpeg_detail.png: ImageGeneration-full.png
	convert -crop 180x95+150+95 $< $@

overlay_detail.png: PointOverlay-full.png
	convert -crop 180x95+150+95 $< $@

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
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ps Map_Visualisation.pdf


%.pdf: %.ps
	ps2pdf -dNOCACHE $< $@

%.ps: %.dvi
	dvips -o $@ $<

%.dvi: %.tex
	latex $<
	latex $<

%.eps: %.tif
	convert $< $@
