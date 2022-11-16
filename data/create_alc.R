# Kiira Sarasjärvi - kiirasar
# 16 November 2022
# PHD-302 Assignment 3 - Data wrangling (max 5 points)

# 1. Download the zip file. https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# 2. create "create_alc.R" script

# 3. read student-mat.csv and student-por.csv. Exlore the structure and dimensions. (1 point)

# From IODS-project.
# I already downloaded the data from the website and moved into my IODS-project.
# I had a quick look at the data sets (raw csv version). Instead of "," the separator is semicolon (;).

library(readr) #activate the package, so you can use read_csv or read_delim commands.
std_mat <- read_delim("data/student-mat.csv", delim = ";") # Use read_delim() command instead, since delim= defines the separators.
std_por <- read_delim("data/student-por.csv", delim = ";")

head(std_mat) # see the first 5 rows of the data set
head(std_por)
View(std_mat) # see the whole data set
View(std_por)

dim(std_mat) # student-mat dataset has 395 rows (participants/observations/data points) and 33 columns (variables) 
dim(std_por) # student-por has 649 rows (participants/observations/data points) and 33 columns (variables) 

str(std_mat)
str(std_por) 
# first variable is school, last G3. 17 variables are chr, and the rest numeric. 
# more detailed descriptions of the variables can be found here: https://archive.ics.uci.edu/ml/datasets/Student+Performance

colnames(std_mat); colnames(std_por) # the 2 datasets have same variables

# Another option is to use the code in Exercise 3.
# For math students
url <- "https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/"
url_math <- paste(url, "student-mat.csv", sep = "/") # web address for math class data
url_math # print out the address
math <- read.table(url_math, sep = ";" , header = TRUE) # read the math class questionnaire data into memory

head(math) # the first 5 rows matches with std_mat.
View(math) # the dataset matches with std_mat.
dim(math) # dimensions matches: 395 rows and 33 variables
str(math) # structure matches the std_mat.

# For Portuguese class
url_por <- paste(url, "student-por.csv", sep = "/") # web address for Portuguese class data
url_por
por <- read.table(url_por, sep = ";" , header = TRUE) # read the por class questionnaire data into memory

head(por) # the first 5 rows matches with std_por
View(por) # the dataset matches with std_por
dim(por) # dimensions matches: 649 rows and 33 variables
str(por) # structure matches the std_por.

# 4. Join the two datasets together. Keep failures, paid, absences, G1, G2, G3. Explore structure and dimensions. (1 point)

library(dplyr) # to access the library

free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3") # the columns names that vary in the two data sets
free_cols # it just creates a vector of the column names.

join_cols <- setdiff(colnames(por), free_cols) # the rest of the columns are common identifiers used for joining the data sets
join_cols # column names that does not exist in both objects. Only the identificators remain (exclude free_cols)
               
math_por <- inner_join(math, por, by = join_cols) # join the two data sets by the selected identifiers

View(math_por) # we are end up with all identificators and individual columns. 

dim(math_por) 
# 370 rows/observations/participants. These only include the students who participated both math and portugese studies.
# 39 colums (which 27 identificators and 12 failures, paid, absences, G1, G2, and G3)

str(math_por) # all identificators, and special colums for failures, paid, absences, G1, G2, and G3. Those ending in .x are for math, whistl .y are for Portuguese
# For example, absences.x = abseces in math class, and absences.y = absences in Portuguese class.

math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por")) # to change .x and .y to .math and .por
str(math_por) # you can see that all .x and .y -ending variables are changes to .math and .por, respectively. 



# 5. Get rid of duplicates (1 point)

# a) copy the solution from the exercise "3.3 The if-else structure" to combine the 'duplicated' answers in the joined data 
alc <- select(math_por, all_of(join_cols)) # create a new data frame with only the joined columns
View(alc) # the other variables from free_cols are gone. To check this try to search some joined and free variables.
alc$G1.por # NULL
alc$sex # prints out all the observations

# if-else structure from Exercise 3.3
for(col_name in free_cols) { # goes through column names in free_cols "failures", "paid", "absences", "G1", "G2", "G3"  
  two_cols <- select(math_por, starts_with(col_name)) # matches two columns from 'math_por' dataset with the same original name; e.g., G1 or paid
  first_col <- select(two_cols, 1)[[1]] # selects the first column vector of those two columns, aka .math ending
  if(is.numeric(first_col)) { # if that first column vector is numeric (failures, absences, G1, G2, G3)
    alc[col_name] <- round(rowMeans(two_cols)) # counts and adds the rounded average of each row of the two columns to the new alc data frame
    # in other words it averaged the failures, absences, G1, G2, and G3 between .math and por values
  } else { # if not numeric (paid), add the first column vector (.math) to the alc data frame
    alc[col_name] <- first_col
  }
}

# sanity-check: check if it worked
glimpse(alc) # 370 rows/observations/participants, 33 columns/variables. The .math and .por ending variables are .

#########################
# QUESTION: What if the "paid" variable differs between .math and .por variables?
#  else {
#        alc[col_name] <- first_col
# 
# This bit of the code only adds the first column vector (.math) to the alc data frame.
#
# you can test this with identical() command
identical(math_por$paid.math,math_por$paid.por) #FALSE
# the variables seem to differ. paid = extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
# now the alc dataframe only contains information if the participant paid for math class, not Portuguese.
#########################

# 6. Create a new column (alc_use & high_use) (1 point)
# alc_use = average of weekday and weekend alcohol consumption 
# high_use = logical column which is TRUE when 'alc_use' is greater than 2 (and FALSE otherwise)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2) # mutate() creates a new mean column called "alc_use" by averaging weekday and weekend alcohol use.
# you can also do this by using rowMeans()-function
alc$test_alc_use <- rowMeans(alc[c('Dalc', 'Walc')])
identical(alc$alc_use, alc$test_alc_use) # TRUE
alc <- alc[ -c(35)] #remove the last column: test_alc_use

alc <- mutate(alc, high_use = alc_use > 2) # define a new logical column 'high_use'


# 7. Glimpse - 370 observations & save the dataframe as csv to data-folder (1 point)

glimpse(alc) # 370 observations, 35 columns
write_csv(alc, "C:\\Users\\Kiira\\Documents\\PhD_SWEMWBS\\PhD Courses\\Courses in 2022\\PHD-302 Open Data Science\\IODS-project\\data\\create_alc_KS.csv")
# saved as create_alc_KS.csv
