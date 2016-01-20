get_phylum <- function(taxonomy){
	phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", taxonomy)
	phylum[grepl(';', phylum)] <- "Unclassified"
	phylum <- gsub("_?\\(.*\\)", "", phylum)
	phylum
}

get_cultured_data <- function(cultured, phyla, otu){
	nseqs <- table(phyla, cultured)
	nseqs <- cbind(cult_nseqs=nseqs[,"TRUE"], total_nseqs=apply(nseqs, 1, sum))

	sobs <- apply(table(phyla, otu) > 0, 1, sum)
	sobs_cultured <- apply(table(phyla[cultured], otu[cultured]) > 0, 1, sum)
	sobs <- cbind(cult_sobs=sobs_cultured, total_sobs=sobs)

	cbind(nseqs, sobs)
}

get_domain_data <- function(db, threshold=2006){

	phyla <- factor(get_phylum(db$taxonomy))
	cultured <- db$cultured

	pre <- get_year(db$date) < threshold

	all <- get_cultured_data(cultured, phyla, db$otu)
	pre <- get_cultured_data(cultured[pre], phyla[pre], db$otu[pre])
	post <- get_cultured_data(cultured[!pre], phyla[!pre], db$otu[!pre])
	pool <- cbind(pre, post, all)
	colnames(pool) <- paste0(c(rep("pre_", 3), rep("post_", 3), rep("all_", 3)), colnames(pool))
	pool
}


run_domain <- function(domain){
	metadata_file <- paste0('data/process/', domain, '.v123.metadata')
	output_file <- paste0('data/process/', domain, '.cultured_by_time_counts.tsv')

	domain_data <- read.table(file=metadata_file, header=T, row.names=1, stringsAsFactors=FALSE)
	domain_data <- get_domain_data(domain_data[domain_data$pcr | domain_data$cultured,])
	write.table(domain_data, file=output_file, sep='\t', quote=FALSE)
}
