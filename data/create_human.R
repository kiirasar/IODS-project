# 28 November 2022 and 30 November 2022
# Kiira Sarasjaervi - kiirasar
# PHD-302, Assignment 4 Data wrangling (5 points) and 5 Data wrangling (5 points)

################ ASSIGNMENT 4 ####################
# 1. Create a new R script called create_human.R

# 2. “Human development” (hd) and “Gender inequality” (gii) data **(1 point)**
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# 3. Structure, dimensions and summaries of the variables. **(1 point)**
dim(hd) # 195 row and 8 columns
str(hd) # the name of the columsn can be find below. One variable chr, others numeric variables.

dim(gii) # 195 row and 10 columns
str(gii) # the name of the columsn can be find below. One variable chr, others numeric variables.

# 4. Look at the meta files and rename the variables with (shorter) descriptive names. **(1 point)** 
library(dplyr)

# hd data:
# HDI Rank (HDI_R)                               : num [1:195] 1 2
# Country (Cntr)                                 : chr [1:195] "Norway" 
# Human Development Index (HDI)                  : num [1:195] 0.944 0.935 
# Life Expectancy at Birth (LEB)                 : num [1:195] 81.6 82.4 
# Expected Years of Education (YEdu)             : num [1:195] 17.5 20.2 
# Mean Years of Education (m_YEdu)               : num [1:195] 12.6 13 
# Gross National Income (GNI) per Capita         : num [1:195] 64992 42261 
# GNI per Capita Rank Minus HDI Rank (GNI_HDI_R) : num [1:195] 5 17 

hd2 = rename(hd, 
       HDIr = `HDI Rank`, 
       country = Country, 
       HDI = `Human Development Index (HDI)`, 
       LEB = `Life Expectancy at Birth`,
       Yedu = `Expected Years of Education`, 
       m_Yedu = `Mean Years of Education`,
       GNI = `Gross National Income (GNI) per Capita`,
       GNI_HDIr = `GNI per Capita Rank Minus HDI Rank`)
head(hd2) #sanity-check

# gii data:
# GII Rank  (GIIr)                             : num [1:195] 1 2 3
# Country (Cntr)                             : chr [1:195] "Norway" 
# Gender Inequality Index (GII)                 : num [1:195] 0.067 0.11 
# Maternal Mortality Ratio (MMR)                : num [1:195] 4 6 
# Adolescent Birth Rate (ABR)                   : num [1:195] 7.8 12.1 
# Percent Representation in Parliament (Parl_p) : num [1:195] 39.6 30.5 
# Population with Secondary Education (Edu2_F)  : num [1:195] 97.4 94.3 
# Population with Secondary Education (Edu2_M)  : num [1:195] 96.7 94.6
# Labour Force Participation Rate (LF_F)        : num [1:195] 61.2 58.8 
# Labour Force Participation Rate (LF_M)        : num [1:195] 68.7 71.8 

gii2 = rename(gii, 
            GIIr = `GII Rank`, 
            country = Country, 
            GII = `Gender Inequality Index (GII)`, 
            MMR = `Maternal Mortality Ratio`,
            ABR = `Adolescent Birth Rate`, 
            Parl_p = `Percent Representation in Parliament`,
            Edu2_F = `Population with Secondary Education (Female)`,
            Edu2_M = `Population with Secondary Education (Male)`,
            LF_F = `Labour Force Participation Rate (Female)`,
            LF_M = `Labour Force Participation Rate (Male)`)
head(gii2) #sanity-check

# 5. Mutate the “Gender inequality” (gii) data and create two new variables. 
library(dplyr)

gii2 = gii2 %>% 
  mutate(Edu2r = Edu2_F/Edu2_M) %>% #ratio of Female and Male populations with secondary education in each country.
  mutate(LFr = LF_F/LF_M) #ratio of labor force participation of females and males in each country
gii2 #if 1 ratio is the same, if <1 more male, if >1 more female %>% 

# 6. Join datasets: Gender inequality and Human development **(1 point)**
human2 <- inner_join(gii2, hd2, by = "country") # Country (Cntr) as the identifier
glimpse(human2) #195 observations (rows), 19 variables (columns) 

write_csv(human2, "C:\\Users\\Kiira\\Documents\\PhD_SWEMWBS\\PhD Courses\\Courses in 2022\\PHD-302 Open Data Science\\IODS-project\\data\\human2.csv")
human2 <- read_csv("data/human.csv")

# End of Assignment 4 - Data wrangling

################ ASSIGNMENT 5 ####################
library(readr)
human3 <- read_csv("data/human2.csv") #name my old human csv as human2

# 1. Mutate: Transform the Gross National Income (GNI) variable to numeric. (1 point)
library(dplyr)
library(stringr) # access the stringr package (part of `tidyverse`)

colnames(human3)
str_replace(human3$GNI, pattern=",", replace ="") #edit the format
human3$GNI <- gsub(",", "", human3$GNI) %>% as.numeric #change GNI as numeric

# 2. Keep: "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" (1 point)

colnames(human3) #check the column names

# "GIIr"     
# "GII"      
# "Edu2_F"  
# "Edu2_M"   
# "LF_F"     
# "LF_M" 
# "HDIr"     
# "HDI" 
# "m_Yedu"
# "GNI_HDIr"
# Country = country = Country 
# ratio of Female and Male populations with secondary education in each country = Edu2r = Edu2.FM   
# ratio of labor force participation of females and males in each country = LFr = Labo.FM      
# Expected Years of Education = "Yedu" = "Edu.Exp"   
# Life Expectancy at Birth = "LEB" = "Life.Exp" 
# Gross National Income (GNI) per Capita = GNI = GNI
# Maternal Mortality Ratio = MMR = Mat.Mor 
# Adolescent Birth Rate = ABR = Ado.Birth
# Percent Representation in Parliament = Parl_p = Parli.F

keep <- c("country", "Edu2r", "LFr", "Yedu", "LEB", "GNI", "MMR", "ABR", "Parl_p")
human3 <- select(human3, one_of(keep)) # select the 'keep' columns
glimpse(human3)

# 3. Remove missing values (1 point).
complete.cases(human3) # print out a completeness indicator of the 'human3' data (FALSE = missing value)
human3 = data.frame(human3, comp = complete.cases(human3)) # add completeness indicator to dataframe
table(human3$comp)["TRUE"] #count how many TRUE complete cases we have, n=162
human3 <- filter(human3, complete.cases(human3)) # remove missing values
glimpse(human3) #sanity check, 162 observations, 10 columns

# 4. Remove observations related to regions. (1 point)
tail(human3,10) #Chad, Central African Republic, Niger, Arab States, East Asia and the Pacific, Europe and Central Asia, Latin America and the Caribbean, South Asia, Sub-Saharan Africa, World
rownames(human3) <- human3$country
last <- nrow(human3) - 7 #delete the regions (last 7 rows)
glimpse(human3)

# 5. Define rows by the country and remove the country.
human_final <- human3[1:last, ]
human_final <- select(human_final, -country&-comp)

# The data should now have 155 observations and 8 variables. 
View(human_final)
glimpse(human_final)

# Save the human data in your data folder including the row names. (1 point)
write_csv(human_final, "C:\\Users\\Kiira\\Documents\\PhD_SWEMWBS\\PhD Courses\\Courses in 2022\\PHD-302 Open Data Science\\IODS-project\\data\\human_final.csv")
human_final <- read_csv("data/human_final.csv")

