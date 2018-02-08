###########################################################
#---------------------------------------------------------#
################ Assignment 2: Azmir Fakkri ###############
#---------------------------------------------------------#
###########################################################

###########################################################
# Section 1: Data Visualisation I
###########################################################

# 1.1 load MASS and access dataset
library(MASS)
data(quine)
quine

# 1.2 access dataset description 
?quine

# 1.3 create 2 histograms on a single panel
# subset
Ab <- subset(quine, quine$Eth=="A")
NAb <- subset(quine, quine$Eth=="N")

# creating histogram
par(mfrow = c(1, 2))
hist(Ab$Days)
hist(NAb$Days)

# 1.4 improve the histograms
par(mfrow = c(1, 2), las = 1)

# improved histogram for Aboriginal
hist(Ab$Days, breaks = 20, 
     xlab = "No. of days (Aboriginal)", xaxt = 'n',
     main = NULL, col = "tomato1", ylim = c(0, 35),
     xlim = c(0, 90))
axis(side = 1, at = seq(0, 90, by = 10), labels = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90))

# improved histogram for non-Aboriginal
hist(NAb$Days, breaks = 20,
     xlab = "No. of days (Non Aboriginal)",
     main = NULL, col = "slateblue1", ylim = c(0, 35),
     xlim = c(0, 90))
axis(side = 1, at = seq(0, 90, by = 10), labels = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90))

# main title 
mtext("Histogram of Student Absenteeism", side = 3, line = -2, 
      outer = TRUE, font = 2, cex = 1.5)

# 1.5 evidence of difference - refer to pdf document 

###########################################################
# Section 2: Data Visualisation II
###########################################################

# 2.1 load MASS, access dataset crabs, read help file
library(MASS)
data(crabs)
?crabs

# 2.2 two boxplots on a single panel
par(mfrow = c(1, 2), las = 1)

# boxplot for rear width by sex
boxplot(crabs$RW ~ crabs$sex, xaxt = 'n', main = "Rear width of crabs by Sex",
        ylab = "Rear width (mm)", xlab = "Sex", col = c("pink", "green"))
axis(1, at = 1:2, labels = c("Female", "Male"))

# boxplot for rear width by species
boxplot(crabs$RW ~ crabs$sp, xaxt = 'n', main = "Rear width of crabs by Species",
        ylab = "Rear width (mm)", xlab = "Species", col = c("blue", "orange"))
axis(1, at = 1:2, labels = c("Blue", "Orange"))

# 2.3 refer pdf

# 2.4
dev.off()
par(mfrow = c(1,1), las = 1)

boxplot(crabs$RW[crabs$sp == "B" & crabs$sex == "F"], 
        crabs$RW[crabs$sp == "B" & crabs$sex == "M"], 
        crabs$RW[crabs$sp == "O" & crabs$sex == "F"], 
        crabs$RW[crabs$sp == "O" & crabs$sex == "M"],
        xaxt = 'n', main = "Rear width of crabs by Species & Sex",
        ylab = "Rear width (mm)", xlab = "Crabs",
        col = c("turquoise", "blue1", "orange1", "orangered2"))
axis(1, at = 1:4, labels = c("BF", "BM", "OF", "OM"))
legend("topright", title = "Crabs",
       c("BF = Blue sp., Female","BM = Blue sp., Male","OF = Orange sp., Female", "OM = Orange sp., Male"),
       fill = c("turquoise", "blue1", "orange1", "orangered2"), cex = 0.8)

###########################################################
# Section 3: Programming Structures
###########################################################

# 3.1 while() loop
x <- 2
y <- 10

while(x < 40 & y < 1000) {
  print (x + y)
  x <- x^2
  y <- y^2
}

# 3.2 Matrix
# create matrix 45 x 55
matrix ()

# 3.3 repeat loop 
i <- 1
repeat {
  print(i)
  i <- i*2
  if (i > 100) break
}