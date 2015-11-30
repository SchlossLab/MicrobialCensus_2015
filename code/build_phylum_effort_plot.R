count_threshold <- 1000

bacteria <- read.table(file="data/process/bacteria.phyla.counts.tsv", header=T)
archaea <- read.table(file="data/process/archaea.phyla.counts.tsv", header=T)

enough <- bacteria$all >= count_threshold
bact_ratios <- log2(bacteria$ratio_of_ratios[enough])
names(bact_ratios) <- gsub("_\\(SAR406_clade\\)", "", rownames(bacteria)[enough])

bact_ratios <- sort(bact_ratios)
n_bact_ratios <- length(bact_ratios)


enough <- archaea$all >= count_threshold
arch_ratios <- log2(archaea$ratio_of_ratios[enough])
names(arch_ratios) <- gsub("Miscellaneous_Crenarchaeotic_Group", "Misc. Crenarchaeota", rownames(archaea)[enough])

arch_ratios <- sort(arch_ratios)
n_arch_ratios <- length(arch_ratios)

pdf(file="results/figures/phylum_effort.pdf", width=3.75, height=5)
	par(mar=c(5,10, 1.0, 0.5), cex=0.7)

	plot("", ylim=c(1,n_bact_ratios+n_arch_ratios+2), xlim=c(-3,4), type="n", xlab="", ylab="", axes=F)

	abline(v=0, col="gray")
	abline(h=(n_arch_ratios+3):(n_bact_ratios+n_arch_ratios+2), lty=3, col="gray")
	abline(h=1:n_arch_ratios, lty=3, col="gray")

	points(x=bact_ratios, y=(n_arch_ratios+3):(n_bact_ratios+n_arch_ratios+2))
	points(x=arch_ratios, y=1:n_arch_ratios)
	box()

	axis(1, at=-3:4, label=-3:4)
	axis(2, at=c((n_arch_ratios+3):(n_bact_ratios+n_arch_ratios+2), 1:n_arch_ratios), label=c(names(bact_ratios), names(arch_ratios)), las=1, tick=F)

	mtext("Bacteria", side=2, line=5, at=n_bact_ratios+n_arch_ratios+3.2, las=1, font=2, cex=0.8)
	mtext("Archaea", side=2, line=5, at=n_arch_ratios+1.2, las=1, font=2, cex=0.8)

	title(xlab="Fold difference in sequencing effort\nbefore and after 2006 (log2 scale)", line=3.5)
dev.off()
