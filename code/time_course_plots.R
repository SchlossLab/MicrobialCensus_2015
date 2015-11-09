year_of_analysis <- "2015"

bact <- read.table(file='data/mothur/bacteria.final.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact_year_deposited <- gsub("^(\\d\\d\\d\\d)-.*", "\\1", bact$date)

arch <- read.table(file='data/mothur/archaea.final.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch_year_deposited <- gsub("^(\\d\\d\\d\\d)-.*", "\\1", arch$date)


pdf(file="results/figures/sequences_deposited.pdf")
	deposits_table <- table(bact_year_deposited)
	bact_deposits_by_year <- as.numeric(deposits_table)
	names(bact_deposits_by_year) <- names(deposits_table)
	bact_deposits_by_year <- bact_deposits_by_year[!(names(bact_deposits_by_year) %in% year_of_analysis)]

	plot(bact_deposits_by_year~as.numeric(names(bact_deposits_by_year)), log='y', type="l", col="blue", lwd=2, xlab="Year", ylab="Number of sequences per year", ylim=c(1,1e6), xlim=c(1980, 2015), axes=F)

	deposits_table <- table(arch_year_deposited)
	arch_deposits_by_year <- as.numeric(deposits_table)
	names(arch_deposits_by_year) <- names(deposits_table)
	arch_deposits_by_year <- arch_deposits_by_year[!(names(arch_deposits_by_year) %in% year_of_analysis)]

	points(arch_deposits_by_year~as.numeric(names(arch_deposits_by_year)), type="l", col="red", lwd=2)
	axis(1)
	axis(2, at=c(1,10,1e2,1e3,1e4,1e5,1e6), labels=parse(text=paste("10^", 0:6)), las=1)
	box()
	legend(x=2003, y=100, legend=c("Bacteria", "Archaea"), col=c("blue", "red"), lty=1, lwd=2)
dev.off()


pdf(file="results/figures/otus_deposited.pdf")
	bact_otus_table <- table(bact$otu, bact_year_deposited)
	bact_otu_appearance <- rep("", nrow(bact_otus_table))
	names(bact_otu_appearance) <- as.character(1:length(bact_otu_appearance))

	bact_otu_appearance <- colnames(bact_otus_table)[apply(bact_otus_table != 0, 1, function(x){ifelse(sum(x) == 0, NA, which.max(x))})]

	new_bact_otus_table <- table(bact_otu_appearance)
	new_bact_otus_by_year <- as.numeric(new_bact_otus_table)
	names(new_bact_otus_by_year) <- names(new_bact_otus_table)
	new_bact_otus_by_year <- new_bact_otus_by_year[!(names(new_bact_otus_by_year) %in% c("2015"))]

	plot(new_bact_otus_by_year~as.numeric(names(new_bact_otus_by_year)), log='y', type="l", lwd=2, col="blue", xlab="Year", ylab="Number of new OTUs per year", ylim=c(1,20000), xlim=c(1980, 2015), axes=F)


	arch_otus_table <- table(arch$otu, arch_year_deposited)
	arch_otu_appearance <- rep("", nrow(arch_otus_table))
	names(arch_otu_appearance) <- as.character(1:length(arch_otu_appearance))

	arch_otu_appearance <- colnames(arch_otus_table)[apply(arch_otus_table != 0, 1, function(x){ifelse(sum(x) == 0, NA, which.max(x))})]

	new_arch_otus_table <- table(arch_otu_appearance)
	new_arch_otus_by_year <- as.numeric(new_arch_otus_table)
	names(new_arch_otus_by_year) <- names(new_arch_otus_table)
	new_arch_otus_by_year <- new_arch_otus_by_year[!(names(new_arch_otus_by_year) %in% c("2015"))]

	points(new_arch_otus_by_year~as.numeric(names(new_arch_otus_by_year)), type="l", col="red", lwd=2)
	axis(1)
	axis(2, at=c(1,10,1e2,1e3,1e4), labels=parse(text=paste("10^", 0:4)), las=1)
	box()
	legend(x=2005, y=100, legend=c("Bacteria", "Archaea"), col=c("blue", "red"), lty=1, lwd=2)
dev.off()


pdf(file="results/figures/phyla_deposited.pdf")
	bact_phylum_appear <- table(gsub("^([^;]*;[^;]*);.*", "\\1", bact$taxonomy), bact_year_deposited) > 0

	bact_phylum_first_appear <- colnames(bact_phylum_appear)[apply(bact_phylum_appear, 1, which.max)]
	names(bact_phylum_first_appear) <- rownames(bact_phylum_appear)
	date_bact_phylum_first_appear <- table(bact_phylum_first_appear)

	arch_phylum_appear <- table(gsub("^([^;]*;[^;]*);.*", "\\1", arch$taxonomy), arch_year_deposited) > 0
	arch_phylum_first_appear <- colnames(arch_phylum_appear)[apply(arch_phylum_appear, 1, which.max)]
	names(arch_phylum_first_appear) <- rownames(arch_phylum_appear)
	date_arch_phylum_first_appear <- table(arch_phylum_first_appear)

	spacing <- 0.1
	plot(as.numeric(names(date_bact_phylum_first_appear))-spacing, date_bact_phylum_first_appear, type="h", lwd=2, col="blue", xlab="Year", ylab="Number of new phyla per year", ylim=c(1,20), xlim=c(1980, 2015), axes=F)

	points(as.numeric(names(date_arch_phylum_first_appear))+spacing, date_arch_phylum_first_appear, type="h", col="red", lwd=2)

	axis(1)
	axis(2, at=seq(0,20,5), labels=seq(0,20,5), las=1)
	box()
	legend(x=2005, y=10, legend=c("Bacteria", "Archaea"), col=c("blue", "red"), lty=1, lwd=2)
dev.off()


pdf("results/figures/fifty_authors_deposited.pdf")
	bact_how_many <- function(year, fraction=0.50){
		unname(which.max(cumsum(sort(table(bact[bact_year_deposited==year,"submit_author"]), decreasing=T))/length(bact[bact_year_deposited==year,"submit_author"])>=fraction))
	}

	bact_fifty <- unlist(sapply(levels(factor(bact_year_deposited)), bact_how_many))
	bact_fifty <- bact_fifty[!(names(bact_fifty) %in% c("2015"))]

	plot(bact_fifty~as.numeric(names(bact_fifty)), type="l", lwd=2, xlab="Year", ylab="Number of studies accounting for 50% of sequences deposited", xlim=c(1980, 2015), col="blue", axes=F)

	arch_how_many <- function(year, fraction=0.50){
		unname(which.max(cumsum(sort(table(arch[arch_year_deposited==year,"submit_author"]), decreasing=T))/length(arch[arch_year_deposited==year,"submit_author"])>=fraction))
	}

	arch_fifty <- unlist(sapply(levels(factor(arch_year_deposited)), arch_how_many))
	arch_fifty <- arch_fifty[!(names(arch_fifty) %in% c("2015"))]
	points(arch_fifty~as.numeric(names(arch_fifty)), type="l", lwd=2, col="red")

	axis(1)
	axis(2, las=1)
	box()
	legend(x=2007, y=60, legend=c("Bacteria", "Archaea"), col=c("blue", "red"), lty=1, lwd=2)
dev.off()
