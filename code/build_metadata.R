metadata_header <- c("bio_material", "clone", "clone_lib", "collected_by", "collection_date", "country", "culture_collection", "date", "description", "embl_class", "env_sample", "full_name", "host", "identified_by", "insdc", "isolate", "isolation_source", "journal", "lat_lon", "publication_doi", "pubmed_id", "strain", "sub_species", "submit_author", "submit_date", "title", "depth_slv", "habitat_slv", "category")

n_columns <- length(metadata_header)


build_metadata <- function(fasta_file, pub_date, publication_doi, category){


	fasta <- scan(fasta_file, sep='\n', what="", quiet=TRUE)

	seq_names <- fasta[grepl('>', fasta)]
	seq_names <- gsub('^>(\\S*).*', '\\1', seq_names)

	n_seqs <- length(seq_names)

	metadata <- data.frame(matrix(rep(NA, n_seqs * n_columns), nrow=n_seqs))
	colnames(metadata) <- metadata_header
	rownames(metadata) <- seq_names

	metadata$date <- pub_date
	metadata$publication_doi <- publication_doi
	metadata$category <- category

	metadata_file <- gsub('fasta', 'metadata', fasta_file)
	write.table(metadata, file=metadata_file, quote=F, sep='\t', col.names=F)
}
