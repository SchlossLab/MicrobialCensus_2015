is_cultured <- function(db){
	cultured <- (!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db)) & grepl("\\.", rownames(db)) & !is_single_cell(db) & !(is_emirge_pcr(db) | is_emirge_metag(db))

	cultured[rownames(db)=="AJ224540.MxeCultu"] <- FALSE
	cultured
}

is_pcr <- function(db){
	pcr <- !((!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db))) & grepl("\\.", rownames(db)) & !(is_emirge_pcr(db) | is_emirge_metag(db))

	pcr[rownames(db)=="AJ224540.MxeCultu"] <- TRUE
	pcr
}

is_single_cell <- function(db){
	(grepl("^[^.]*$", rownames(db)) | (db$publication_doi == "10.1038/nature12352" & !is.na(db$publication_doi))) & !(is_emirge_pcr(db) | is_emirge_metag(db))
}

is_emirge_pcr <- function(db){
	emirge_dois <- c("10.1186/2049-2618-2-1", "10.1371/journal.pone.0056018", "10.1371/journal.pone.0057819")
	is_emirge_doi <- db$publication_doi %in% emirge_dois


	gb <- gsub("^(.*)\\..*", "\\1", rownames(metdata))
	search <- c(paste0("KC", 716084:731398), paste0("JX", 221725:226064))
	is_emirge_gb <- gb %in% search

	is_emirge_doi | is_emirge_gb
}

is_emirge_metag <- function(db){
	emirge_dois <- c("10.1126/science.1224041", "10.1186/gb-2011-12-5-r44", "10.3389/fmicb.2015.00277, 10.1128/AEM.00032-11")
	is_emirge_doi <- db$publication_doi %in% emirge_dois

	gb <- gsub("^(.*)\\..*", "\\1", rownames(db))
	search <- c(paste0("KM", 410305:410928), paste0("JX", 125436:125454))
	is_emirge_gb <- gb %in% search

	is_emirge_doi | is_emirge_gb
}

#	10.1126/science.1224041			99		genomes
#	10.1186/gb-2011-12-5-r44		4		genomes
#	10.3389/fmicb.2015.00277 		17		genomes
#	10.1128/AEM.00032-11			21		genomes
#	10.3389/fmicb.2014.00756		479		genomes	need to search: KM410305-KM410928
#	10.1038/ismej.2012.148			~19	 	genomes need to search: JX125436–JX125454

#	10.1186/2049-2618-2-1 			21447	PCR
#	10.1371/journal.pone.0056018	37386	PCR
#	10.1371/journal.pone.0057819	23		PCR
#	10.1111/1462-2920.12467			15315	PCR		need to search: KC716084-KC731398
#	10.1021/es502701u				1909	PCR		need to search: JX221725-JX226064
