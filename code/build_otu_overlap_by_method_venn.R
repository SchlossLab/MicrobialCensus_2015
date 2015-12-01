require("VennDiagram")

get_category_names <- function(counts){
		c(paste0("Cultured (N=", format(counts[1], big.mark=','), ")"),
			paste0("PCR (N=", format(counts[2], big.mark=','), ")"),
			paste0("Single cell (N=", format(counts[3], big.mark=','), ")"))
}

count_data <- read.table(file='data/process/otu_overlap_by_method.tsv', header=T)


pdf(file="results/figures/venn_otu_by_method.pdf")

layout(matrix(c(1,2), nrow=2), height=c(1,1), width=1)

bact_cats <- get_category_names(count_data[c("cult_all", "pcr_all", "sc_all"), "bact_counts"])

draw.triple.venn(area1=count_data["cult_all","bact_counts"],
				area2=count_data["pcr_all","bact_counts"],
				area3=count_data["sc_all","bact_counts"],
				n12=count_data["cult-pcr","bact_counts"],
				n23=count_data["pcr-sc","bact_counts"],
				n13=count_data["cult-sc","bact_counts"],
				n123=count_data["cult-pcr-sc","bact_counts"],,
				category=bact_cats,
				fontfamily = rep("sans", 7),
				cat.fontfamily = rep("sans", 3),
				euler.d = FALSE, scaled=FALSE
				)

arch_cats <- get_category_names(count_data[c("cult_all", "pcr_all", "sc_all"), "arch_counts"])

plot.new()
draw.triple.venn(area1=count_data["cult_all","arch_counts"],
				area2=count_data["pcr_all","arch_counts"],
				area3=count_data["sc_all","arch_counts"],
				n12=count_data["cult-pcr","arch_counts"],
				n23=count_data["pcr-sc","arch_counts"],
				n13=count_data["cult-sc","arch_counts"],
				n123=count_data["cult-pcr-sc","arch_counts"],,
				category=arch_cats,
				fontfamily = rep("sans", 7),
				cat.fontfamily = rep("sans", 3),
				euler.d = FALSE, scaled=FALSE
				)

dev.off()
