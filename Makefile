FIG = results/figures
TAB = results/tables
PROCESS = data/process
MOTHUR = data/mothur
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



$(NB)/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'




#done
$(PROCESS)/coverage_by_category_and_time.tsv : code/get_coverage_by_category_and_time.R\
												$(PROCESS)/bacteria.v123.metadata\
												$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_coverage_by_category_and_time.R")'

#done
$(PROCESS)/by_year_analysis.tsv : code/get_time_course_submission_data.R\
									$(PROCESS)/archaea.v123.metadata\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_time_course_submission_data.R")'

#done
$(PROCESS)/bacteria.phyla.counts.tsv : code/get_phylum_counts.R\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_phylum_counts.R"); generate_table("bacteria")'

#done
$(PROCESS)/archaea.phyla.counts.tsv : code/get_phylum_counts.R\
									$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_phylum_counts.R"); generate_table("archaea")'

#done
$(PROCESS)/phylum_category_counts.tsv : code/get_phylum_category_counts.R\
									$(PROCESS)/archaea.v123.metadata\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_phylum_category_counts.R")'

#done
$(PROCESS)/bacteria.cultured_by_time_counts.tsv : code/get_culture_by_time_counts.R\
								$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_culture_by_time_counts.R"); run_domain("bacteria")'

#done
$(PROCESS)/archaea.cultured_by_time_counts.tsv : code/get_culture_by_time_counts.R\
								$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_culture_by_time_counts.R"); run_domain("archaea")'

#done
$(PROCESS)/otu_overlap_by_method.tsv : code/get_otu_overlap_by_method.R\
								$(PROCESS)/archaea.v123.metadata\
								$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_otu_overlap_by_method.R")'




#done
$(FIG)/domain_rarefaction.pdf : $(MOTHUR)/all_bacteria.filter.unique.precluster.an.rarefaction\
								$(MOTHUR)/all_archaea.filter.unique.precluster.an.rarefaction\
								code/build_domain_rarefaction_plot.R
	R -e 'source("code/build_domain_rarefaction_plot.R")'

#done
$(FIG)/time_course_figure.pdf : code/build_time_course_plots.R\
								$(PROCESS)/by_year_analysis.tsv
	R -e 'source("code/build_time_course_plots.R")'

#done
$(FIG)/phylum_effort.pdf : code/build_phylum_effort_plot.R\
							$(PROCESS)/bacteria.v123.metadata\
						 	$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/build_phylum_effort_plot.R")'

#done
$(FIG)/category_phylum_heatmap.pdf : code/build_phylum_category_heatmap.R\
									$(PROCESS)/phylum_category_counts.tsv
	R -e 'source("code/build_phylum_category_heatmap.R")'

#done
$(FIG)/phylum_cultured.pdf : code/build_culture_effort_plot.R\
							$(PROCESS)/bacteria.cultured_by_time_counts.tsv\
							$(PROCESS)/archaea.cultured_by_time_counts.tsv
	R -e 'source("code/build_culture_effort_plot.R")'


$(FIG)/venn_otu_by_method.pdf : code/build_otu_overlap_by_method_venn.R\
							$(PROCESS)/otu_overlap_by_method.tsv
	R -e 'source("code/build_otu_overlap_by_method_venn.R")'






#done
results/tables/coverage_by_category_and_time_table.pdf : \
							results/tables/build_coverage_by_category_and_time_table.Rmd\
							$(PROCESS)/coverage_by_category_and_time.tsv\
							results/tables/table_header.tex
	R -e 'render("results/tables/build_coverage_by_category_and_time_table.Rmd", output_file="coverage_by_category_and_time_table.pdf")'


#generate supplmentary files



#need to fix dependencies
Schloss_Census2_mBio_2015.pdf Schloss_Census2_mBio_2015.md : \
						$(MOTHUR)/all_bacteria.filter.unique.precluster.an.rarefaction\
						$(MOTHUR)/all_archaea.filter.unique.precluster.an.rarefaction\
						$(PROCESS)/coverage_by_category_and_time.tsv\
						$(PROCESS)/by_year_analysis.tsv\
						$(PROCESS)/bacteria.phyla.counts.tsv\
						$(PROCESS)/archaea.phyla.counts.tsv\
						$(PROCESS)/coverage_by_category_and_time.tsv\
						$(PROCESS)/phylum_category_counts.tsv\
						$(PROCESS)/bacteria.cultured_by_time_counts.tsv\
						$(PROCESS)/archaea.cultured_by_time_counts.tsv\
						$(PROCESS)/otu_overlap_by_method.tsv\
						$(FIG)/category_phylum_heatmap.pdf\
						$(FIG)/domain_rarefaction.pdf\
						$(FIG)/phylum_cultured.pdf\
						$(FIG)/phylum_effort.pdf\
						$(FIG)/time_course_figure.pdf\
						$(FIG)/venn_otu_by_method.pdf\
						$(TAB)/coverage_by_category_and_time_table.pdf\
						Schloss_Census2_mBio_2015.Rmd
	R -e 'render("Schloss_Census2_mBio_2015.Rmd", clean=FALSE)'
	mv Schloss_Census2_mBio_2015.knit.md Schloss_Census2_mBio_2015.md
	rm Schloss_Census2_mBio_2015.utf8.md

write.paper : Schloss_Census2_mBio_2015.md\
				$(NB)/Bacterial_data_acquisition.Rmd\
				$(NB)/Archaeal_data_acquisition.Rmd
