# plot1.R
# load data
NEI <- readRDS("data/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data/exdata_data_NEI_data/Source_Classification_Code.rds")

# aggregate emmisions by year
year_emmisions <- aggregate(Emissions ~ year, NEI, sum)

# plot emmisions as barplot
png('plot1.png')
barplot(height=year_emmisions$Emissions,
        names.arg=year_emmisions$year,
        xlab="years",
        ylab=expression('Total PM_2.5 emission'),
        main=expression('Total PM_2.5 emissions by year'))
dev.off()
