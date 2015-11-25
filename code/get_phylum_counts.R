threshold <- 2006

get_year <- function(date){
	gsub("^(\\d\\d\\d\\d)-.*", "\\1", date)
}

get_phylum <- function(taxonomy){
	phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", taxonomy)
	phylum[grepl(';', phylum)] <- 'Unclassified'
	phylum
}

summarize_phylum_data <- function(db){
	year_deposited <- get_year(db$date)
	phylum <- get_phylum(db$taxonomy)

	years <- as.numeric(levels(factor(year_deposited)))
	pre <- years <= threshold
	post <- years > threshold

	phylum_year <- table(year_deposited, phylum)
	pre <- apply(phylum_year[pre,], 2, sum)
	post <- apply(phylum_year[post,], 2, sum)
	all <- apply(phylum_year, 2, sum)
	cbind(pre, post, all)
}

generate_table <- function(domain){
	metadata_file <- paste0('data/process/', domain, '.v123.metadata')
	count_file <- paste0('data/process/', domain, '.phyla.counts.tsv')

	input <- read.table(file=metadata_file, header=T, row.names=1, stringsAsFactors=FALSE)
	write.table(summarize_phylum_data(input), file=count_file, quote=FALSE, sep='\t')
}
