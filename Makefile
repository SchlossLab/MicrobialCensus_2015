FIG = results/figures
TAB = results/tables
PROCESS = data/process
MOTHUR = data/mothur
NB = doc/notebook


$(NB)/%_data_acquisition.Rmd:
	R -e 'render("doc/notebook/%_data_acquisition.Rmd")'




$(PROCESS)/bacteria.v123.metadata : #
	wget --no-check-certificate -O $@.gz https://ndownloader.figshare.com/files/3678546
	gunzip $@.gz


$(PROCESS)/archaea.v123.metadata : #
	wget --no-check-certificate -O $@.gz https://ndownloader.figshare.com/files/3678552
	gunzip $@.gz



FIGSHARE : 	$(PROCESS)/bacteria.v123.metadata\
			$(PROCESS)/archaea.v123.metadata




#done
$(PROCESS)/coverage_by_category_and_time.tsv : code/get_coverage_by_category_and_time.R\
												code/partition_data.R\
												$(PROCESS)/bacteria.v123.metadata\
												$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_coverage_by_category_and_time.R")'

#done
$(PROCESS)/by_year_analysis.tsv : code/get_time_course_submission_data.R\
									code/partition_data.R\
									$(PROCESS)/archaea.v123.metadata\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_time_course_submission_data.R")'

#done
$(PROCESS)/bacteria.phyla.counts.tsv : code/get_phylum_counts.R\
									code/partition_data.R\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_phylum_counts.R"); generate_table("bacteria")'

#done
$(PROCESS)/archaea.phyla.counts.tsv : code/get_phylum_counts.R\
									code/partition_data.R\
									$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_phylum_counts.R"); generate_table("archaea")'

#done
$(PROCESS)/phylum_category_counts.tsv : code/get_phylum_category_counts.R\
									code/partition_data.R\
									$(PROCESS)/archaea.v123.metadata\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_phylum_category_counts.R")'

#done
$(PROCESS)/bacteria.cultured_by_time_counts.tsv : \
									code/get_culture_by_time_counts.R\
									code/partition_data.R\
									$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_culture_by_time_counts.R"); run_domain("bacteria")'

#done
$(PROCESS)/archaea.cultured_by_time_counts.tsv : code/get_culture_by_time_counts.R\
										code/partition_data.R\
										$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/get_culture_by_time_counts.R"); run_domain("archaea")'

#done
$(PROCESS)/otu_overlap_by_method.tsv : code/get_otu_overlap_by_method.R\
								$(PROCESS)/archaea.v123.metadata\
								$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/get_otu_overlap_by_method.R")'

#done
$(PROCESS)/bacteria.all_rarefaction.tsv : 	code/rarefy_metadata.R\
								$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/rarefy_metadata.R"); rarefy_all("$(PROCESS)/bacteria.v123.metadata")'

#done
$(PROCESS)/archaea.all_rarefaction.tsv : 	code/rarefy_metadata.R\
								$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/rarefy_metadata.R"); rarefy_all("$(PROCESS)/archaea.v123.metadata")'

#done
$(PROCESS)/bacteria.env_rarefaction.tsv : 	code/rarefy_metadata.R\
								$(PROCESS)/bacteria.v123.metadata
	R -e 'source("code/rarefy_metadata.R"); rarefy_by_coarse("$(PROCESS)/bacteria.v123.metadata")'

#done
$(PROCESS)/archaea.env_rarefaction.tsv : 	code/rarefy_metadata.R\
								$(PROCESS)/archaea.v123.metadata
	R -e 'source("code/rarefy_metadata.R"); rarefy_by_coarse("$(PROCESS)/archaea.v123.metadata")'


SUMMARY_TABLES: $(PROCESS)/coverage_by_category_and_time.tsv \
				$(PROCESS)/by_year_analysis.tsv \
				$(PROCESS)/bacteria.phyla.counts.tsv \
				$(PROCESS)/archaea.phyla.counts.tsv \
				$(PROCESS)/phylum_category_counts.tsv \
				$(PROCESS)/bacteria.cultured_by_time_counts.tsv \
				$(PROCESS)/archaea.cultured_by_time_counts.tsv \
				$(PROCESS)/otu_overlap_by_method.tsv\
				$(PROCESS)/bacteria.all_rarefaction.tsv\
				$(PROCESS)/archaea.all_rarefaction.tsv\
				$(PROCESS)/bacteria.env_rarefaction.tsv\
				$(PROCESS)/archaea.env_rarefaction.tsv





