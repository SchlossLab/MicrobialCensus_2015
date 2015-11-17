FIG = results/figures
PROCESS = data/process
NB = doc/notebook


#$(PROCESS)/bacteria.v123.metadata :
#	wget
#	gunzip
#
#$(PROCESS)/archaea.v123.metadata :
#	wget
#	gunzip
#  curl -c COOKIE_JAR -XGET http://figshare.com/s/82ae99a887c811e5a7ab06ec4bbcf141
#  curl -b COOKIE_JAR -XGET http://figshare.com/download/file/2433945 > archaea.final.metadata.gz
#  curl -b COOKIE_JAR -XGET http://figshare.com/download/file/2433946 > bacteria.final.metadata.gz


$(FIG)/fifty_authors_deposited.pdf $(FIGS)/phyla_deposited.pdf $(FIG)/otus_deposited.pdf $(FIGS)/sequences_deposited.pdf : code/time_course_plots.R\
												$(PROCESS)/archaea.final.metadata\
												$(PROCESS)/bacteria.final.metadata
	R -e 'source("code/time_course_plots.R")'


$(NB)/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'



results/tables/table1.pdf : data/process/bacteria.v123.metadata\
							data/process/archaea.v123.metadata\
							results/tables/build_table_1.Rmd\
							results/tables/table_1_header.tex
	R -e 'render("results/tables/build_table_1.Rmd", output_file="table1.pdf")'



Schloss_Census2_XXXX_2015.md : $(NB)/Bacterial_data_acquisition.Rmd\
								$(NB)/Archaeal_data_acquisition.Rmd\
								$(FIG)/fifty_authors_deposited.pdf\
								$(FIGS)/phyla_deposited.pdf\
								$(FIG)/otus_deposited.pdf\
								$(FIGS)/sequences_deposited.pdf\
								results/tables/table1.pdf\
								Schloss_Census2_XXXX_2015.Rmd
	R -e 'render("Schloss_Census2_mBio_2015.Rmd", clean=FALSE)'
	mv Schloss_Census2_mBio_2015.knit.md Schloss_Census2_mBio_2015.md
	rm Schloss_Census2_mBio_2015.utf8.md

write.paper : Schloss_Census2_XXXX_2015.md
