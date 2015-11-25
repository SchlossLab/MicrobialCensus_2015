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

#needs help...
$(NB)/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'




#done
$(PROCESS)/coverage_by_category_and_time.tsv : code/coverage_by_category_and_time.R\
												$(PROCESS)/bacteria.v123.metadata\
												$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/coverage_by_category_and_time.R")'

#done
$(PROCESS)/by_year_analysis.tsv : code/time_course_submission_data.R\
									$(PROCESS)/archaea.v123.metadata\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/time_course_submission_data.R")'




#done
$(FIG)/domain_rarefaction.pdf : data/mothur/all_bacteria.filter.unique.precluster.an.rarefaction\
								data/mothur/all_archaea.filter.unique.precluster.an.rarefaction\
								code/domain_rarefaction.R
	R -e 'source("code/domain_rarefaction.R")'

#done
$(FIG)/time_course_figure.pdf : code/time_course_plots.R\
								data/process/by_year_analysis.tsv
	R -e 'source("code/time_course_plots.R")'


$(FIG)/phylum_effort.pdf : code/build_phylum_effort.R\
							$(PROCESS)/bacteria.v123.metadata\
						 	$(PROCESS)/archaea.v123.metadata\
	R -e 'source("code/build_phylum_effort.R")'


$(FIG)/category_phylum_heatmap.pdf : code/build_phylum_category_heatmap.R\
									$(PROCESS)/bacteria.v123.metadata\
									$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/build_phylum_category_heatmap.R")'


#done
results/tables/table1.pdf : results/tables/build_table_1.Rmd\
							data/process/coverage_by_category_and_time.tsv\
							results/tables/build_table_1.Rmd\
							results/tables/table_1_header.tex
	R -e 'render("results/tables/build_table_1.Rmd", output_file="table1.pdf")'





Schloss_Census2_mBio_2015.pdf Schloss_Census2_mBio_2015.md : \
								data/mothur/all_bacteria.filter.unique.precluster.an.rarefaction\
								data/mothur/all_archaea.filter.unique.precluster.an.rarefaction\

								data/process/coverage_by_category_and_time.tsv\

								data/process/by_year_analysis.tsv\
								Schloss_Census2_mBio_2015.Rmd
	R -e 'render("Schloss_Census2_mBio_2015.Rmd", clean=FALSE)'
	mv Schloss_Census2_mBio_2015.knit.md Schloss_Census2_mBio_2015.md
	rm Schloss_Census2_mBio_2015.utf8.md

write.paper : Schloss_Census2_mBio_2015.md\
				$(NB)/Bacterial_data_acquisition.Rmd\
				$(NB)/Archaeal_data_acquisition.Rmd
