data <- read.table(file="/Users/renegirard7gfy/Desktop/Thrash_Lab/Mix/all_bacteria.env_category.groups.rarefaction", header=T)
category <- "\\.plant$" #change the SO to whatever category you want (leave the \\. and $)
plant_columns <- grep(category, colnames(data))
category <- "\\.aerosol$" #change the SO to whatever category you want (leave the \\. and $)
aerosol_columns <- grep(category, colnames(data))
category <- "\\.aquatic$" #change the SO to whatever category you want (leave the \\. and $)
aquatic_columns <- grep(category, colnames(data))
category <- "\\.built$" #change the SO to whatever category you want (leave the \\. and $)
built_columns <- grep(category, colnames(data))
category <- "\\.other$" #change the SO to whatever category you want (leave the \\. and $)
other_columns <- grep(category, colnames(data))
category <- "\\.soil$" #change the SO to whatever category you want (leave the \\. and $)
soil_columns <- grep(category, colnames(data))
category <- "\\.zoonotic$" #change the SO to whatever category you want (leave the \\. and $)
zoonotic_columns <- grep(category, colnames(data))
plant_aerosol_aquatic_built_other_soil_zoonotic_data <- data[,c(1, plant_columns, aerosol_columns, aquatic_columns, built_columns, other_columns, soil_columns, zoonotic_columns)]  #the 1 gets the first column which is numsampled
nrows_to_keep <- which.max(plant_aerosol_aquatic_built_other_soil_zoonotic_data$numsampled[!is.na(plant_aerosol_aquatic_built_other_soil_zoonotic_data[,2])])
plant_aerosol_aquatic_built_other_soil_zoonotic_data <- plant_aerosol_aquatic_built_other_soil_zoonotic_data[1:nrows_to_keep,]
pdf(file="/Users/renegirard7gfy/Desktop/Bac_Uniq_3per_fixedY.pdf")

par(mar=c(5,5,0.5,0.5))
plot(NA, type="n", ylim=c(0,max(data[,-1], na.rm=T)),
     xlim=c(0,max(data$numsampled)),
     xlab="Number of sequences sampled",
     ylab="",
     axes=FALSE)

points(data$X0.03.plant~data$numsampled, type="l", col="red", lwd=2)
points(data$X0.03.aerosol~data$numsampled, type="l", col="green", lwd=2)
points(data$X0.03.aquatic~data$numsampled, type="l", col="blue", lwd=2)
points(data$X0.03.built~data$numsampled, type="l", col="orange", lwd=2)
points(data$X0.03.other~data$numsampled, type="l", col="black", lwd=2)
points(data$X0.03.soil~data$numsampled, type="l", col="purple", lwd=2)
points(data$X0.03.zoonotic~data$numsampled, type="l", col="deeppink", lwd=2)

legend(x=5e5, y=6e4, lwd=2, lty=1,
       legend=c("Other", "Plant", "Aerosol", "Aquatic", "Built", "Soil", "Zoonotic"),
       col=c("black", "red", "green", "blue", "orange", "purple", "deeppink"))

axis(1, at=seq(0,700000,1e5), label=c("0", "100,000", "200,000", "300,000", "400,000", "500,000", "600,000", "700,000"), cex.axis=0.8)
axis(2, at=seq(0,80000,10000), label=c("0", "10,000", "20,000", "30,000", "40,000", "50,000", "60,000", "70,000", "80,000"), las=2, cex.axis=0.8)
box()
mtext(side=2, "Number of OTUs", line=4)

dev.off()