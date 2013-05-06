.SUFFIXES: .eps .dvi .ps .bbl .bib .tex .plo .tif .pdf


SHELL=/bin/sh


lineplot = ploticus -eps -tightcrop -o $(1).eps lineplot.plo infile=$(2) \
	title=$(3) ytitle=$(4) ymin=$(5) ymax=$(6); \
	epstopdf $(1).eps; \
	rm -f $(1).eps



GRAPHICS:=ImageGeneration-full.png GoogleMap-full.png \
	jpeg_detail.png overlay_detail.png \
	tasmania_stats.pdf data_size.pdf data_generation_time.pdf \
	page_load_time.pdf combined_time.pdf real_memory.pdf virtual_memory.pdf \
	data_server.pdf image_server.pdf model_interaction.pdf shared.pdf \
	16384_points.png


Map_Visualisation.pdf: Map_Visualisation.tex Map_Visualisation.bib $(GRAPHICS)
	pdflatex $<
	bibtex $*
	pdflatex $<
	pdflatex $<


jpeg_detail.png: ImageGeneration-full.png
	convert -crop 180x95+150+95 $< $@

overlay_detail.png: PointOverlay-full.png
	convert -crop 180x95+150+95 $< $@

data_size.pdf: d_data_size.txt lineplot.plo
	$(call lineplot,$*,$<,'Size of Generated Data','Data size (kB)',1,200000)

data_generation_time.pdf: d_data_generation_time.txt lineplot.plo
	$(call lineplot,$*,$<,'Data Generation Time','Average time to generate data at server (s)',0.001,2000)

page_load_time.pdf: d_page_load_time.txt lineplot.plo
	$(call lineplot,$*,$<,'Map Display Time','Average time to display map at client (s)',0.001,2000)

combined_time.pdf: d_combined_time.txt lineplot.plo
	$(call lineplot,$*,$<,'Combined Page Load Time','Average time to generate data and display map (s)',0.001,2000)

real_memory.pdf: d_real_memory.txt lineplot.plo
	$(call lineplot,$*,$<,'Real Memory Usage','Browser real memory size (MB)',10,1200)

virtual_memory.pdf: d_virtual_memory.txt lineplot.plo
	$(call lineplot,$*,$<,'Virtual Memory Usage','Browser virtual memory size (MB)',10,1200)

%.pdf: %.svg
	inkscape --file=$< --export-text-to-path --without-gui --export-eps=$*.eps
	ps2eps --ignoreBB --nohires --loose --gsbbox < $*.eps | ps2pdf -dEPSCrop - $@
	rm -f $*.eps

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
