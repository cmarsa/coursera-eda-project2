# plot5.R
library(dplyr)
library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
baltimore_vehicles <- vehiclesNEI[vehiclesNEI$fips=="24510",]


png("plot5.png",width=480,height=480,units="px")
ggp <- baltimore_vehicles |>
    ggplot(aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM_2.5 Emission (Tons)")) + 
    labs(title=expression("PM_2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)
dev.off()
