is_cultured <- function(db){
	(!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db)) & grepl("\\.", rownames(db))
}

is_pcr <- function(db){
	!((!is.na(db$strain) | !is.na(db$isolate)) & !grepl("\\.Unc", rownames(db))) & grepl("\\.", rownames(db))
}

is_single_cell <- function(db){
	grepl("^[^.]*$", rownames(db)) | db$publication_doi == "10.1038/nature12352"
}


get_data <- function(db){
	cultured <- is_cultured(db)
	cultured_otus <- unique(db[cultured, "otu"])

	pcrd <- is_pcr(db)
	pcr_otus <- unique(db[pcrd, "otu"])

	sc <- is_single_cell(db)
	sc_otus <- unique(db[sc, "otu"])


	total_otus <- max(db$otu)	#Total OTUs

	n_cult_otus <- length(cultured_otus) #Cultured OTUs	1
	n_pcr_otus <- length(pcr_otus) #PCR OTUs				2
	n_sc_otus <- length(sc_otus) #Single cell OTUs		3

	n_cult_only <- sum(!cultured_otus %in% union(pcr_otus, sc_otus))
	n_pcr_only <- sum(!pcr_otus %in% union(cultured_otus, sc_otus))
	n_sc_only <- sum(!sc_otus %in% union(pcr_otus, cultured_otus))

	n_cult_pcr_otus <- sum(cultured_otus %in% pcr_otus)	#cult-pcr		12
	n_cult_sc_otus <- sum(cultured_otus %in% sc_otus)	#cult-single	13
	n_pcr_sc_otus <- sum(pcr_otus %in% sc_otus)			#pcr-single		23
	n_three_otus <- length(intersect(intersect(cultured_otus, sc_otus), pcr_otus)) #cult-pcr-single

	c("n_cult"=sum(cultured, na.rm=T),
	"n_pcr"=sum(pcrd, na.rm=T),
	"n_sc"=sum(sc, na.rm=T),
	"cult_all"=n_cult_otus,
	"pcr_all"=n_pcr_otus,
	"sc_all"=n_sc_otus,
	"cult_only"=n_cult_only,
	"pcr_only"=n_pcr_only,
	"sc_only"=n_sc_only,
	"cult-pcr"=n_cult_pcr_otus,
	"cult-sc"=n_cult_sc_otus,
	"pcr-sc"=n_pcr_sc_otus,
	"cult-pcr-sc"=n_three_otus,
	"total"=total_otus)
}





bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact_counts <- get_data(bact)

arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch_counts <- get_data(arch)

write.table(cbind(bact_counts, arch_counts), "data/process/otu_overlap_by_method.tsv", quote=F, sep='\t')
