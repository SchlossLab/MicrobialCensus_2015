require("plotrix")

pds_venn <- function(A, B, C, AB, AC, BC, ABC, categories,
	cir.lwd = 2
){

	par(mar=c(1,2,3,2), cex=0.7)
	plot(NA, xlim=c(0,1), ylim=c(0,1), axes=F, xlab="", ylab="")

	radius <- 0.325
	draw.circle(radius, 1-radius, radius, lwd=cir.lwd)	#A
	draw.circle(1-radius, 1-radius, radius, lwd=cir.lwd)	#B
	draw.circle(0.5, radius, radius, lwd=cir.lwd)	#C

	n_ABC <- ABC
	n_A <- A - AB - AC + n_ABC
	n_B <- B - AB - BC + n_ABC
	n_C <- C - AC - BC + n_ABC

	n_AB <- AB - n_ABC
	n_AC <- AC - n_ABC
	n_BC <- BC - n_ABC

	text(x=0.2, y=0.7, format(n_A, big.mark=','))
	text(x=0.8, y=0.7, format(n_B, big.mark=','))
	text(x=0.5, y=0.2, format(n_C, big.mark=','))

	text(x=0.3, y=0.43, format(n_AC, big.mark=','))
	text(x=0.7, y=0.43, format(n_BC, big.mark=','))
	text(x=0.5, y=0.75, format(n_AB, big.mark=','))

	text(x=0.5, y=0.56, format(n_ABC, big.mark=','), pos=1)

	text(x=-0.025, y=1.025, categories[1], font=2, adj=0, xpd=T)
	text(x=1.025, y=1.025, categories[2], font=2, adj=1, xpd=T)
	text(x=0.5, y=0, categories[3], font=2, pos=1, xpd=T)

}


get_category_names <- function(counts){
		c(paste0("Cultured (N=", format(counts[1], big.mark=','), ")"),
			paste0("PCR (N=", format(counts[2], big.mark=','), ")"),
			paste0("Single cell (N=", format(counts[3], big.mark=','), ")"))
}


count_data <- read.table(file='data/process/otu_overlap_by_method.tsv', header=T)


pdf(file="results/figures/venn_otu_by_method.pdf", width=3.75, height=7.5)
layout(matrix(c(1,2), nrow=2), height=c(1,1), width=1)

bact_cats <- get_category_names(count_data[c("cult_all", "pcr_all", "sc_all"), "bact_counts"])

pds_venn(	A=count_data["cult_all","bact_counts"],
			B=count_data["pcr_all","bact_counts"],
			C=count_data["sc_all","bact_counts"],
			AB=count_data["cult-pcr","bact_counts"],
			BC=count_data["pcr-sc","bact_counts"],
			AC=count_data["cult-sc","bact_counts"],
			ABC=count_data["cult-pcr-sc","bact_counts"],
			categories=bact_cats
		)
text(x=-0.025, y=1.1, label="Bacteria", xpd=T, cex=1.5, font=2, adj=0)

arch_cats <- get_category_names(count_data[c("cult_all", "pcr_all", "sc_all"), "arch_counts"])

pds_venn(	A=count_data["cult_all","arch_counts"],
			B=count_data["pcr_all","arch_counts"],
			C=count_data["sc_all","arch_counts"],
			AB=count_data["cult-pcr","arch_counts"],
			BC=count_data["pcr-sc","arch_counts"],
			AC=count_data["cult-sc","arch_counts"],
			ABC=count_data["cult-pcr-sc","arch_counts"],
			categories=arch_cats
		)
text(x=-0.025, y=1.1, label="Archaea", xpd=T, cex=1.5, font=2, adj=0)

dev.off()
