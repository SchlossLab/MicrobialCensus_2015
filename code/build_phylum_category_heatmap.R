require("RColorBrewer")

bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact_phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", bact$taxonomy)
bact_phylum[bact_phylum=="Euryarchaeota"] <- NA
bact_phylum[bact_phylum=="aquifer1"] <- NA

arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch_phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", arch$taxonomy)
arch_phylum[arch_phylum=="Archaea;"] <- "Unclassified"

bact$category[bact$category=="ZI" & !is.na(bact$category)] <- "ZA" #to remove
arch$category[arch$category=="BDBD" & !is.na(arch$category)] <- "BD" #to remove


categories <- c(AE="Aerosol", AQB="Brackish", AQBS="Brackish sediment", AQF="Freshwater", AQFS="Freshwater sediment", AQM="Marine", AQMS="Marine sediment", AQH="Hydrothermal vent", AQI="Ice", AQO="Aquatic other", BD="Digesters", BF="Food-associated", BI="Industrial/mining", BP="Pollution associated", BO="Built other", PR="Plant root", PS="Plant surface", PO="Plant other", SA="Agricultural soil", SD="Desert soil", SP="Permafrost", SO="Other soils", ZV="Vertebrate", ZA="Arthropod", ZN="Other invertebrate", ZO="Other zoological", OT="Other")


b_phylum_cat_count <- table(bact_phylum, bact$category)
b_phylum_cat_ra <- prop.table(b_phylum_cat_count, margin=2)
b_phylum_cat_max_ra <- apply(b_phylum_cat_ra, 1, max)
o <- order(b_phylum_cat_max_ra, decreasing=T)
b_ordered_subset <- b_phylum_cat_ra[o[1:10],rev(names(categories))]
b_average <- table(bact_phylum)[o[1:10]] / length(bact_phylum)


a_phylum_cat_count <- table(arch_phylum, factor(arch$category, levels=names(categories)))
a_phylum_cat_ra <- prop.table(a_phylum_cat_count, margin=2)
a_phylum_cat_max_ra <- apply(a_phylum_cat_ra, 1, max, na.rm=T)
o <- order(a_phylum_cat_max_ra, decreasing=T)
a_ordered_subset <- a_phylum_cat_ra[o[1:10],rev(names(categories))]
a_average <- table(arch_phylum)[o[1:10]] / length(arch_phylum)

rownames(a_ordered_subset) <- gsub("_\\(.*\\)", "", rownames(a_ordered_subset))
rownames(a_ordered_subset) <- gsub("Miscellaneous_Crenarchaeotic_Group", "Misc. Crenarchaeota", rownames(a_ordered_subset))



pdf(file="results/figures/category_phylum_heatmap.pdf", width=7.5, height=5)

layout(matrix(c(3,1,2), nrow=1), widths=c(0.5,1,1))
par(mar=c(9, 0.5, 0.5, 0.5))

image(cbind(b_ordered_subset, b_average), col=c(brewer.pal("Reds", n=9), "black"), zlim=c(0.01,1), axes=F)
box()
axis(1, at=seq(0,1,length.out=nrow(b_ordered_subset)), label=rownames(b_ordered_subset), las=2, tick=F)
text(0.95*par()$usr[2],0.97*par()$usr[4],"A", cex=2, font=2)

image(cbind(a_ordered_subset, a_average), col=c(brewer.pal("Reds", n=9), "black"), zlim=c(0.01,1.0), axes=F)
box()
axis(1, at=seq(0,1,length.out=nrow(a_ordered_subset)), label=rownames(a_ordered_subset), las=2, tick=F)
text(0.95*par()$usr[2],0.97*par()$usr[4],"B", cex=2, font=2)

my_usr <- par()$usr

plot(NA, xlim=c(0,1), ylim=c(0,1), type="n", xaxs="i", axes=F, xlab="", ylab="", usr=my_usr)

text(x=rep(1, length.out=ncol(b_ordered_subset)+1), y=seq(my_usr[3],my_usr[4],length.out=ncol(b_ordered_subset)+1), label=c("Total", categories[colnames(b_ordered_subset)]), adj=1, cex=1.1)

legend_image <- as.raster(matrix(c(brewer.pal("Reds", n=9), "#000000"), nrow=1))
rasterImage(legend_image, 0.25, -0.20, 0.75, -0.15, xpd=T)
						#xleft, ybottom, xright, ytop
polygon(x=c(0.25,0.25,0.75,0.75), y=c(-0.20,-0.15,-0.15,-0.20), xpd=T, lwd=0.5)

text(x=0.25, y=-0.2, label="0", pos=1, xpd=T)
text(x=0.50, y=-0.2, label="50", pos=1, xpd=T)
text(x=0.75, y=-0.2, label="100", pos=1, xpd=T)

dev.off()
