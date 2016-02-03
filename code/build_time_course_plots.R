#devtools::install_github("karthik/wesanderson")
library("wesanderson")
clrs <- wes_palette("Zissou")[c(2,5)]



time_data <- read.table(file="data/process/by_year_analysis.tsv", header=T)
year <- as.numeric(rownames(time_data))

exclude_year <- 2015

time_data <- time_data[year != exclude_year,]
year <- year[year != exclude_year]

cairo_ps(file="results/figures/time_course_figure.eps", width=3.75, height=6.0)
	layout(matrix(c(1,2,3,4), nrow=4), height=c(1,1,1,0.25))

	#A
	par(mar=c(0.5,5.5,0.5,0.5))

	time_data[time_data$a_nseqs == 0, "a_nseqs"] <- 1
	time_data[time_data$b_nseqs == 0, "b_nseqs"] <- 1

	plot(time_data$b_nseqs~year, log='y', type="l", col=clrs[1], lwd=2, xlab="", ylab="Number of new\nsequences per year", ylim=c(1,1e6), xlim=c(1980, 2015), axes=F)

	points(time_data$a_nseqs~year, type="l", col=clrs[2], lwd=2)

	points(time_data$b_nseqs[year %% 5==0]~year[year %% 5==0], pch=17, col=clrs[1], cex=1.5)
	points(time_data$a_nseqs[year %% 5==0]~year[year %% 5==0], pch=19, col=clrs[2], cex=1.5)

	axis(1, labels=FALSE)
	axis(2, at=c(1,10,1e2,1e3,1e4,1e5,1e6), labels=parse(text=paste("10^", 0:6)), las=1)
	box()
	legend(x=2003, y=100, legend=c("Bacteria", "Archaea"), col=c(clrs[1], clrs[2]), pch=c(17,19), lty=1, lwd=2, pt.cex=1.5)

	text(x=1980, y=10^(0.9*par()$usr[4]), label="A", cex=2, font=2)

	#B
	time_data[time_data$a_sobs == 0, "a_sobs"] <- 1
	time_data[time_data$b_sobs == 0, "b_sobs"] <- 1


	plot(time_data$b_sobs~year, log='y', type="l", col=clrs[1], lwd=2, xlab="", ylab="Number of new\nOTUs per year", ylim=c(1,20000), xlim=c(1980, 2015), axes=F)

	points(time_data$a_sobs~year, type="l", col=clrs[2], lwd=2)

	points(time_data$b_sobs[year %% 5==0]~year[year %% 5==0], pch=17, col=clrs[1], cex=1.5)
	points(time_data$a_sobs[year %% 5==0]~year[year %% 5==0], pch=19, col=clrs[2], cex=1.5)

	axis(1, labels=FALSE)
	axis(2, at=c(1,10,1e2,1e3,1e4), labels=parse(text=paste("10^", 0:4)), las=1)
	box()

	text(x=1980, y=10^(0.9*par()$usr[4]), label="B", cex=2, font=2)


	#C
	plot(time_data$b_n50~year, type="l", lwd=2, xlab="", ylab="Number of submissions accounting\nfor 50% of sequences deposited", xlim=c(1980, 2015), col=clrs[1], axes=F)

	points(time_data$a_n50~year, type="l", lwd=2, col=clrs[2])

	points(time_data$b_n50[year %% 5==0]~year[year %% 5==0], pch=17, col=clrs[1], cex=1.5)
	points(time_data$a_n50[year %% 5==0]~year[year %% 5==0], pch=19, col=clrs[2], cex=1.5)

	axis(2, las=1)
	axis(1)
	box()

	text(x=1980, y=0.9*par()$usr[4], label="C", cex=2, font=2)

	#D
	plot.new()
	text(0.5,0.25, label="Year")

dev.off()
