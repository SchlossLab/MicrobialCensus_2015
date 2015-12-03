my_col <- c(unique=rainbow(5)[1], X0.03='orange', X0.05=rainbow(5)[3], X0.10=rainbow(5)[4], X0.20=rainbow(5)[5] )
my_pch <- c(unique=16, X0.03=16, X0.05=17, X0.10=21, X0.20=22)

plot_curves <- function(rarefaction){
	nseqs <- rarefaction$numsampled
	rarefaction <- rarefaction[,-1]
	rarefaction <- rarefaction[,!grepl("ci", colnames(rarefaction))]

	xlim <- c(1,max(nseqs))
	ylim <- c(1, 1.05* max(rarefaction$unique))

	plot(NA, xlim=xlim, ylim=ylim, type='n', xlab="", ylab="", main="", axes=FALSE)
	for(cutoff in colnames(rarefaction)){
		points(rarefaction[,cutoff]~nseqs, type="l", lwd=2, col=my_col[cutoff])

		spacing <- floor(seq(1,length(nseqs),length.out=10))[-1]
		points(rarefaction[spacing,cutoff]~nseqs[spacing], col=my_col[cutoff], pch=my_pch[cutoff], bg="white", cex=1.25)
	}
	box()

}

bact <- read.table(file='data/mothur/all_bacteria.filter.unique.precluster.an.rarefaction', header=T)
arch <- read.table(file='data/mothur/all_archaea.filter.unique.precluster.an.rarefaction', header=T)

pdf('results/figures/domain_rarefaction.pdf', width=7.5, height=3.5)
par(mar=c(2,4,0.5,0.5))

layout(matrix(c(3,1,2,0,4,4), nrow=2, byrow=T), widths=c(0.1,1,1), heights=c(1,0.10))

cex_size <- 0.9

plot_curves(bact)
axis(1, at=seq(0,1.4e6,2e5), label=c(0, expression('2' %*% 10^5), expression(4 %*% 10^5), expression(6 %*% 10^5), expression(8 %*% 10^5), expression(1 %*% 10^6), expression(1.2 %*% 10^6), expression(1.4 %*% 10^6)), cex.axis=cex_size)
axis(2, las=1, at=c(0, 5e4, 1e5, 1.5e5, 2e5, 2.5e5), label=c(0, expression('5.0' %*% 10^4), expression('1.0' %*% 10^5), expression(1.5 %*% 10^5), expression('2.0' %*% 10^5), expression(2.5 %*% 10^5)), cex.axis=cex_size)
text(0.98*par()$usr[2], 0.97*par()$usr[4], "Bacteria", adj=1, cex=1.25)


legend(x=1000, y=2.55e5, legend=c("No difference", "3% difference", "5% difference", "10% difference", "20% difference"), lwd=2, pch=my_pch, col=my_col, pt.bg="white", bty="n", pt.cex=1.25)

plot_curves(arch)
axis(1, at=seq(0,5e4,1e4), label=c(0, expression('1' %*% 10^4), expression(2 %*% 10^4), expression(3 %*% 10^4), expression(4 %*% 10^4), expression(5 %*% 10^4)), cex.axis=cex_size)
axis(2, at=seq(0,8000,2000), label=format(seq(0,8000,2000), big.mark=','), las=1, cex.axis=cex_size)
text(0.98*par()$usr[2], 0.97*par()$usr[4], "Archaea", adj=1, cex=1.25)

par(mar=c(0,0,0,0))
plot.new()
text(0.5,0.5, label="Number of OTUs", srt=90, cex=1.2)


plot.new()
text(0.5,0.5, label="Number of Sequences", cex=1.2)
dev.off()
