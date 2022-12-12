# 5 November 2022
# Kiira Sarasjaervi - kiirasar
# PHD-302, Assignment 5 Data wrangling (5 points)


# 1 Load datasets and check variables (1 point)
library(readr)

#BPRS2
BPRS2 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
colnames(BPRS2) #columnnames of BPRS: treatment, subject and week0 to week8
str(BPRS2) #structure of BPRS: 40 observations (participants) and 11 variables, all integrals (numeric)
library(vtable)
st(BPRS2) #summaries of the variables
glimpse(BPRS2)

#RATS2
RATS2 <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t') 
colnames(RATS2) #columnnames of BPRS: ID, Group, WD1 to WD64
str(RATS2) #structure of BPRS: 16 observations (participants) and 13 variables, all integrals (numeric)
st(RATS2) #summaries of the variables
glimpse(RATS2)

# 2. Categorical variables to factors. (1 point)
# How do we know which ones are categorical?

#BPRS2
BPRS2$treatment <- factor(BPRS2$treatment)
BPRS2$subject <- factor(BPRS2$subject)
glimpse(BPRS2) #sanity-check first two variables are fct
#RATS2
RATS2$ID <- factor(RATS2$ID)
RATS2$Group <- factor(RATS2$Group)
glimpse(RATS2) #sanity-check first two variables are fct

# 3. Convert data sets to long form and add week to BPRS and Time to RATS. (1 point)

#BPRS2
BPRSL2 <-  pivot_longer(BPRS2, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs2") %>%
  arrange(weeks)
#RATS2
RATSL2 <-  pivot_longer(RATS2, cols = -c(ID, Group),
                       names_to = "Time", values_to = "rats2") %>%
  arrange(Time)

# 4.View new datasets and compare to wide form (2 points)
# Check the variable names, structure, summaries and view dataset

#BPRSL2
View(BPRSL2)
colnames(BPRSL2) #"treatment" "subject"   "weeks"     "bprs2" 
str(BPRSL2) #treatment and subject are factors, weeks (chr) and bprs (int) 
summary(BPRSL2) #treatment1 (n=180) and treatment2 (n=180)
glimpse(BPRSL2)
#In comparison to wide form, weeks are now long form, so each subject has several rows now (see subject numbers).
#For example, subject 1 has rows: 1, 21, 41, 61, 81, 101, 121, 141, 161, 181, 201, 221, 241, 261, 281, 301, 321, 341. 
#NOTE that subject 1 has both non-treatment (1) and treatment (2) values

#RATSL2
View(RATSL2)
colnames(RATSL2) #"ID"    "Group" "Time"  "rats2"
str(RATSL2) #ID and group are factors, Time (chr) and rats2 (int)
summary(RATSL2)
glimpse(RATSL2)
#In comparison to wide form, time is not in a long form. Each group has several rows.
#For example, each subject (ID) has several rows: 1, 17, 33, 49, 65, 81, 97, 113, 129, 145, 161

#Overall, wide format dos not repeat values, but each row is often individual subject/observation.