#Figure 1
$(FIG)/domain_rarefaction.eps : code/build_domain_rarefaction_plot.R\
								$(PROCESS)/archaea.all_rarefaction.tsv\
								$(PROCESS)/archaea.env_rarefaction.tsv\
								$(PROCESS)/bacteria.all_rarefaction.tsv\
								$(PROCESS)/bacteria.env_rarefaction.tsv
	R -e 'source("code/build_domain_rarefaction_plot.R")'

#Figure 2
$(FIG)/time_course_figure.eps : code/build_time_course_plots.R\
								$(PROCESS)/by_year_analysis.tsv
	R -e 'source("code/build_time_course_plots.R")'

#Figure 3
$(FIG)/category_phylum_heatmap.eps : code/build_phylum_category_heatmap.R\
									$(PROCESS)/phylum_category_counts.tsv
	R -e 'source("code/build_phylum_category_heatmap.R")'

#Figure 4
$(FIG)/phylum_effort.eps : code/build_phylum_effort_plot.R\
							$(PROCESS)/bacteria.phyla.counts.tsv\
						 	$(PROCESS)/archaea.phyla.counts.tsv
	R -e 'source("code/build_phylum_effort_plot.R")'

#Figure 5
$(FIG)/phylum_cultured.eps : code/build_culture_effort_plot.R\
							$(PROCESS)/bacteria.cultured_by_time_counts.tsv\
							$(PROCESS)/archaea.cultured_by_time_counts.tsv
	R -e 'source("code/build_culture_effort_plot.R")'

#Figure 6
#xxx
$(FIG)/otu_overlap_by_method.eps : code/build_otu_overlap_by_method_figure.R\
							$(PROCESS)/otu_overlap_by_method.tsv
	R -e 'source("code/build_otu_overlap_by_method_figure.R")'


FIGURES :	$(FIG)/domain_rarefaction.eps \
			$(FIG)/time_course_figure.eps \
			$(FIG)/category_phylum_heatmap.eps \
			$(FIG)/phylum_effort.eps \
			$(FIG)/phylum_cultured.eps \
			$(FIG)/otu_overlap_by_method.eps




#Table 1
$(TAB)/coverage_by_category.pdf : \
							$(TAB)/build_coverage_by_category.Rmd\
							$(PROCESS)/coverage_by_category_and_time.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_coverage_by_category.Rmd", output_file="coverage_by_category.pdf")'


#generate supplmentary files
#Table S1
$(TAB)/environmental_categories_table.pdf : \
							doc/notebook/ClassificationCode.docx\
							$(TAB)/build_environmental_categories_table.Rmd\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_environmental_categories_table.Rmd", output_file="environmental_categories_table.pdf")'

#Table S2
$(TAB)/bacterial_category_phylum_table.pdf : \
							$(TAB)/build_bacterial_category_phylum_table.Rmd\
							$(PROCESS)/phylum_category_counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_bacterial_category_phylum_table.Rmd", output_file="bacterial_category_phylum_table.pdf")'

#Table S3
$(TAB)/archaeal_category_phylum_table.pdf : \
							$(TAB)/build_archaeal_category_phylum_table.Rmd\
							$(PROCESS)/phylum_category_counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_archaeal_category_phylum_table.Rmd", output_file="archaeal_category_phylum_table.pdf")'

#Table S4
$(TAB)/bacterial_phylum_effort_table.pdf : \
							$(TAB)/build_bacterial_phylum_effort_table.Rmd\
							$(PROCESS)/bacteria.phyla.counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_bacterial_phylum_effort_table.Rmd", output_file="bacterial_phylum_effort_table.pdf")'

#Table S5
$(TAB)/archaeal_phylum_effort_table.pdf : \
							$(TAB)/build_archaeal_phylum_effort_table.Rmd\
							$(PROCESS)/archaea.phyla.counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_archaeal_phylum_effort_table.Rmd", output_file="archaeal_phylum_effort_table.pdf")'

#Table S6
$(TAB)/bacterial_culture_effort_table.pdf :\
							$(TAB)/build_bacterial_culture_effort_table.Rmd\
							$(PROCESS)/bacteria.cultured_by_time_counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_bacterial_culture_effort_table.Rmd", output_file="bacterial_culture_effort_table.pdf")'

#Table S7
$(TAB)/archaeal_culture_effort_table.pdf :\
							$(TAB)/build_archaeal_culture_effort_table.Rmd\
							$(PROCESS)/archaea.cultured_by_time_counts.tsv\
							$(TAB)/table_header.tex
	R -e 'render("$(TAB)/build_archaeal_culture_effort_table.Rmd", output_file="archaeal_culture_effort_table.pdf")'


