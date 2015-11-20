bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact_year_deposited <- gsub("^(\\d\\d\\d\\d)-.*", "\\1", bact$date)

bact$category[bact$category=="ZI" & !is.na(bact$category)] <- "ZA"


b_phylum_year <- table(bact_year_deposited, bact_phylum)
b_n_phylum_2015 <- ncol(b_phylum_year)
b_phylum_2006 <- b_phylum_year[rownames(b_phylum_year) %in% as.character(1983:2006),]
b_n_phylum_2006 <- sum(apply(b_phylum_2006, 2, sum) > 0) #how many phyla were there?
b_n_old_seqs <- sum(b_phylum_2006)						#how many seqs in 2006?
b_n_old_seqs_phyla <- apply(b_phylum_2006, 2, sum)		#how many sequences in each phyla?

b_phylum_new <- b_phylum_year[rownames(b_phylum_year) %in% as.character(2007:2014),]
b_n_new_seqs <- sum(b_phylum_new)						#how many sequences are there since 2006
b_n_new_seqs_phyla <- apply(b_phylum_new, 2, sum)		#how many sequences in each phyla since 2006?

enough <- (b_n_new_seqs_phyla + b_n_old_seqs_phyla) > 1000
phyla_ratio <- b_n_new_seqs_phyla/b_n_old_seqs_phyla
seq_ratio <- b_n_new_seqs/b_n_old_seqs

b_enough_ratio <- sort(phyla_ratio[enough]/seq_ratio)


arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch_year_deposited <- gsub("^(\\d\\d\\d\\d)-.*", "\\1", arch$date)

arch$category[arch$category=="BDBD" & !is.na(arch$category)] <- "BD"

a_phylum_year <- table(arch_year_deposited, arch_phylum)
a_n_phylum_2015 <- ncol(a_phylum_year)
a_phylum_2006 <- a_phylum_year[rownames(a_phylum_year) %in% as.character(1983:2006),]
a_n_phylum_2006 <- sum(apply(a_phylum_2006, 2, sum) > 0) #how many phyla were there?
a_n_old_seqs <- sum(a_phylum_2006)						#how many seqs in 2006?
a_n_old_seqs_phyla <- apply(a_phylum_2006, 2, sum)		#how many sequences in each phyla?

a_phylum_new <- a_phylum_year[rownames(a_phylum_year) %in% as.character(2007:2014),]
a_n_new_seqs <- sum(a_phylum_new)						#how many sequences are there since 2006
a_n_new_seqs_phyla <- apply(a_phylum_new, 2, sum)		#how many sequences in each phyla since 2006?

enough <- (a_n_new_seqs_phyla + a_n_old_seqs_phyla) > 1000
phyla_ratio <- a_n_new_seqs_phyla/a_n_old_seqs_phyla
seq_ratio <- a_n_new_seqs/a_n_old_seqs

a_enough_ratio <- sort(phyla_ratio[enough]/seq_ratio)
names(a_enough_ratio) <- gsub("Miscellaneous_Crenarchaeotic_Group", "Misc. Crenarchaeota", names(a_enough_ratio))

n_b_enough <- length(b_enough_ratio)
n_a_enough <- length(a_enough_ratio)
n_enough <- n_b_enough+n_a_enough

pdf(file="results/figures/phylum_effort.pdf", width=3.75, height=5)
	par(mar=c(5,10, 0.5, 0.5), cex=0.7)

	plot("", ylim=c(1,n_enough+1), xlim=c(0, max(c(a_enough_ratio, b_enough_ratio))), type="n", xlab="", ylab="", axes=F)

	abline(v=1, col="gray")
	abline(h=(n_a_enough+2):(n_b_enough+n_a_enough+1), lty=3, col="gray")
	abline(h=1:n_a_enough, lty=3, col="gray")

	points(x=b_enough_ratio, y=(n_a_enough+2):(n_b_enough+n_a_enough+1))
	points(x=a_enough_ratio, y=1:n_a_enough)
	box()

	axis(1)
	axis(2, at=c((n_a_enough+2):(n_b_enough+n_a_enough+1), 1:n_a_enough), label=c(names(b_enough_ratio), names(a_enough_ratio)), las=1, tick=F)

	title(xlab="Fold difference in sequencing\neffort before and after 2006", line=3.5)
dev.off()
