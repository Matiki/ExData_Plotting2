# Load all necessary packages into current R session
library(dplyr)
library(ggplot2)

# Read the data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Filter data set to only include sources related to coal combustion
scc2 <- scc %>% 
        filter(grepl("[Cc]oal", as.character(scc$EI.Sector))) 

coal <- as.character(scc2$SCC)

coal_index <- which(as.character(nei$SCC) %in% coal)

nei2 <- nei[coal_index, ] %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions))

# Open graphics device, plot, close device
png(filename = "plot4.png")

ggplot(nei2, 
       aes(x = year,
           y = total_emissions)) +
        geom_line(size = 1) +
        labs(title = "Emissions from coal combustion",
             y = "Total emissions (tons)",
             x = "Year")

dev.off()