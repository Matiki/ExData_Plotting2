# Load all necessary packages into current R session
library(dplyr)
library(ggplot2)

# Read the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Filter data set for sources from motor vehicles in Baltimore, Maryland
scc2 <- scc %>%
        filter(grepl("[Vv]ehicle", as.character(scc$EI.Sector)))

vehicle <- as.character(scc2$SCC)

vehicle_index <- which(as.character(nei$SCC) %in% vehicle)

nei2 <- nei[vehicle_index, ] %>%
        filter(fips == "24510" | fips == "06037") %>%
        group_by(year, fips) %>%
        summarize(total_emissions = sum(Emissions))

# Open graphics device, plot, close device
png(filename = "plot6.png")

ggplot(nei2, 
       aes(x = year,
           y = total_emissions,
           col = fips)) +
        geom_line(size = 1) +
        labs(title = "Emissions from motor vehicles in Baltimore and Los Angeles",
             y = "Total emissions (tons)",
             x = "Year") +
        scale_color_discrete(name = "City",
                             breaks = c("06037", "24510"),
                             labels = c("Los Angeles", "Baltimore"))

dev.off()