##################################################################
# Date: Sept 10, 2021
# Instructor: Yama Chang
# Course: Data Science in R
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
  x - 2
  # Assign with different values
  x <- 5 + 7 # You assigned 5 + 7 (=12) to x. You just stored 12 to x. We could also say that x is stored with a value 12 in your environment.
  x # R don't show object while you assign them a value. Run the object to show the value (e.g., a numeric value, a character string, a data frame, or a plot)
  y <- x / 3
  y
  z <- x + y
  z
  # combination
  a <- c(x, y, z) # A combination can store everything you want in an object
  a
  b <- c(x, x, x)
  b
  length(a)
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
  myHometown <- "Taiwan"
  myHometown
  
# Create a sequence of 1, 4, 7, 10 using seq() and store as mySequence 
  mySequence <- seq(from=1, to=10, by=3)
  mySequence
  
################# Learning assessment I #################
  
  
  