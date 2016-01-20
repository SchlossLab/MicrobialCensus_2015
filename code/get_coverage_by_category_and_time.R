# this script takes in the bacteria.v123.metadata and archaea.v123.metadata
# files from data/process/ and summarizes the number of sequences, sequence
# coverage, and OTU coverage for each environmental category and for both
# the bacteria and archaea.


cutoff <- 2006 #year of Sogin et al. PNAS paper introducing 454 sequencing

#extract the year from the date field of the database
get_year <- function(db){
	gsub("^(\\d\\d\\d\\d)-.*", "\\1", db$date)
}


#get the number of sequences for each category in the database (db)
get_category_count <- function(category, db){

	count <- NA

	if(category=="no_source"){
		count <- sum(is.na(db$category))
	} else if(category == "total"){
		count <- nrow(db)
	} else {
		count <- sum(db$category == category & !is.na(db$category))
	}
	return(count)
}


# get the number of OTUs for each category from a specified dataset (db)
get_sobs <- function(category, db){

	sobs <- NA

	if(category == "no_source"){
		sobs <- length(table(db[is.na(db$category), "otu"]))
	} else if(category == "total"){
		sobs <- length(table(db[, "otu"]))
	} else {
		sobs <- length(table(db[db$category==category, "otu"]))
	}
	return(sobs)
}


# get the sequence coverage (good's coverage) for each category from a
# specified dataset (db)
get_goods_coverage <- function(category, db){
	if(category=="no_source"){
		category_table <- table(db[is.na(db$category), "otu"])
	} else if(category == "total") {
		category_table <- table(db[, "otu"])
	} else {
		category_table <- table(db[db$category==category, "otu"])
	}

	singletons <- sum(category_table == 1)
	total_seqs <- sum(category_table)

	coverage <- NA
	if(total_seqs != 0){
		coverage <- 100*(1-singletons/total_seqs)
	}

	return(coverage)
}

# get the OTU coverage (schloss's coverage) for each category from a
# specified dataset (db)
get_schloss_coverage <- function(category, db){
	if(category=="no_source"){
		category_table <- table(db[is.na(db$category), "otu"])
	} else if(category == "total") {
		category_table <- table(db[, "otu"])
	} else {
		category_table <- table(db[db$category==category, "otu"])
	}

	singletons <- sum(category_table == 1)
	total_otus <- length(category_table)

	coverage <- NA
	if(total_otus != 0){
		coverage <- 100*(1-singletons/total_otus)
	}
	return(coverage)
}


summarize_category_data <- function(db){

	db_year <- get_year(db)

	db_pre <- db_year <= cutoff & !is.na(db_year)
	db_post <- db_year > cutoff & !is.na(db_year)


	db_count_pre <- sapply(abbreviation, get_category_count, db [db_pre,])
	db_sobs_pre <- sapply(abbreviation, get_sobs, db [db_pre,])
	db_good_coverage_pre <- sapply(abbreviation, get_goods_coverage, db [db_pre,])
	db_schloss_coverage_pre <- sapply(abbreviation, get_schloss_coverage, db [db_pre,])

	db_count_post <- sapply(abbreviation, get_category_count, db [db_post,])
	db_sobs_post <- sapply(abbreviation, get_sobs, db [db_post,])
	db_good_coverage_post <- sapply(abbreviation, get_goods_coverage, db [db_post,])
	db_schloss_coverage_post <- sapply(abbreviation, get_schloss_coverage, db [db_post,])

	db_count <- sapply(abbreviation, get_category_count, db )
	db_sobs <- sapply(abbreviation, get_sobs, db )
	db_good_coverage <- sapply(abbreviation, get_goods_coverage, db )
	db_schloss_coverage <- sapply(abbreviation, get_schloss_coverage, db )

	cbind(db_count_pre, db_sobs_pre, db_good_coverage_pre, db_schloss_coverage_pre, db_count_post, db_sobs_post, db_good_coverage_post, db_schloss_coverage_post, db_count, db_sobs, db_good_coverage, db_schloss_coverage)
}


abbreviation <- c("AE", "AQB", "AQBS", "AQF", "AQFS", "AQM", "AQMS", "AQH", "AQI", "AQO", "BD", "BF", "BI", "BP", "BO", "PR", "PS", "PO", "SA", "SD", "SP", "SO", "ZV", "ZA", "ZN",  "ZO", "OT", "no_source", "total")


bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)

bact_summary <- summarize_category_data(bact[bact$pcr | bact$cultured,])
colnames(bact_summary) <- gsub("db_", "bact_", colnames(bact_summary))


arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)

arch_summary <- summarize_category_data(arch[arch$pcr | arch$cultured,])
colnames(arch_summary) <- gsub("db_", "arch_", colnames(arch_summary))

composite <- cbind(bact_summary, arch_summary)
write.table(composite, file=paste0(PROJHOME, "/data/process/coverage_by_category_and_time.tsv"))
