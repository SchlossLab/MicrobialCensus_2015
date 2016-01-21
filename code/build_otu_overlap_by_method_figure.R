#devtools::install_github("karthik/wesanderson")
library("wesanderson")

palette <- "Darjeeling2"

plot_overlap <- function(domain){

	par(mar=c(0.5, 3,0.5,0.5))
	d_overlap <- overlap[overlap$domain==domain,-1]
	rownames(d_overlap) <- d_overlap$method
	d_overlap <- d_overlap[,-1]


	d_subset <- d_overlap[c("sc", "em_pcr", "em_meta"), c("cultured", "pcr", "sc", "em_pcr", "em_meta")]

	barplot(t(as.matrix(d_subset)), beside=T, ylim=c(0,105), axes=F, ylab="", names.arg=c("","",""), col=wes_palette(palette))
	axis(2, las=2)
	box()
	text(x=17, y=100, gsub("^(.)", "\\U\\1", domain, perl=TRUE), cex=1.5, font=2)
}


overlap <- read.table(file="data/process/otu_overlap_by_method.tsv", header=T)


pdf(file="results/figures/otu_overlap_by_method.pdf", width=6.0, height=5.0)

layout(matrix(c(3,1,3,2,0,4), nrow=3, byrow=T), widths=c(0.1,1), heights=c(1, 1, 0.18))
plot_overlap("bacteria")
plot_overlap("archaea")

legend(x=5, y=80, legend=c("Cultured", "PCR", "Single Cell", "EMIRGE (PCR)", "EMIRGE (Metagenome)"), fill=wes_palette(palette))

plot.new()
par(mar=c(0,0,0,0))
text(x=0.3,y=0.5, "Overlap of Each Method's OTUs with Other Methods (%)", srt=90, cex=1.5)

par(mar=c(0,0,0,0))
plot(NA, xlim=c(0,19), ylim=c(0,1), type="n", axes=F, xpd=T)
text(x=3.8,y=0.6, "Single Cell", cex=1.4, xpd=T)
text(x=10.0,y=0.6, "EMIRGE\n(PCR)", cex=1.4, xpd=T)
text(x=16.3,y=0.6, "EMIRGE\n(Metagenome)", cex=1.4, xpd=T)

dev.off()
