#install and load packages
install.packages("tidyverse")
install.packages("directlabels")
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(gridExtra)
library(grid)

# Load data
wl_raw <- read.csv(file = "/Users/azmirfakkri/Documents/Programming for Big Data/IPDC Waiting List By Group Hospital 2017.csv", 
                     header = TRUE, sep = ",")

# View wl_raw class
class(wl_raw)

# View the whole data structure
glimpse(wl_raw)
summary(wl_raw)

# Check for missing values
any(is.na(wl_raw))

# View head and tail
head(wl_raw, n = 10)
tail(wl_raw, n = 10)

# November Cases
wl_nov <- wl_raw %>% filter(Archive.Date == "2017-11-30")

# Plot 1: Total Cases by Hospital Group in Nov 2017
wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = Group, y = Total_Cases, fill = Group)) + 
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Hospital Group in Nov 2017",
       y = "Total Cases") +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank())

# Hospitals by Group
hosp_group <- wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total))

# Total number of patient in waiting list as of Nov 2017
sum(wl_nov$Total)

# Plot 2: Total Cases by Hospital in Nov 2017
wl_nov %>% group_by(Group, Hospital) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = reorder(Hospital, Total_Cases),
                          y = Total_Cases,
                          fill = Total_Cases)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Hospital in Nov 2017",
       x = "Hospital",
       y = "Total Cases") +
  scale_fill_continuous(guide = "none", low ="blue", high ="red") +
  coord_flip()

# Plot 3: Total Cases by Patient Type and Case Type
wl_nov %>% group_by(Adult.Child, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
  ggplot(aes(x = Adult.Child, y = Total_Cases, fill = Case.Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Patient Type and Case Type in Nov 2017",
       x = "Patient Type",
       y = "Total Cases") +
  geom_text(aes(label = Total_Cases), position = position_stack(vjust = 0.5),
            colour = "white", size = 3) +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

# Plot 4: Total Cases by Case Type and Age Profile
wl_nov %>% group_by(Case.Type, Age.Profile) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = Case.Type, y = Total_Cases, fill = Age.Profile)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Case Type and Age Profile in Nov 2017",
       x = "Case Type",
       y = "Total Cases") +
  geom_text(aes(label = Total_Cases), position = position_stack(vjust = 0.5),
            colour = "white", size = 3) +
  scale_fill_discrete(name = "Age Profile") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

# Total Cases by Month by Hospital Group
total_bydate <- wl_raw %>% group_by(Archive.Date, Group) %>%
  summarise(Average_Cases = mean(Total))

total_bydate2 <- separate(total_bydate, "Archive.Date", c("Year", "Month", "Day"), sep = "-")
total_bymonth <- total_bydate2[ , c(-1, -3)]

# Plot 5: Monthly Average Cases by Hospital Group
ggplot(total_bymonth, aes(x = Month, y = Average_Cases, colour = Group, group = Group)) + 
  geom_point() +
  geom_line() +
  labs(title = "Monthly Average Cases by Hospital Group",
       y = "Average Cases")


# Plot 6: Total Cases by Speciality based on Case Type in Nov 2017
wl_nov %>% group_by(Speciality, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(x = reorder(Speciality, -Total_Cases),
                          y = Total_Cases,
                          fill = Case.Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Cases by Speciality based on Case Type in Nov 2017",
       x = "Speciality",
       y = "Total Cases") +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 1))

# Plot 7: Total Cases by Time Bands based on Patient Type in Nov 2017
wl_nov %>% group_by(Time.Bands, Adult.Child) %>%
  summarise(Total_Cases = sum(Total)) %>%
ggplot(aes(Time.Bands, Total_Cases, fill = Adult.Child)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = Total_Cases), position = position_dodge(0.9),
            vjust = 1.1, color = "white") +
  labs(title = "Total Cases by Time Bands based on Patient Type in Nov 2017",
       x = "Time Bands",
       y = "Total Cases") +
  scale_fill_discrete(name = "Patient Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank())

# Plot 8: Total Cases by Time Bands based on Case Type in Nov 2017
wl_nov %>% group_by(Time.Bands, Case.Type) %>%
  summarise(Total_Cases = sum(Total)) %>%
  ggplot(aes(Time.Bands, Total_Cases, fill = Case.Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = Total_Cases), position = position_dodge(0.9),
            vjust = 1.1, color = "white") +
  labs(title = "Total Cases by Time Bands based on Case Type in Nov 2017",
       x = "Time Bands",
       y = "Total Cases") +
  scale_fill_discrete(name = "Case Type") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank())