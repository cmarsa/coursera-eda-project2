# plot4.R
library(dplyr)
library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

png("plot4.png",width=480,height=480,units="px")

ggp <- combustionNEI |>
    ggplot(aes(factor(year),Emissions/10^5)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() + 
    labs(x="year", y=expression("Total PM_2.5 Emission (10^5 Tons)")) + 
    labs(title=expression("PM_2.5 Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off()
