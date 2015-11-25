get_phylum <- function(taxonomy){
	phylum <- gsub("^[^;]*;([^;]*);.*", "\\1", taxonomy)
	phylum[grepl(';', phylum)] <- "Unclassified"
	phylum
}


categories <- c(AE="Aerosol", AQB="Brackish", AQBS="Brackish sediment", AQF="Freshwater", AQFS="Freshwater sediment", AQM="Marine", AQMS="Marine sediment", AQH="Hydrothermal vent", AQI="Ice", AQO="Aquatic other", BD="Digesters", BF="Food-associated", BI="Industrial/mining", BP="Pollution associated", BO="Built other", PR="Plant root", PS="Plant surface", PO="Plant other", SA="Agricultural soil", SD="Desert soil", SP="Permafrost", SO="Other soils", ZV="Vertebrate", ZA="Arthropod", ZN="Other invertebrate", ZO="Other zoological", OT="Other")

bact <- read.table(file='data/process/bacteria.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
bact$category[bact$category=="ZI" & !is.na(bact$category)] <- "ZA" #to remove

bact_phylum <- get_phylum(bact$taxonomy)
bact_phylum[bact_phylum=="Euryarchaeota"] <- NA #to be removed
bact_phylum[bact_phylum=="aquifer1"] <- NA

b_phylum_cat_count <- table(bact_phylum, bact$category)
b_phylum_cat_ra <- prop.table(b_phylum_cat_count, margin=2)
b_phylum_cat_ra <- cbind(b_phylum_cat_ra, total=table(bact_phylum)/length(bact_phylum))
rownames(b_phylum_cat_ra) <- gsub("_?\\(.*\\)", "", rownames(b_phylum_cat_ra) )
bacterial_data <- cbind(domain=rep("bacteria", nrow(b_phylum_cat_ra)), b_phylum_cat_ra)


arch <- read.table(file='data/process/archaea.v123.metadata', header=T, row.names=1, stringsAsFactors=FALSE)
arch$category[arch$category=="BDBD" & !is.na(arch$category)] <- "BD" #to remove

arch_phylum <- get_phylum(arch$taxonomy)

a_phylum_cat_count <- table(arch_phylum, factor(arch$category, levels=names(categories)))
a_phylum_cat_ra <- prop.table(a_phylum_cat_count, margin=2)
a_phylum_cat_ra <- cbind(a_phylum_cat_ra, total=table(arch_phylum)/length(arch_phylum))
rownames(a_phylum_cat_ra) <- gsub("_?\\(.*\\)", "", rownames(a_phylum_cat_ra) )
archaeal_data <- cbind(domain=rep("archaea", nrow(a_phylum_cat_ra)), a_phylum_cat_ra)


write.table(rbind(bacterial_data, archaeal_data), file="data/process/phylum_category_counts.tsv", sep='\t', row.names=T, quote=F)
