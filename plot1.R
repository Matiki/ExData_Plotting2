# Load all necessary packages into current R session
library(dplyr)

# Read the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Find total emissions from all sources by year
nei2 <- nei %>% 
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions))

# Open graphics device, call plotting function, close graphics device
png(filename = "plot1.png")

plot(nei2$year, 
     nei2$total_emissions, 
     main = "Total PM2.5 emissions from all sources",
     xlab = "Year", 
     ylab = "Total Emissions (tons)", 
     type = "b", 
     pch = 19, 
     lwd = 2)

dev.off()