# plot3.R
library(dplyr)
library(ggplot2)

NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# filtering data to baltimore city
baltimore <- NEI |>
    filter(fips == '24510')

# aggregate by year and type of emmission
baltimore_by_year <- baltimore |>
    group_by(year, type) |>
    summarise(Emissions=sum(Emissions))

# plot
png("plot3.png", width=800, height=480, units='px')
g <- baltimore_by_year |> 
    ggplot(aes(x = factor(year), y = Emissions, fill = type, colore = "black")) +
        geom_bar(stat = "identity") + facet_grid(. ~ type) + 
        xlab("Year") + ylab(expression('PM_2.5 Emission')) +
        ggtitle("Baltimore Emissions by Type") 
print(g)
dev.off()
