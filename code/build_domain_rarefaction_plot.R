my_domain_col <- c(unique=rainbow(5)[1], X0.03='orange', X0.05=rainbow(5)[3], X0.10=rainbow(5)[4], X0.20=rainbow(5)[5] )
my_domain_pch <- c(unique=16, X0.03=16, X0.05=17, X0.10=21, X0.20=22)

plot_domain_curves <- function(rarefaction){
	nseqs <- rarefaction$numsampled
	rarefaction <- rarefaction[,-1]
	rarefaction <- rarefaction[,!grepl("ci", colnames(rarefaction))]

	xlim <- c(1,max(nseqs))
	ylim <- c(1, 1.05* max(rarefaction$unique))

	plot(NA, xlim=xlim, ylim=ylim, type='n', xlab="", ylab="", main="", axes=FALSE)
	for(cutoff in colnames(rarefaction)){
		points(rarefaction[,cutoff]~nseqs, type="l", lwd=2, col=my_domain_col[cutoff])

		spacing <- floor(seq(1,length(nseqs),length.out=10))[-1]
		points(rarefaction[spacing,cutoff]~nseqs[spacing], col=my_domain_col[cutoff], pch=my_domain_pch[cutoff], bg="white", cex=1.25)
	}
	box()

}

my_categories <- c(aerosol="Aerosol", aquatic="Aquatic", built="Built", plant="Plant", soil="Soil", zoonotic="Zoonotic", other="Other")

my_categories_col <- rainbow(7)
names(my_categories_col) <- names(my_categories)

my_categories_pch <- c(aerosol=19, aquatic=22, built=23, plant=24, soil=15, zoonotic=17, other=21)

plot_category_curves <- function(rarefaction, cutoff=0.03){

	right_columns <- grepl(cutoff, colnames(rarefaction))
	right_columns[grepl("numsampled", colnames(rarefaction))] <- TRUE
	right_columns[grepl("NA", colnames(rarefaction))] <- FALSE
	rare_cut <- rarefaction[,right_columns]
	colnames(rare_cut) <- gsub("X0.03.", "", colnames(rare_cut))

	plot(NA, xlim=c(0,max(rare_cut$numsampled)*1.05), ylim=c(0,max(rare_cut[,-1], na.rm=T)*1.05), xlab="", ylab="", axes=F)

	for(cat in names(my_categories)){
		points(rare_cut[,cat]~rare_cut$numsampled, lwd=2.5, type='l', col=my_categories_col[cat])

		end_point <- sum(!is.na(rare_cut[, cat]))
		points(rare_cut[end_point,cat]~rare_cut[end_point, 'numsampled'], pch=my_categories_pch[cat], col=my_categories_col[cat], bg="white", cex=1.5)

	}

	box()
}

bact_domain <- read.table(file='data/mothur/all_bacteria.filter.unique.precluster.an.rarefaction', header=T)
arch_domain <- read.table(file='data/mothur/all_archaea.filter.unique.precluster.an.rarefaction', header=T)

bact_category <- read.table(file='data/mothur/all_bacteria.env_category.groups.rarefaction', header=T)
arch_category <- read.table(file='data/mothur/all_archaea.env_category.groups.rarefaction', header=T)

pdf('results/figures/domain_rarefaction.pdf', width=7.5, height=7.5)
par(mar=c(2.5,4,0.5,0.5))

layout(matrix(c(5,1,2,5,3,4,0,6,6), nrow=3, byrow=T), widths=c(0.1,1,1), heights=c(1, 1, 0.10))

cex_size <- 0.9

plot_domain_curves(bact_domain)
axis(1, at=seq(0,1.4e6,2e5), label=c(0, expression('2' %*% 10^5), expression(4 %*% 10^5), expression(6 %*% 10^5), expression(8 %*% 10^5), expression(1 %*% 10^6), expression(1.2 %*% 10^6), expression(1.4 %*% 10^6)), cex.axis=cex_size)
axis(2, las=1, at=c(0, 5e4, 1e5, 1.5e5, 2e5, 2.5e5), label=c(0, expression('5.0' %*% 10^4), expression('1.0' %*% 10^5), expression(1.5 %*% 10^5), expression('2.0' %*% 10^5), expression(2.5 %*% 10^5)), cex.axis=cex_size)

text(par()$usr[1]/2, 0.95*par()$usr[4], "Bacteria", adj=0, cex=1.5, font=2)
text(par()$usr[2]*0.95, par()$usr[4]*0.95, "A", cex=2, font=2)

legend(x=1000, y=2e5, legend=c("No difference", "3% difference", "5% difference", "10% difference", "20% difference"), lwd=2, pch=my_domain_pch, col=my_domain_col, pt.bg="white", bty="n", pt.cex=1.25)


plot_category_curves(bact_category)
axis(1, at=seq(0,8e5,2e5), label=c(0, expression('2' %*% 10^5), expression(4 %*% 10^5), expression(6 %*% 10^5), expression(8 %*% 10^5)), cex.axis=cex_size)
axis(2, las=1, at=seq(0,35000,5000), label=format(seq(0,35000,5000), big.mark=','), cex.axis=cex_size)

text(par()$usr[2]*0.95, par()$usr[4]*0.95, "C", cex=2, font=2)

legend(x=6e5, y=15000, legend=my_categories, lwd=2, pch=my_categories_pch, col=my_categories_col, pt.bg="white", bty="n", pt.cex=1.25)




plot_domain_curves(arch_domain)
axis(1, at=seq(0,5e4,1e4), label=gsub(" ", "", format(seq(0,5e4,1e4), big.mark=',')), cex.axis=cex_size)
axis(2, at=seq(0,8000,2000), label=format(seq(0,8000,2000), big.mark=','), las=1, cex.axis=cex_size)
text(par()$usr[1]/2, 0.95*par()$usr[4], "Archaea", adj=0, cex=1.5, font=2)
text(par()$usr[2]*0.95, par()$usr[4]*0.95, "B", cex=2, font=2)


plot_category_curves(arch_category)
axis(1, at=seq(0,3.5e4,5e3), label=gsub(" ", "", format(seq(0,3.5e4,5e3), big.mark=',')), cex.axis=cex_size)
axis(2, las=1, at=seq(0,3500,500), label=format(seq(0,3500,500), big.mark=','), cex.axis=cex_size)
text(par()$usr[2]*0.95, par()$usr[4]*0.95, "D", cex=2, font=2)


par(mar=c(0,0,0,0))
plot.new()
text(0.5,0.5, label="Number of OTUs", srt=90, cex=1.2)


plot.new()
text(0.5,0.5, label="Number of Sequences", cex=1.2)
dev.off()
