# Kiira Sarasjaervi (kiirasar), 11 NOV 2022
# PHD-302, Assignment 2 - Data wrangling (5 p)


########################################################################################################
# Data wrangling (max 5 points)

library(dplyr)
library(GGally)
library(tidyverse)

########################################################################################################
## 1. Create a folder name "data" in your IODS-project folder.
# See R Markdown - picture regarding how to create a new folder.

########################################################################################################
## 2. Read the data into R and explore the dimensions and structure (1 point)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
head(lrn14)
View(lrn14)

dim(lrn14)
# Learning 2014 has 183 rows (participants) and 60 columns (variables: from Aa to gender)

str(lrn14)
# Learning 2014 data set has 183 observations (rows) and 60 variables (columns).
# All except 1 variable (gender=character) are integer-variables. Integer variables (Int) means variables that must take an integer value (0, 1, 2, ...). In other words, no decimal.
# Character variables (chr) are categorized variables that holds character strings, like F=female, M=male. The first variable is "Aa" and the last "gender".


########################################################################################################
## 3.  Create analysis data set (1 point)

# Create an analysis data set with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data.
head(lrn14) # Variables: Aa-Af, ST01-ST28, SU02-SU32, D03-D31, Ca-Ch, Da-Dj, Age, Attitude, Points, gender. Variables that don't need editing: gender, age, points

# Questions related to deep (Q_deep=D0), surface (Q_surf=SU) and strategic (Q_stra=ST) learning
Q_deep <- c("D03", "D06", "D07", "D11", "D14", "D15","D19", "D22", "D23", "D27", "D30", "D31")
Q_surf <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
Q_stra <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28") # NOTE. Nothing will be added to the data.frame just yet, we are just creating objects.

# Scale all combination variables to the original scales (**by taking the mean**).  
C_deep <- select(lrn14, one_of(Q_deep)) # select the columns (C_deep) related to deep learning (Q_deep)
lrn14$A_deep <- rowMeans(C_deep) # and create column 'A_deep' by averaging
C_surf <- select(lrn14, one_of(Q_surf)) # select the columns(C_surf) related to surface learning (Q_surf)
lrn14$A_surf <- rowMeans(C_surf) # and create column 'A_surf' by averaging
C_stra <- select(lrn14, one_of(Q_stra)) # select the columns(C_stra) related to strategic learning (Q_stra)
lrn14$A_stra <- rowMeans(C_stra) # and create column 'A_stra' by averaging
# The column `Attitude` in `lrn14` is a sum of 10 questions related to students attitude towards statistics (original scale 1-5). 
lrn14$A_att <- lrn14$Attitude / 10 # Scale the combination variable back to the 1-5 scale.

head(lrn14) # Sanity check: A_deep, A_surf, A_stra and A_att are added to the data.frame lrn14
View(lrn14)

# Keep Age, Points, A_deep, A_surf, A_stra and A_att and create new dataset called lrn14_KS
lrn14_KS <- lrn14[, c("gender","Age","A_att", "A_deep", "A_stra", "A_surf", "Points")] # 7 variables
colnames(lrn14_KS)[2] <- "age" # change the 2nd column name, which is "Age" to "age"
colnames(lrn14_KS)[7] <- "points" # change the 7th column name from "Points" to "points". 
# Exclude observations where the exam points variable is zero
lrn14_KS <- filter(lrn14_KS, points > 0) # 166 observations
# (The data should then have 166 observations and 7 variables) 
dim(lrn14_KS) # sanity check: 166 observations and 7 varibles

########################################################################################################
## 4. Set working directory (3 points)

install.packages('readr')
library(readr)

# Set the working directory of your R session to the IODS Project folder (study how to do this with RStudio).
setwd('C:\Users\Kiira\Documents\PhD_SWEMWBS\PhD Courses\Courses in 2022\PHD-302 Open Data Science\IODS-project')

# Save the analysis data set to the ‘data’ folder, using for example write_csv() function (readr package, part of tidyverse).  
?write_csv()
write_csv(lrn14_KS, "C:\\Users\\Kiira\\Documents\\PhD_SWEMWBS\\PhD Courses\\Courses in 2022\\PHD-302 Open Data Science\\IODS-project\\data\\lrn14_KS.csv")
# using "\\" you will avoid the following error message: Error: '\U' used without hex digits in character string starting "'C:\U"

# Demonstrate that you can also read the data again by using read_csv(). 
# (Use `str()` and `head()` to make sure that the structure of the data is correct).  
?read_csv()
lrn14_KS <- read_csv("data/lrn14_KS.csv")

View(lrn14_KS)
str(lrn14_KS) #166 rows (observations) 7 columns (variables)
head(lrn14_KS) #gender, age, Averages of; attitude (A_att), deep (A_deep), stra (A_stra), surf (A_surf), and points