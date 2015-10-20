doc/notebook/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'


Schloss_Census2_XXXX_2015.md : doc/notebook/Bacterial_data_acquisition.Rmd doc/notebook/Archaeal_data_acquisition.Rmd Schloss_Census2_XXXX_2015.Rmd
	R -e 'render("Schloss_Census2_XXXX_2015.Rmd")'

write.paper : Schloss_Census2_XXXX_2015.md
