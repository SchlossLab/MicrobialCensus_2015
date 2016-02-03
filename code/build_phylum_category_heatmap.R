require("RColorBrewer")

categories <- c(AE="Aerosol", AQB="Brackish", AQBS="Brackish sediment", AQF="Freshwater", AQFS="Freshwater sediment", AQM="Marine", AQMS="Marine sediment", AQH="Hydrothermal vent", AQI="Ice", AQO="Aquatic other", BD="Digesters", BF="Food-associated", BI="Industrial/mining", BP="Pollution associated", BO="Built other", PR="Plant root", PS="Plant surface", PO="Plant other", SA="Agricultural soil", SD="Desert soil", SP="Permafrost", SO="Other soils", ZV="Vertebrate", ZA="Arthropod", ZN="Other invertebrate", ZO="Other zoological", OT="Other", total="Total")

rev_categories <- rev(names(categories))

data <- read.table(file="data/process/phylum_category_counts.tsv", header=T)

bacteria <- data[data$domain=="bacteria",]
rownames(bacteria) <- bacteria[,1]
bacteria <- bacteria[,-c(1,2)]
bacteria <- bacteria[order(bacteria$total, decreasing=T),]
bacteria_ra <- prop.table(as.matrix(bacteria), margin=2)
bacteria_top <- as.matrix(bacteria_ra[1:10,rev_categories])

archaea <- data[data$domain=="archaea",]
rownames(archaea) <- archaea[,1]
archaea <- archaea[,-c(1,2)]
archaea <- archaea[order(archaea$total, decreasing=T),]
archaea_ra <- prop.table(as.matrix(archaea), margin=2)
archaea_top <- as.matrix(archaea_ra[1:10,rev_categories])

rownames(archaea_top) <- gsub("Miscellaneous_Crenarchaeotic_Group", "Misc. Crenarchaeota", rownames(archaea_top))
rownames(archaea_top) <- gsub("Hydrothermal", "Hydro.", rownames(archaea_top))
rownames(archaea_top) <- gsub("_", " ", rownames(archaea_top))




cairo_ps(file="results/figures/category_phylum_heatmap.eps", width=7.5, height=5)

layout(matrix(c(3,1,2), nrow=1), widths=c(0.5,1,1))
par(mar=c(11, 0.5, 0.5, 0.5))

image(bacteria_top, col=c(brewer.pal("Reds", n=9), "black"), zlim=c(0.01,1), axes=F)
box()
axis(1, at=seq(0,1,length.out=nrow(bacteria_top)), label=rownames(bacteria_top), las=2, tick=F)
text(0.95*par()$usr[2],0.97*par()$usr[4],"A", cex=2, font=2)

image(archaea_top, col=c(brewer.pal("Reds", n=9), "black"), zlim=c(0.01,1.0), axes=F)
box()
axis(1, at=seq(0,1,length.out=nrow(archaea_top)), label=rownames(archaea_top), las=2, tick=F)
text(0.95*par()$usr[2],0.97*par()$usr[4],"B", cex=2, font=2)

my_usr <- par()$usr

plot(NA, xlim=c(0,1), ylim=c(0,1), type="n", xaxs="i", axes=F, xlab="", ylab="", usr=my_usr)

text(x=rep(1, length.out=ncol(bacteria_top)), y=seq(my_usr[3],my_usr[4],length.out=ncol(bacteria_top)), label=categories[colnames(bacteria_top)], adj=1, cex=1.1)

legend_image <- as.raster(matrix(c(brewer.pal("Reds", n=9), "#000000"), nrow=1))
rasterImage(legend_image, 0.25, -0.30, 0.75, -0.25, xpd=T)
						#xleft, ybottom, xright, ytop
polygon(x=c(0.25,0.25,0.75,0.75), y=c(-0.30,-0.25,-0.25,-0.30), xpd=T, lwd=0.5)

text(x=0.25, y=-0.3, label="0", pos=1, xpd=T)
text(x=0.50, y=-0.3, label="50", pos=1, xpd=T)
text(x=0.75, y=-0.3, label="100", pos=1, xpd=T)
text(x=0.5, y=-0.2, label="% Relative\nAbundance", xpd=T, cex=0.9)
dev.off()
