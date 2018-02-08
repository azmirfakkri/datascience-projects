###########################################################
#---------------------------------------------------------#
################ Assignment 1: Azmir Fakkri ###############
#---------------------------------------------------------#
###########################################################

###########################################################
# Section 1: Data Manipulation
###########################################################

# 1.1 install the package
install.packages("ggplot2")

# load the library
library(ggplot2)

# load the dataset
data(diamonds)
diamonds

# 1.2 command to access dataset description
?diamonds

# 1.3 best.colour dataframe containing only the diamonds with colour D
best.colour <- diamonds[which(diamonds$color=='D'),]

# 1.4 best.colour by carat and then by price
best.colour <- best.colour[, c(1, 7, 2, 3, 4, 5, 6, 8, 9, 10)]

# both in decreasing order
best.colour <- best.colour[order(-best.colour$carat, -best.colour$price), ] 

# 1.5 remove column colour 
best.colour <- best.colour[-c(4)]

# save in .csv
write.csv(best.colour, 'azmirfakkri.csv')

# 1.6 rows and variables
nrow(best.colour) 
ncol(best.colour)

# 1.7 countE and test
# for loop (attempt)
x <- diamonds$color[1:50]
num <- 0
for (var in x) {
  if(var=="E") {
    print(var)
    num = num + 1
  }
  if(num==50) break
}
# function countE (attempt)
countE <- function(n) {
  
  x <- diamonds$color
  num <- 0 
  for(var in x) {
    if(var=="E") {
      print(var)
      num = num + 1
    }
    if(num==n) break
  }
  return(x)
}

# 1.8 countE.and.SI2

###########################################################
# Section 2: Data Analysis
###########################################################

# 2.1 size of the most expensive diamond
diamonds_price <- diamonds[ , c(7, 8, 9, 10, 5, 1, 2, 3, 4, 6)]
diamonds_price <- diamonds_price[order(-diamonds_price$price), ]
diamonds_price[1, c(1, 2, 3, 4)]

# 2.2 size of diamond which costs USD 1344
x <- diamonds_price$price == 1344
diamonds_price[x,]

# 2.3 7 most expensive Ideal cut
head(subset(diamonds_price, diamonds_price$cut == "Ideal"), n=7)

# 2.4 number of diamonds of Ideal cut, best colour and best clarity
ideal <- subset(diamonds_price, diamonds_price$cut == "Ideal")
best <- table(ideal$color, ideal$clarity)
best["I", "IF"]

# 2.5 table of frequency
freq_tbl <-table(diamonds$clarity, diamonds$color)
max(freq_tbl)
###### Another line of code to print the combination names ##########

# 2.6 probability, answer rounded to 4 decimal places 
round(nrow(subset(diamonds, clarity == "VS1" & color == "F")) / nrow(diamonds), 4)
