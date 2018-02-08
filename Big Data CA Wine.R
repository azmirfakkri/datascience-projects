#install and load packages
install.packages("tidyverse")
install.packages("rworldmap")
install.packages("ggpubr")
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(rworldmap)
library(ggpubr)

###########################################################
#################### Data Cleaning ########################
###########################################################

################## Exploring raw data #####################

# Load wine_raw1 data
wine_raw1 <- read.csv(file = "/Users/azmirfakkri/Documents/Programming for Big Data/winemag-data-130k-v2-1.csv", 
                      header = TRUE, sep = ",")

# View wine_raw class
class(wine_raw1)

# View wine_raw dimensions
dim(wine_raw1)

# View wine_raw1 structure
str(wine_raw1)

## Wine vintage year was extracted using the commented code ##
## Result were manipulated manually in Excel ##

# vintage_list <- str_extract_all(wine_tidy2$title, "\\d{4}", simplify = T)

# Load wine_raw2 (with vintage_year column)
wine_raw2 <- read.csv(file = "/Users/azmirfakkri/Documents/Programming for Big Data/winemag-data-130k-v2-2.csv", 
                      header = TRUE, sep = ",")

# View wine_raw2 structure
str(wine_raw2)

##################### Tidying data ########################

# Remove column X, taster_name and taster_twitter_handle
wine_tidy1 <- wine_raw2[ , c(-1, -10, -11)]

# Re-arrange columns 
wine_tidy2 <- select(wine_tidy1, country, designation, province, region_1, region_2, 
                     winery, variety, price, points, title, description, vintage_year)

############## Preparing data for analysis ################

#Remove title column 
wine_data <- wine_tidy2[ , -10]

# Replace all blanks with NA
wine_data[wine_data == ""] <- NA

# Convert class of data.frame columns 
wine_data$description <- as.character(wine_data$description)
wine_data$points <- as.numeric(wine_data$points)
wine_data$price <- as.numeric(wine_data$price)

# Summary of the cleaned dataset 
summary(wine_data)

# Summary table
wine_long <- wine_data %>% gather(key = var_names, value = ind_val)

summary_table <- wine_long %>% group_by (var_names) %>%
  summarise (count_unique = length(unique(na.omit(ind_val))),
             count_NA = sum(is.na(ind_val)))

###########################################################
############## Exploratory Data Analysis ##################
###########################################################

######## Top wine producers and global production #########

# Top 10 wine producers
top_wine <- wine_data %>% group_by(country) %>% 
  drop_na(country) %>%
  summarise(Total_Review = n()) %>% 
  arrange(desc(Total_Review))

# World map for global production
map_data <- wine_data %>% group_by(country) %>% 
  summarise(Total_Review = n()) %>% 
  arrange(desc(Total_Review))

# Join to a course resolution map
spmap_data <- joinCountryData2Map(top_wine, joinCode ="NAME",
                                  nameJoinColumn = "country")

# Visualise map
mapCountryData(spmap_data, nameColumnToPlot = "Total_Review",
               catMethod = "fixedWidth",
               mapTitle = "Wine Origin across the World")

######################### Price ###########################

#Highest and lowest price
summary(wine_data$price)

# Price distribution
price_hist <- ggplot(wine_data, aes(x = price, colour = I('black'), fill = I('maroon'))) +
  geom_histogram(na.rm = TRUE, binwidth = 10) +
  labs(title = "Price Distribution",
       x = "Price (in US Dollar)",
       y = "Frequency")

price_hist + coord_cartesian(xlim = c(0, 100))

# Average price by country
avgprice_bycountry <- wine_data %>%
  group_by(country) %>%
  drop_na(price, country) %>%
  summarise(average_price = mean(price)) %>%
  arrange(desc(average_price))

avgprice_bycountry
####################### Points ############################

# Highest and lowest points
summary(wine_data$points)

# Points distribution
points_dist <- ggplot(wine_data, aes(x = points)) +
  geom_density(alpha = 0.6, adjust = 1.8, fill = 'lightgreen') +
  labs(title = "Points Distribution",
       x = "Points",
       y = "Frequency")

points_dist

# Average points by country
avgpoints_bycountry <- wine_data %>%
  group_by(country) %>%
  drop_na(points, country) %>%
  summarise(average_points = mean(points)) %>%
  arrange(desc(average_points))

############### Log(Price) against Points ################

# Pearson correlation
cor.test(wine_data$points, log(wine_data$price), method = "pearson", use = "complete.obs")

# Plot correlation: Log(Price) against Points
ggplot(wine_data, aes(x = points, y = price)) +
  geom_point(colour = "#CC3300") +
  scale_y_log10() +
  geom_smooth() +
  labs(title = "Log(Price) against Points",
       x = "Points",
       y = "Log(Price)")

#################### Vintage Year #########################

# Summary
sort(table(wine_data$vintage_year), decreasing = TRUE)

# Vintage Year Bar Chart
wine_data %>% drop_na(vintage_year) %>%
ggplot(aes(x = factor(vintage_year), fill = "#D55E00")) +
  geom_bar() +
  labs(title = "Vintage Year",
       x = "Vintage Year",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_discrete(guide = FALSE)

# Plot: Points against Vintage Year
ggplot(wine_data, aes(x = vintage_year, y = points)) +
  geom_point(colour = "#D55E00") +
  labs(title = "Points against Vintage Year",
       x = "Vintage Year",
       y = "Points")

# Plot: Price against Vintage Year
ggplot(wine_data, aes(x = vintage_year, y = price)) +
  geom_point(colour = "red") +
  labs(title = "Price against Vintage Year",
       x = "Vintage Year",
       y = "Price")

#################### Best Economic Wines #########################

# Range 10-20, >90
goodwine <- wine_data %>%
  select(country, points, price, province, variety) %>%
  filter(price >= 10 & price <= 20, points >= 90) %>%
  group_by(points) %>%
  drop_na(price, country) %>%
  arrange(desc(points)) %>%
  arrange(desc(price))

top_goodwine <- goodwine %>%
  group_by(country, variety) %>%
  summarise(Total_Review = n()) %>%
  arrange(desc(Total_Review))
