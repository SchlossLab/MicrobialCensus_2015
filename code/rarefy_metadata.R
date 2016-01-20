rarefy <- function(data, breaks, n_partitions=20, n_iters=100){

	n_seqs <- length(data)

	sampling <- sample(data, n_seqs, replace=FALSE) #FALSE is the default

	collectors_curve <- function(){
		sapply(breaks, function(x){length(unique(sampling[1:x]))})
	}

	collectors <- replicate(n_iters, collectors_curve())
	rarefied <- apply(collectors, 1, mean)
	return(rarefied)
}


rarefy_by_coarse <- function(db_name, n_partitions=20, n_iters=100,
						threshold="X0.03"){

	db <- read.table(file=db_name, header=T, stringsAsFactors=FALSE)
	db <- db[(db$cultured | db$pcr) & !is.na(db$environment), c("environment", threshold)]

	env_counts <- table(db$environment)
	breaks <- round(seq(1, max(env_counts), length.out=n_partitions))
	breaks <- unique(unname(sort(c(breaks, env_counts))))

	environments <- names(env_counts)

	rarefied_data <- matrix(rep(NA, length(environments) * length(breaks)), nrow=length(breaks))
	colnames(rarefied_data) <- environments
	rownames(rarefied_data) <- breaks

	for(e in environments){
		env_otus <-db[db$environment == e,threshold]
		env_breaks <- breaks[breaks <= env_counts[e]]

		rarefied_data[as.character(env_breaks),e] <- rarefy(env_otus, env_breaks, n_iters)
	}

	output_name <- gsub("v123.metadata", "env_rarefaction.tsv", db_name)
	write.table(file=output_name, rarefied_data, quote=F, sep="\t")
}


rarefy_all <- function(db_name, n_partitions=20, n_iters=100,
						thresholds=c("X0.00", "X0.03", "X0.05", "X0.10", "X0.20")){

	db <- read.table(file=db_name, header=T, stringsAsFactors=FALSE)
	db <- db[db$cultured | db$pcr, thresholds]

	breaks <- round(seq(1, nrow(db), length.out=n_partitions))
	rarefied_data <- matrix(rep(0, n_partitions * length(thresholds)), nrow=n_partitions)
	colnames(rarefied_data) <- thresholds
	rownames(rarefied_data) <- breaks

	for(t in thresholds){
		rarefied_data[,t] <- rarefy(db[,t], breaks=breaks, n_iters)
	}

	output_name <- gsub("v123.metadata", "all_rarefaction.tsv", db_name)
	write.table(file=output_name, rarefied_data, quote=F, sep="\t")
}
