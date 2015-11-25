

get_year <- function(date){
	gsub("^(\\d\\d\\d\\d)-.*", "\\1", date)
}

get_phylum <- function(taxonomy){
	phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", taxonomy)
	phylum[grepl(';', phylum)] <- 'Unclassified'
	phylum
}

get_ratio_of_ratios <- function(pre, post){
	phyla_ratio <- post/pre
	seq_ratio <- sum(post)/sum(pre)
	phyla_ratio / seq_ratio
}

summarize_phylum_data <- function(db, threshold){
	year_deposited <- get_year(db$date)
	phylum <- get_phylum(db$taxonomy)

	years <- as.numeric(levels(factor(year_deposited)))
	pre_years <- years <= threshold
	post_years <- years > threshold

	phylum_year <- table(year_deposited, phylum)
	pre <- apply(phylum_year[pre_years,], 2, sum)
	post <- apply(phylum_year[post_years,], 2, sum)
	all <- apply(phylum_year, 2, sum)
	ratio_of_ratios <- get_ratio_of_ratios(pre, post)
	cbind(pre, post, all, ratio_of_ratios)
}

generate_table <- function(domain, threhold=2006){
	metadata_file <- paste0('data/process/', domain, '.v123.metadata')
	count_file <- paste0('data/process/', domain, '.phyla.counts.tsv')

	input <- read.table(file=metadata_file, header=T, row.names=1, stringsAsFactors=FALSE)
	write.table(summarize_phylum_data(input, threshold), file=count_file, quote=FALSE, sep='\t')
}
