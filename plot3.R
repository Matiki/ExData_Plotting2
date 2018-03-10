# Load all necessary packages into current R session
library(dplyr)
library(ggplot2)

# Read the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Find total emissions by type and year
nei2 <- nei %>%
        group_by(type, year) %>%
        summarize(total_emissions = sum(Emissions))

# Open graphics device, call plot, close device
png(filename = "plot3.png")

ggplot(nei2, 
       aes(x = year, 
           y = total_emissions, 
           col = type)) + 
        geom_line(size = 1) +
        labs(y = "Total Emissions (tons)",
             x = "Year",
             title = "Total emissions by type: Baltimore City, Maryland")

dev.off()