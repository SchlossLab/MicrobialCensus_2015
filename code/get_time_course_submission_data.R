first_year <- 1983
final_year  <- 2015

get_year <- function(date_vector){
	gsub("^(\\d\\d\\d\\d)-.*", "\\1", date_vector)
}


bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact <- bact[bact$pcr | bact$cultured,]

bact_year_deposited <- get_year(bact$date)

arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch <- arch[arch$pcr | arch$cultured,]

arch_year_deposited <- get_year(arch$date)

summary_table <- data.frame(matrix(rep(0, (final_year-first_year+1)*10), ncol=10))
rownames(summary_table) <- first_year:final_year
colnames(summary_table) <- c('b_nseqs', 'b_sobs', 'b_n50', 'b_n50_doi', 'b_n50_nseqs',
							'a_nseqs', 'a_sobs', 'a_n50', 'a_n50_doi', 'a_n50_nseqs')


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

bact_data <- get_annual_otu_deposits(bact_year_deposited, bact[,"X0.03"])
summary_table[names(bact_data),'b_sobs'] <- bact_data

arch_data <- get_annual_otu_deposits(arch_year_deposited, arch[,"X0.03"])
summary_table[names(arch_data),'a_sobs'] <- arch_data


get_n50_data <- function(year, year_vector, db, fraction=0.50){

	year_db <- db[year_vector==as.character(year) & !is.na(year_vector),]
	dummy_variable <- paste(year_db$submit_author, year_db$pubmed_id, sep='_')
	cumsum_count <- cumsum(sort(table(dummy_variable), decreasing=T))
	cumsum_fraction <- cumsum_count/length(dummy_variable)

	count <- unname(which.max(cumsum_fraction>=fraction))

	if(length(count) == 0){
		list(count=0, names="NA", nseqs=0)
	} else {
		list(count=count, names=paste(names(cumsum_count)[1:count], collapse='|'), nseqs=unname(cumsum_count[count]))
	}


}

get_pubmed_id <- function(author_id){
	by_year <- strsplit(author_id, split="[|]")
	unlist(lapply(by_year, function(x){paste(gsub(".*_", "", x), collapse=',')}))
}


bact_data <- sapply(first_year:final_year, get_n50_data, bact_year_deposited, bact)
summary_table[ ,'b_n50'] <- unlist(bact_data["count",])
summary_table[ ,'b_n50_doi'] <- get_pubmed_id(unlist(bact_data["names",]))
summary_table[ ,'b_n50_nseqs'] <- unlist(bact_data["nseqs",])

arch_data <- sapply(first_year:final_year, get_n50_data, arch_year_deposited, arch)
summary_table[ ,'a_n50'] <- unlist(arch_data["count",])
summary_table[ ,'a_n50_doi'] <- get_pubmed_id(unlist(arch_data["names",]))
summary_table[ ,'a_n50_nseqs'] <- unlist(arch_data["nseqs",])

write.table(summary_table, file="data/process/by_year_analysis.tsv", quote=F, sep='\t')
