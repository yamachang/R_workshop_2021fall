##################################################################
# Date: Sept 17, 2021
# Instructor: Yama Chang
# Course: Data Science in R
# Topic: Data wrangling - session 2
##################################################################
getwd()
setwd("/Users/yama/Desktop/Protect/GitHub/R_workshop_2021fall") # set your working directory to your R workshop folder

library(tidyverse) # we need to load all the package we're going to use everytime 
# ── Attaching packages ──────────────────────────────── tidyverse 1.3.1 ──
# ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
# ✓ tibble  3.1.4     ✓ dplyr   1.0.7
# ✓ tidyr   1.1.3     ✓ stringr 1.4.0
# ✓ readr   2.0.1     ✓ forcats 0.5.1
# ── Conflicts ─────────────────────────────────── tidyverse_conflicts() ──
# x dplyr::filter() masks stats::filter()
# x dplyr::lag()    masks stats::lag()


# ---------------------------- Data Structure ---------------------------- #
# Vectors: vector is a basic data structure in R. It contains element of the SAME TYPE. The data types can be logical, integer, double, character, complex or raw.
# Array & Matrix: Matrix is a special kind of vector. A matrix is a vector with two additional attributes: the number of rows and the number of columns. Arrays can have more than two dimensions.
# Lists: Lists are ordered collections of objects, where the elements can be of a different type (a list can be a combination of matrices, vectors, other lists, etc.) They are created using the list() function:
# Data Frames (most important structure in R): Data frame is a two dimensional (row and column) data structure in R. It can store different types of columns.
# List components must be vectors (numeric, character or logical vectors), factors, numeric matrices or other data frames.
# Vectors, which are the variables in the data frame, must be of the same length.
#  It is a special case of a list which has each component of equal length.


#--- Matrices ---#
m1 <- matrix(1:12, nrow=3, ncol=4) # define a matrix with 3 rows and 4 columns
m1
# The elements of vectors and matrices are recycled when it is required by the involved dimensions
m2 <- matrix(1:8, nrow=4, ncol=4) # create a matrix with 4 rows and 4 columns
m2 

#--- Array ---#
a1 <- array(1:24, dim=c(2,3,4)) # value from 1 to 24; this array contains 2 row, 3 columns, 4 dimensions 
a1

#--- Lists ---#
lab <- list(name="protect", boss=c("Kati","is","the","boss"), staff=10, colours=c(1.5,2.5))
lab
length(lab) # check how many elements 'lab' has
names(lab)  # return `lab` names
lab$boss    # using dollar sign to select a vector
lab$staff
lab$name

### Data Frames and data types
# In addition to numbers, R can handle a variety of other data types. 
# To demonstrate, I'll make a short data frame with the `tibble` function and manually check the class of some of the variables. 
# This is also an excellent moment to highlight RStudio's tabbed autocompletion — start entering a variable name and click Tab.

example_df = tibble(
  vec_numeric = 5:8,
  vec_char = c("Our", "lab", "is", "Protect"),
  vec_logical = c(TRUE, TRUE, TRUE, FALSE),
  vec_factor = factor(c("Monday", "Tuesday", "Saturday", "Sunday"), levels = c("Monday", "Tuesday", "Saturday", "Sunday"), labels = c("weekday", "weekday", "weekend", "weekend"))
)

example_df  

?factor

levels(example_df$vec_factor)  # show factor level

class(example_df$vec_numeric)  # show data type of a column
class(example_df$vec_char)
class(example_df$vec_logical)
class(example_df$vec_factor)

str(example_df) # display the internal structure of an R object

data(mtcars) # here is a built-in data frame in R, called mtcars
View(mtcars) # View the data frame
?mtcars      # What's in this built0in data frame?
str(mtcars) # display the internal structure of an R object

################# Learning assessments II #################
# calculate number of parts by adding Number of forward gears AND Number of carburetors for each type of cars



# store this number of parts as a new column in mtcars



# find the mean, standard deviation, min, and max value of the number of parts



################# Learning assessments II #################


# ---------------------------- Data Wrangling ---------------------------- #
# Now we have learned that data frame is an important data structure in R, but does data frame always look like the way we want? 
# Most of times, raw data could be messy and we need to tidy it and transform to a clean data frame. The process is called data wrangling/manipulation.

### Import data frame: We always need to import data frame for different purpose. There are two types of path:
# Absolute path 
getwd() 
# Relative path (portable, recommended)
# "./data/df_rworkshop_p3.csv" 
# We prefer to use relative path to get the data so other people can use it too.

# Save the file in a "data" folder in your folder/working directory where we are going to import this data
read_csv("./data/df_rworkshop_p3.csv")

# Has this shown in your environment? What do you need to do to show this in your environment?
df <- read_csv("./data/df_rworkshop_p3.csv")

# Awesome! You just imported a data frame called `df` and saved it in the environment! 
# Let's take a look at this data frame. One way is to clich `df` in your environment, the other way is to use `View()` to view this data frame.
View(df)

# Let's play around a larger data set
str(df)  # data structure
dim(df)  # dimension: rows and columns
names(df) # column names
head(df)  # head of df
tail(df)  # tail of df

# df[row, column]
df[1, 2] # Return the element at the first row & second column

# the magic of $ (dollar sign)
#--- select an column in a data frame ---#
df$age
sd(df$age) # we can calculate standard deviation of a specific column using dollar sign
mean(df$age)

#--- useful function to check an column in a data frame ---#
# counting numbers of items in a column
table(df$group) 
table(df$group, df$gender) # 2 x 2 groups

# get the class of each column
class(df$group)
class(df$consent_date)
class(df$gender)

