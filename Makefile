FIGS = results/figures
MOTHUR = data/mothur

$(FIGS)/fifty_authors_deposited.pdf $(FIGS)/phyla_deposited.pdf $(FIGS)/otus_deposited.pdf		$(FIGS)/sequences_deposited.pdf : code/time_course_plots.R $(MOTHUR)/archaea.final.metadata	$(MOTHUR)/bacteria.final.metadata
	R -e 'source(code/time_course_plots.R)'


doc/notebook/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'


Schloss_Census2_XXXX_2015.md : doc/notebook/Bacterial_data_acquisition.Rmd doc/notebook/Archaeal_data_acquisition.Rmd Schloss_Census2_XXXX_2015.Rmd
	R -e 'render("Schloss_Census2_XXXX_2015.Rmd")'

write.paper : Schloss_Census2_XXXX_2015.md
