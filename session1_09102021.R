##################################################################
# Sept 10, 2021
# Yama Chang
#
# Topic: Introduction to R - session 1
##################################################################

### R vs R studio
# R is a programming language
# RStudio is an integrated development environment (IDE) for R. 
  # Left top: code editor/scripts - where commands are saved for reproducibility
  # Left bottom: console - where commands are executed
  # Right top: workspace and history
  # Right bottom: files, plots, packages installation, and help 

### Some basics
# Create a new R script
  # File → New Files → R Script

# Run code: 
  # Command + enter (Mac) 
  # Ctrl + enter (Windows)
  
# Install packages - collections of functions and data sets developed by the R user community
  # Only need to install once in your environment
  install.packages("tidyverse") # try to run your first code!
# Load packages - 
  # Need to load every time in your environment
  library(tidyverse)
# Help with packages and functions - 
  # Type `?functionname` or `help("any function name")` at console and click Enter
  # Practice: type ?ggplots at console and click Enter
  # Practice: type help("ggplot2")

### Working Directory - where you store this project/script/data/plot
# Remember to check your working directory or set to your preferable working directory to manage your files
  getwd()
  setwd("/Users/yama/Box/Yama/R workshop") # Change to your path

### Computation: operation and objects
# Computation 
  # arithmetic operators
  5 + 7 
  5 - 7
  5 * 7
  5 / 7
  5 ^ 7
  
  (18/6 + 6*2) ^ (7 - 5) - 3.1415926
  # What if you only fun the highlight/part of the code?

  # logical operators - TRUE/FALSE
  5 < 7 # T or F?
  5 > 7 # T or F?
  5 = 7 # T or F? Well R actually thinks one equal sign as assigning a value
  
  5 == 7 # Equality
  5 != 7 # not equal
  5 | 7 # or
  5 & 7 # and

# Objects: Assign value to an object which can be a numeric value, a character string, a data frame, or a plot!
  # There are several ways to assign values to a variable
  x = 5 # assign a value to a vector with only one element
  x <- 5
  5 -> x
  y <- "Hello World!" # You can also assign character value to an object
  y
  
  # Assign with different values
  x <- 5 + 7 # You assigned 5 + 7 (=12) to x. You just stored 12 to x. We could also say that x is stored with a value 12 in your environment.
  x # R don't show object while you assign them a value. Run the object to show the value (e.g., a numeric value, a character string, a data frame, or a plot)
  y <- x / 3
  y
  z <- x + y
  z
  # combination
  a <- c(x, y, z) # A conbination can store everything you want in an object
  a
  b <- c(x, x, x)
  b

  c <- a * b # You can also calculate the same length of combinations
  c
  # functions: You can also apply functions to objects
  d <- mean(a)
  d
  e <- sd(a)
  e
  
  # To generate a sequence:
  1:10
  10:1
  seq(from=1, to=10, by=2)
  seq(1, 10, 2)
  seq(length=10, from=1, by=2) # generate a fixed length sequence
  help(seq) # for help with this function
  
################# Learning assessment I #################
# Create an object called myHometown and assign your hometown as your value

  
  
# Create a sequence of 1, 4, 7, 10 using seq() and store as mySequence 

  
  
################# Learning assessment I #################
  
  
### Data Structure
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
  
  # Let's play around a larger data set
  data(mtcars) # here is a built-in data frame in R, called mtcars
  View(mtcars) # View the data frame
  ?mtcars      # What's in this built0in data frame?
  str(mtcars)  # data structure
  dim(mtcars)  # rows and columns
  names(mtcars) # column names
  head(mtcars)  # head of df
  tail(mtcars)  # tail of df
  
  # df[row, column]
  mtcars[1, 1] # Return the element at the first row & first column
  
  # the magic of $ (dollar sign)
  #--- select an column in a data frame ---#
  mtcars$hp
  sd(mtcars$hp) # we can calculate standard deviation of a specific column using dollar sign
  mean(mtcars$hp)
  
  #--- add an column to a data frame ---#
  mtcars$newcolumn <- 1 # add a new column called `newcolumn` with value 1 
  View(mtcars)
  
  # Another helpful function to examine a data frame
  # Need to install first. Remember how to install a new package? 
  skimr::skim(mtcars) # package name::function() 
  
  ################# Learning assessments II #################
  # calculate number of parts by adding Number of forward gears AND Number of carburetors for each type of cars
  
  
  
  # store this number of parts as a new column in mtcars
  
  
  
  # find the mean, standard deviation, min, and max value of the number of parts
  
  
  
  ################# Learning assessments II #################
  