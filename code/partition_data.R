is_cultured <- function(db){
	cultured <- (!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db)) & grepl("\\.", rownames(db)) & !is_single_cell(db) & !(is_emirge_pcr(db) | is_emirge_metag(db))

	cultured[rownames(db)=="AJ224540.MxeCultu"] <- FALSE
	cultured
}

is_pcr <- function(db){
	!((!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db))) & grepl("\\.", rownames(db)) & !(is_emirge_pcr(db) | is_emirge_metag(db))
}

is_single_cell <- function(db){
	(grepl("^[^.]*$", rownames(db)) | (db$publication_doi == "10.1038/nature12352" & !is.na(db$publication_doi))) & !(is_emirge_pcr(db) | is_emirge_metag(db))
}

is_emirge_pcr <- function(db){
	emirge_dois <- c("10.1186/2049-2618-2-1", "10.1371/journal.pone.0056018", "10.1371/journal.pone.0057819")

	db$publication_doi %in% emirge_dois
}

is_emirge_metag <- function(db){
	emirge_dois <- c("10.1126/science.1224041", "10.1186/gb-2011-12-5-r44", "10.3389/fmicb.2015.00277")

	db$publication_doi %in% emirge_dois
}

#	10.1126/science.1224041			99		genomes
#	10.1186/gb-2011-12-5-r44		4		genomes
#	10.3389/fmicb.2015.00277 		17		genomes
#	10.1186/2049-2618-2-1 			21447	PCR
#	10.1371/journal.pone.0056018	37386	PCR
#	10.1371/journal.pone.0057819	23		PCR
