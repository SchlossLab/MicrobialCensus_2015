source("code/partition_data.R")

run_analysis <- function(ref, otus){
	ref_otus <- otus[[ref]]
	n_otus <- length(ref_otus)

	cultured <- sum(ref_otus %in% otus[["cultured"]])
	pcr <- sum(ref_otus %in% otus[["pcr"]])
	sc <- sum(ref_otus %in% otus[["sc"]])
	em_pcr <- sum(ref_otus %in% otus[["em_pcr"]])
	em_meta <- sum(ref_otus %in% otus[["em_meta"]])
	freq <- c(cultured=cultured, pcr=pcr, sc=sc, em_pcr=em_pcr, em_meta=em_meta)
	freq[ref] <- sum(!ref_otus %in% unique(unlist(otus[ !names(otus) %in% ref])))

	if(n_otus != 0){
		percentage <- 100 * freq / n_otus
	} else {
		percentage <- c(cultured=NA, pcr=NA, sc=NA, em_pcr=NA, em_meta=NA)
	}

}


compare_methods <- function(db){
	cultured <- is_cultured(db)
	cultured_otus <- unique(db[cultured, "otu"])

	pcr <- (is_pcr(db))
	pcr_otus <- unique(db[pcr, "otu"])

	sc <- is_single_cell(db)
	sc_otus <- unique(db[sc, "otu"])

	em_pcr <- is_emirge_pcr(db)
	em_pcr_otus <- unique(db[em_pcr, "otu"])

	em_meta <- is_emirge_metag(db)
	em_meta_otus <- unique(db[em_meta, "otu"])

	total_otus <- length(unique(db$otu))

	n_cult_otus <- length(cultured_otus)
	n_pcr_otus <- length(pcr_otus)
	n_sc_otus <- length(sc_otus)
	n_em_pcr_otus <- length(em_pcr_otus)
	n_em_meta_otus <- length(em_meta_otus)

	otu_list <- list(cultured=cultured_otus, pcr=pcr_otus, sc=sc_otus,
					em_pcr=em_pcr_otus, em_meta=em_meta_otus)

	percentages <- t(sapply(names(otu_list), run_analysis, otus=otu_list))
	n_seqs <- c(cultured=sum(cultured), pcr=sum(pcr), sc=sum(sc),
					em_pcr=sum(em_pcr), em_meta=sum(em_meta))
	n_otus <- c(cultured=length(cultured_otus), pcr=length(pcr_otus),
				sc=length(sc_otus), em_pcr=length(em_pcr_otus),
 				em_meta=length(em_meta_otus))
	cbind(percentages, n_seqs, n_otus)
}

bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
b_overlap <- compare_methods(bact)
b_overlap <- cbind(domain="bacteria", method=rownames(b_overlap), b_overlap)

arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
a_overlap <- compare_methods(arch)
a_overlap <- cbind(domain="archaea", method=rownames(a_overlap), a_overlap)

write.table(rbind(b_overlap, a_overlap), "data/process/otu_overlap_by_method.tsv", quote=F, sep='\t', row.names=F)