# summary of a column
summary(df$age) # numeric variable
summary(df$group) # character variable

# check NA in a column
anyNA(df$height) # return logical value
anyNA(df$ID) # return logical value

#--- add an column to a data frame ---#
df$newcolumn <- 1 # add a new column called `newcolumn` with value 1 
View(df)

# Another helpful function to examine a data frame
# Need to install first. Remember how to install a new package? 
skimr::skim(df) # package name::function() 

### Data manipulation: clean and organize data using `dplyr` verbs and piping in `tidyverse` package
#--- `select`: use to extract COLUMNS you need ---#
?select
# the first argument to `select` is the data frame you’re selecting; all subsequent arguments are columns you want
# select(your_data_frame, column_you_want_1, column_you_want_2, column_you_want_3, etc)
names(df) # take a look at all columns in this df and decide which one you want to select
df1 <- select(df, ID, age, gender, race) # You can select the columns by specifying the column names
select(df, ID: race) # You can select the columns by specifying a range of columns using ":"
select(df, -ID, -consent_date) # You can remove columns you don't want anymore and keep the rest
select(df, ID, race, group, everything()) # You can select a few and keep every other columns by adding `everything()`
select(df, GrOuP = group, RACE = race, everything()) # You can rename columns names in this function

# Some handy helper functions `for select()`: starts_with(), ends_with(), matches(), everything()
?select_helpers
select(df, ID, starts_with("ssi")) # Extract ID & all columns starting with "ssi"
select(df, ID, ends_with("eight")) # Extract ID & all columns ending with "eight"
select(df, ID, matches("eight|ssi"))# Extract ID & all columns matching with "eight". This is helpful when you are selecting many columns with various similar column names (e.g., forms)
select(df, GrOuP = group, RACE = race, everything()) # You can rename, reorder, and keep every other columns by adding `everything()`


#--- filter: filter ROWS based on logical expressions ---#
?filter
# the first argument to `filter` is the data frame you’re filtering; all subsequent arguments are logical expressions
# filter(your_data_frame, logical expressions) 
# remember some logical operators (TRUE/FALSE) we talked about in the first session? 
5 < 7 # T or F?
5 > 7 # T or F?
5 == 7 # Equality
5 != 7 # not equal
5 | 7 # or
5 & 7 # and

# Let's practice 
df_60 <- filter(df, age>60) # Create a new data frame called df_60 by filtering everyone older than 60 years old
table(df_60$age) # take a look at the age distribution of this new data frame, now everyone in this data frame all aged older than 60

# Some ways you can filter p3 df 
filter(df, gender == 1) # filter all female (1) pts
filter(df, gender != 1) # filter anyone who is not female
filter(df, ham16 < 14) # filter anyone who has ham total score smaller than 14
filter(df, gender != 1)
filter(df, group == "DNA") # filter all DNA groups
filter(df, group %in% c("ATT", "DNA")) # %in%: filter more than one character items
filter(df, group == "ATT" & age >= 65) # filter attempters aged 65 and older

### Quick summary: what's the difference between using `select` and `filter`?



################# Learning assessments III #################
# In the `df` data, select the columns containing ID, group, ham, cirsg, and ssi current and worst scores, and save it as new data frame called `df_p3`



# In the `df_p3` data, filter depressed groups (anyone who's not healthy controls) with ham scores over 12, AND current ssi scores over 4, and save it as `df_p3_new`



# In the `df_p3` data, find the mean, standard deviation, min, and max value of cirsg score



################# Learning assessments III #################


#--- Use base R to change values in a variable ---#
# Let's take a look at all values in height and weight
table(df$height)
table(df$weight)

# What's wrong? Here's the data entry error (so I will ask clinicians to change it on REDcap)
# What if I need to change it in the data frame right away? 
# I can manually change the value one by one. (Still need to change it on REDcap to maintain data integrity.)
# bracket [] here is similar to `filter` we just learned
?gsub # to subsitute a pattern by a new pattern: gsub('current pattern', 'new pattern', df$column)

# First, some people ended height with ", but I hope to unify the format. Remember to assign it to your original column
df$height <- gsub('"', '', df$height)
# Let's take a look again 
table(df$height)
# Second, I wanted to change the value manually
df$height[df$height == 137] <- "5'10" # Just an example, need to refer to Redcap to get the right height
df$height[df$height == 165] <- "5'11"
df$height[df$height == 212] <- "5'2"
df$height[df$height == 175] <- "5'4"
df$height[df$height == 63] <- "6'3" # 63 is more like 6'3 because 63 doesn't make sense as weight
# Let's take a look again 
table(df$height) # Now all height has the same format

# Let's deal with weight. First
df$weight <- gsub('"', '', df$weight) # Remove " at the end first because we will use quotation mark later

df$weight[df$weight == "5'10"] <- 137 # Just an example, need to refer to Redcap to get the right height
df$weight[df$weight == "5'11"] <- 165
df$weight[df$weight == "5'4"] <- 212
df$weight[df$weight == "5'6"] <- 175
df$weight[df$weight == "5'2"] <- 163 

table(df$weight) # Now all weight has the same format


################# Learning assessments IV #################
# Convert height and weight to Metric Unit (cm in height)
df <- df %>% separate(height, c('feet', 'inches'), "'", convert = TRUE) # Separate height to two column as feet and inches so you can calculate 
# 1) Please convert height to cm and save it in a new variable called height_cm



# 2) Please convert height to kg and save it in a new variable called weight_kg



# 3) Calculate BMI and save it as a new column called `BMI` for each pt in df



# 4) Arrange this `df` data frame based on age (ascending order) and BMI (descending order)



################# Learning assessments IV #################



