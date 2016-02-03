
b_cult_time <- read.table(file='data/process/bacteria.cultured_by_time_counts.tsv', header=T)
b_cult_time <- b_cult_time[b_cult_time$all_total_nseqs >= 1000,]
rownames(b_cult_time) <- gsub("Candidate_division_", "", rownames(b_cult_time))

b_phyla <- rownames(b_cult_time)
b_cult_time[,"nseqs_precent"] <- 100*b_cult_time[,"all_cult_nseqs"]/b_cult_time[,"all_total_nseqs"]
b_cult_time[,"sobs_precent"] <- 100*b_cult_time[,"all_cult_sobs"]/b_cult_time[,"all_total_sobs"]
b_is_cultured <- b_cult_time$sobs_precent > 0

b_cultured <- b_cult_time[b_is_cultured,colnames(b_cult_time) %in% c("nseqs_precent", "sobs_precent")]
b_order <- order(b_cultured$sobs_precent, decreasing=T)
b_cultured <- b_cultured[b_order,]
b_n_taxa <- nrow(b_cultured)



a_cult_time <- read.table(file='data/process/archaea.cultured_by_time_counts.tsv', header=T)
a_cult_time <- a_cult_time[a_cult_time$all_total_nseqs >= 1000,]

a_phyla <- rownames(a_cult_time)
a_cult_time[,"nseqs_precent"] <- 100*a_cult_time[,"all_cult_nseqs"]/a_cult_time[,"all_total_nseqs"]
a_cult_time[,"sobs_precent"] <- 100*a_cult_time[,"all_cult_sobs"]/a_cult_time[,"all_total_sobs"]
a_is_cultured <- a_cult_time$sobs_precent > 0

a_cultured <- a_cult_time[a_is_cultured,colnames(a_cult_time) %in% c("nseqs_precent", "sobs_precent")]
a_order <- order(a_cultured$sobs_precent, decreasing=T)
a_cultured <- a_cultured[a_order,]
a_n_taxa <- nrow(a_cultured)

total_lines <- b_n_taxa + a_n_taxa + 2

cairo_ps("results/figures/phylum_cultured.eps",  width=3.75, height=4.75)
par(mar=c(5,10,1.0,0.5), cex=0.7)
plot(NA, xlim=c(0,70), ylim=c(1,total_lines), axes=F, xlab="", ylab="")
abline(h=c(1:a_n_taxa, (a_n_taxa+3):total_lines), lty=3, col="gray")

points(x=a_cultured$nseqs_precent, y=a_n_taxa:1, pch=1)
points(x=a_cultured$sobs_precent, y=a_n_taxa:1, pch=19)

points(x=b_cultured$nseqs_precent, y=total_lines:(a_n_taxa+3), pch=1)
points(x=b_cultured$sobs_precent, y=total_lines:(a_n_taxa+3), pch=19)

axis(2, at=total_lines:(a_n_taxa+3), label=rownames(b_cultured), las=1, tick=F)
axis(2, at=a_n_taxa:1, label=rownames(a_cultured), las=1, tick=F)

box()
axis(1, at=seq(0,100,10), label=seq(0,100,10))

legend(x=30, y=15, legend=c("Cultured sequences", "Cultured OTUs"), pch=c(1, 19), bg="white", cex=0.8)
mtext("Bacteria", side=2, line=5, at=total_lines+1.2, las=1, font=2, cex=0.8, xpd=T)
mtext("Archaea", side=2, line=5, at=a_n_taxa+1.2, las=1, font=2, cex=0.8)

title(xlab="Percentage of all sequences or OTUs", line=2.5)

dev.off()