TABLES :	$(TAB)/coverage_by_category.pdf \
			$(TAB)/environmental_categories_table.pdf \
			$(TAB)/bacterial_category_phylum_table.pdf \
			$(TAB)/archaeal_category_phylum_table.pdf \
			$(TAB)/bacterial_phylum_effort_table.pdf \
			$(TAB)/archaeal_phylum_effort_table.pdf \
			$(TAB)/bacterial_culture_effort_table.pdf \
			$(TAB)/archaeal_culture_effort_table.pdf



submission/Schloss_Census2_mBio_2016.md : \
						FIGSHARE \
						SUMMARY_TABLES\
						FIGURES \
						TABLES \
						\
						submission/mbio.csl\
						submission/references.bib\
						submission/Schloss_Census2_mBio_2016.Rmd
	R -e 'render("submission/Schloss_Census2_mBio_2016.Rmd", clean=FALSE)'
	mv submission/Schloss_Census2_mBio_2016.knit.md submission/Schloss_Census2_mBio_2016.md
	rm submission/Schloss_Census2_mBio_2016.utf8.md

submission/Schloss_Census2_mBio_2016.pdf : submission/Schloss_Census2_mBio_2016.md

submission/Schloss_Census2_mBio_2016_w_table.pdf : submission/Schloss_Census2_mBio_2016.pdf submission/table_1.pdf
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=$@ $^


submission/table_1.pdf : $(TAB)/coverage_by_category.pdf
	cp $^ $@

submission/figure_1.eps : $(FIG)/domain_rarefaction.eps
	cp $^ $@

submission/figure_2.eps : $(FIG)/time_course_figure.eps
	cp $^ $@

submission/figure_3.eps : $(FIG)/phylum_effort.eps
	cp $^ $@

submission/figure_4.eps : $(FIG)/category_phylum_heatmap.eps
	cp $^ $@

submission/figure_5.eps :  $(FIG)/phylum_cultured.eps
	cp $^ $@

submission/figure_6.eps :  $(FIG)/otu_overlap_by_method.eps
	cp $^ $@

submission/table_s1.pdf : $(TAB)/environmental_categories_table.pdf
	cp $^ $@

submission/table_s2.pdf : $(TAB)/bacterial_phylum_effort_table.pdf
	cp $^ $@

submission/table_s3.pdf : $(TAB)/archaeal_phylum_effort_table.pdf
	cp $^ $@

submission/table_s4.pdf : $(TAB)/bacterial_category_phylum_table.pdf
	cp $^ $@

submission/table_s5.pdf : $(TAB)/archaeal_category_phylum_table.pdf
	cp $^ $@

submission/table_s6.pdf : $(TAB)/bacterial_culture_effort_table.pdf
	cp $^ $@

submission/table_s7.pdf : $(TAB)/archaeal_culture_effort_table.pdf
	cp $^ $@



write.paper :	submission/Schloss_Census2_mBio_2016.md\
				submission/Schloss_Census2_mBio_2016.tex\
				submission/Schloss_Census2_mBio_2016.pdf\
				submission/Schloss_Census2_mBio_2016_w_table.pdf\
				submission/table_1.pdf\
				submission/figure_1.eps\
				submission/figure_2.eps\
				submission/figure_3.eps\
				submission/figure_4.eps\
				submission/figure_5.eps\
				submission/figure_6.eps\
				submission/table_s1.pdf\
				submission/table_s2.pdf\
				submission/table_s3.pdf\
				submission/table_s4.pdf\
				submission/table_s5.pdf\
				submission/table_s6.pdf\
				submission/table_s7.pdf\
				$(NB)/Bacterial_data_acquisition.Rmd\
				$(NB)/Archaeal_data_acquisition.Rmd

submission/Schloss_Census2_mBio_2016.docx : submission/Schloss_Census2_mBio_2016.tex
	pandoc -s $< -o $@

submission/ResponseToReviewerComments.docx : submission/rebuttal.md
	pandoc $< -o $@


OPTS= --csl=submission/mbio.csl --filter pandoc-citeproc --include-in-header submission/header.tex --bibliography submission/references.bib
submission/TrackChanges.pdf : submission/Schloss_Census2_mBio_2016.tex
	git show 83f25b83db:Schloss_Census2_mBio_2016.md > orig.md
	pandoc orig.md -o orig.tex $(OPTS)
	latexdiff orig.tex submission/Schloss_Census2_mBio_2016.tex > diff.tex
	pdflatex diff
	mv diff.pdf submission/TrackChanges.pdf
	rm orig.* diff.*

