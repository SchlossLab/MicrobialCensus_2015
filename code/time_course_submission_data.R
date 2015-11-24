first_year <- 1983
final_year  <- 2015

get_year <- function(date_vector){
	gsub("^(\\d\\d\\d\\d)-.*", "\\1", date_vector)
}


bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact_year_deposited <- get_year(bact$date)

arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch_year_deposited <- get_year(arch$date)

summary_table <- data.frame(matrix(rep(0, (final_year-first_year+1)*8), ncol=8))
rownames(summary_table) <- first_year:final_year
colnames(summary_table) <- c('b_nseqs', 'b_sobs', 'b_n50', 'b_n50_doi',
							'a_nseqs', 'a_sobs', 'a_n50', 'a_n50_doi')


get_annual_seq_deposits <- function(year_vector){
	deposits_by_year <- as.numeric(table(year_vector))
	names(deposits_by_year) <- levels(factor(year_vector))
	deposits_by_year
}

bact_data <- get_annual_seq_deposits(bact_year_deposited)
summary_table[names(bact_data),'b_nseqs'] <- bact_data

arch_data <- get_annual_seq_deposits(arch_year_deposited)
summary_table[names(arch_data),'a_nseqs'] <- arch_data



get_annual_otu_deposits <- function(year_deposited, otus){

	#make a table to indicate the years each OTU appeared
	otus_table <- table(otus, year_deposited)

	#make a vector to indicate the first year each OTU appeared
	otu_appearance <- rep("", nrow(otus_table))
	names(otu_appearance) <- as.character(1:length(otu_appearance))

	#get the first year that each OTU appeared
	otu_appearance <- colnames(otus_table)[apply(otus_table != 0, 1, function(x){ifelse(sum(x) == 0, NA, which.max(x))})]

	#count the number of new OTUs in each year
	new_otus_table <- table(otu_appearance)
	new_otus_by_year <- as.numeric(new_otus_table)
	names(new_otus_by_year) <- names(new_otus_table)
	new_otus_by_year
}

bact_data <- get_annual_otu_deposits(bact_year_deposited, bact$otu)
summary_table[names(bact_data),'b_sobs'] <- bact_data

arch_data <- get_annual_otu_deposits(arch_year_deposited, arch$otu)
summary_table[names(arch_data),'a_sobs'] <- arch_data


how_many <- function(year, year_vector, db, fraction=0.50){

	year_db <- db[year_vector==as.character(year) & !is.na(year_vector),]
	dummy_variable <- paste(year_db$submit_author, year_db$pubmed_id, sep='_')
	ranked_order <- cumsum(sort(table(dummy_variable), decreasing=T))/length(dummy_variable)

	count <- unname(which.max(ranked_order>=fraction))

	if(length(count) == 0){
		count <- 0
		names(count) <- "NA"
	} else {
		names(count) <- paste(names(ranked_order)[1:count], collapse='|')
	}
	count

}

get_pubmed_id <- function(author_id){
	by_year <- strsplit(author_id, split="[|]")
	unlist(lapply(by_year, function(x){paste(gsub(".*_", "", x), collapse=',')}))
}


bact_data <- sapply(first_year:final_year, how_many, bact_year_deposited, bact)
summary_table[ ,'b_n50'] <- bact_data
summary_table[ ,'b_n50_doi'] <- get_pubmed_id(names(bact_data))


arch_data <- sapply(first_year:final_year, how_many, arch_year_deposited, arch)
summary_table[ ,'a_n50'] <- arch_data
summary_table[ ,'a_n50_doi'] <- get_pubmed_id(names(arch_data))

write.table(summary_table, file="data/process/by_year_analysis.tsv", quote=F, sep='\t')
