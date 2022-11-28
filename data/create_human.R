# 28 November 2022
# Kiira Sarasjaervi - kiirasar
# PHD-302, Assignment 4 Data wrangling (5 points)

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

hd = rename(hd, 
       HDIr = `HDI Rank`, 
       Cntr = Country, 
       HDI = `Human Development Index (HDI)`, 
       LEB = `Life Expectancy at Birth`,
       Yedu = `Expected Years of Education`, 
       m_Yedu = `Mean Years of Education`,
       GNI = `Gross National Income (GNI) per Capita`,
       GNI_HDIr = `GNI per Capita Rank Minus HDI Rank`)
head(hd) #sanity-check

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

gii = rename(gii, 
            GIIr = `GII Rank`, 
            Cntr = Country, 
            GII = `Gender Inequality Index (GII)`, 
            MMR = `Maternal Mortality Ratio`,
            ABR = `Adolescent Birth Rate`, 
            Parl_p = `Percent Representation in Parliament`,
            Edu2_F = `Population with Secondary Education (Female)`,
            Edu2_M = `Population with Secondary Education (Male)`,
            LF_F = `Labour Force Participation Rate (Female)`,
            LF_M = `Labour Force Participation Rate (Male)`)
head(gii) #sanity-check

# 5. Mutate the “Gender inequality” (gii) data and create two new variables. 
library(dplyr)

gii = gii %>% 
  mutate(Edu2r = Edu2_F/Edu2_M) %>% #ratio of Female and Male populations with secondary education in each country.
  mutate(LFr = LF_F/LF_M) #ratio of labor force participation of females and males in each country
gii #if 1 ratio is the same, if <1 more male, if >1 more female %>% 

# 6. Join datasets: Gender inequality and Human development **(1 point)**
human <- inner_join(gii, hd, by = "Cntr") # Country (Cntr) as the identifier
glimpse(human) #195 observations (rows), 19 variables (columns) 

write_csv(human, "C:\\Users\\Kiira\\Documents\\PhD_SWEMWBS\\PhD Courses\\Courses in 2022\\PHD-302 Open Data Science\\IODS-project\\data\\human.csv")
human <- read_csv("data/human.csv")

# End of Assignment 4 - Data wrangling