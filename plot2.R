# plot2.R
library(dplyr)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")


# filter information of Baltimore City, Maryland
baltimoreNEI <- NEI |>
    filter(fips == '24510')

# aggregate Baltimore data by year
baltimore_by_year <- baltimoreNEI |>
    group_by(year) |>
    summarise(total_emissions = sum(Emissions)) |>
    ungroup()


png("plot2.png",width=480,height=480,units="px")
barplot(
    baltimore_by_year$total_emissions,
    names.arg=baltimore_by_year$year,
    xlab="Year",
    ylab="PM_2.5 Emissions (Tons)",
    main="Total PM_2.5 Emissions Baltimore"
)
dev.off()