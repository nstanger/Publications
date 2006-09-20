.SUFFIXES: .eps .dvi .ps .bbl .bib .tex .plo .tif .pdf


SHELL=/bin/sh


lineplot = ploticus -eps -tightcrop -o $(1).eps lineplot.plo infile=$(2) \
	title=$(3) ytitle=$(4) ymin=$(5) ymax=$(6); \
	epstopdf $(1).eps; \
	rm -f $(1).eps



GRAPHICS:=otago_growth.pdf


OCLC.pdf: OCLC.tex OCLC.bib $(GRAPHICS)
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<


# jpeg_detail.png: ImageGeneration-full.png
# 	convert -crop 180x95+150+95 $< $@
# 
# overlay_detail.png: PointOverlay-full.png
# 	convert -crop 180x95+150+95 $< $@

otago_growth.pdf: otago_growth.plo
	$(call lineplot,$*,$<,'Size of Generated Data','Data size (kB)',1,200000)

# data_generation_time.pdf: d_data_generation_time.txt lineplot.plo
# 	$(call lineplot,$*,$<,'Data Generation Time','Average time to generate data at server (s)',0.001,2000)
# 
# page_load_time.pdf: d_page_load_time.txt lineplot.plo
# 	$(call lineplot,$*,$<,'Map Display Time','Average time to display map at client (s)',0.001,2000)
# 
# combined_time.pdf: d_combined_time.txt lineplot.plo
# 	$(call lineplot,$*,$<,'Combined Page Load Time','Average time to generate data and display map (s)',0.001,2000)
# 
# real_memory.pdf: d_real_memory.txt lineplot.plo
# 	$(call lineplot,$*,$<,'Real Memory Usage','Browser real memory size (MB)',10,1200)
# 
# virtual_memory.pdf: d_virtual_memory.txt lineplot.plo
# 	$(call lineplot,$*,$<,'Virtual Memory Usage','Browser virtual memory size (MB)',10,1200)

clean:
	rm -f *.aux *.bbl *.blg *.log *.dvi *.ps OCLC.pdf


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
