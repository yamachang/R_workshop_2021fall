##################################################################
# Date: Sept 24, 2021
# Instructor: Yama Chang
# Course: Data Science in R
# Topic: Data Visualization - session 3
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


### Data Wrangling 2 ###
# Recap
# Import file
df <- read_csv("./data/df_rworkshop_p3.csv")
# If I want a new data frame including certain columns: `ID`, `group`, `gender`, `age`, `ham16`. What can I do?
df1 <- select(df, ID, group, gender, age, ham16)
# If I only want my df including ATT but no pts in other groups? 
df1 <- filter(df1, group == "ATT")


#--- mutate: to change them or create new ones ---#
?mutate
# the first argument to `mutate` is the data frame you’re filtering; all subsequent: new variables =function(old variable)
# mutate(your_data_frame,
#        new_var_name = fun(old_var_name, function_arguments))
df <- mutate(df,
             gender = recode(gender, `1` = "Female", `2` = "Male")) # We want to change variable item name, so we can use mutate to `recode` the item. If we use the same variable name, it can overwrite the original variable.
library(lubridate)

df <- mutate(df, 
             ssi_mean = (ssi_worst + ssi_current)/2) # By enter a new variable name, we can save the change in a new variable.

# Now take a look at df's last column. New variables appear at the end of the dataset in the order that they are created.

df <- mutate(df, 
             ssi_mean = (ssi_worst + ssi_current)/2, # We can change several columns by separating with coma
             gender = recode(gender, `1` = "Female", `2` = "Male"))

# Now take a look at df's gender` column

#--- arrange: to arrange the order of the rows in your data according to the values in one or more columns ---#
?arrange
# the first argument to `arrange` is the data frame you’re selecting; all subsequent arguments are columns you want to arrange
# arrange(your_data_frame, column_you_want_1, column_you_want_2, column_you_want_3, etc)

# Now I want to arrange my df by age. By default the order is ascending.
arrange(df, age) # the smallest is 60 years age

# What if I want a descending order? add desc() to the variable
arrange(df, desc(age))

# You can arrange the order by more than one variable
arrange(df, age, ham16) # arrange by younger age and lower ham

arrange(df, age, desc(ham16)) # arrange by younger age and higher ham


#--- piping: to pass the result of one function call as an argument to the next function call ---#
# An example of data cleaning: overwrite data at each stage
df1 <- select(df, ID, group, gender, age, ham16)
df1 <- filter(df1, group == "ATT")
df1 <- arrange(df1, desc(ham16))
df1 <- mutate(df1, 
              gender = recode(gender, `1` = "Female", `2` = "Male"))
# This method clutters our workspace. Any tidier way?
# Piping (%>%) solves this problem. 
# Try Shift+Command+M
# It creates a sequential chain by passing the result of one function call as an argument to the next function call
# Same example but applying piping
df1 <- df %>% # First, we always tell R what data frame we're cleaning/woring
  select(ID, group, gender, age, ham16) %>% # Piping is now passing the df as an argument to `select()`. We don't need to write df as the first argument anymore.
  filter(group == "ATT") %>% # Piping again is passing your df with select certain columns as an argument to `filter()`
  arrange(desc(ham16)) %>% # Again, we oon't need to write df as the first argument
  mutate(gender = recode(gender, `1` = "Female", `2` = "Male")) # Yay, we've completed a sequential codes and it looks clean!


### Data Visualization ###
# Exploratory data analysis (EDA): applying data visualization method to analyze data sets and summarize their main characteristics 
# We will use ggplot() which is a plotting function in tidyverse
# We will be using the same data frame to practice data visualization so let's read it again (since we've made some changes on it.)
# We're calling it protect_df this time

# We will be working with NOAA (National Oceanic and Atmospheric Administration) weather data, which is downloaded using rnoaa::meteo_pull_monitors function in the code below.
install.packages("rnoaa") # install rnoaa package to get this data
library(rnoaa)
#More about rnoaa package: https://docs.ropensci.org/rnoaa/
# Get the data set by running these codes
weather_df <- 
  rnoaa::meteo_pull_monitors(
    c("USW00094728", "USC00519397", "USS0023B17S"),
    var = c("PRCP", "TMIN", "TMAX"), 
    date_min = "2017-01-01",
    date_max = "2017-12-31") %>%
  mutate(
    location = recode(
      id, 
      USW00094728 = "CentralPark_NY", 
      USC00519397 = "Waikiki_HA",
      USS0023B17S = "Waterhole_WA"),
    tmin = tmin / 10,
    tmax = tmax / 10) %>%
  select(location, id, everything())

weather_df # Take a quick look at this data frame. How many rows and what column it has?
# location = location of weather data collection
# id = location id
# date = date of weather data collection
# prcp = abbreviation for precipitation
# tmin = minimum temperature
# tmax = maximum temperature

# Let's take a quick glance of this dataset
table(weather_df$location)
range(weather_df$date)
range(weather_df$prcp, na.rm = T) # if a column including NA, add na.rm = T when doing calculation like range, mean, sd, max etc

#--- Basic scatterplot ---#
# Layer 1: Name the data set - first, we need to tell R what data set we're working with

ggplot(data = weather_df)

# Layer 2: Then, we need to map variables to the X and Y coordinate aesthetics. 
# Meaning that we are creating a blank plot and tell R what's our X and Y variables

ggplot(weather_df, aes(x = tmin, y = tmax)) # Take a look at the Plots tab -->

# Layer 3: Third, we need to add geom to define the type of plot.

ggplot(weather_df, aes(x = tmin, y = tmax)) +
  geom_point() # geom_point() is used to create scatterplot which is useful for displaying two continuous variables

# Good styling practices: 
  # Add new plot elements on new lines
  # Code that’s part of the same sequence is indented
  # Use whitespace

#--- Advanced scatterplot ---#
# Also in layer 3: Let's give it some color using the color aesthetic

ggplot(weather_df, aes(x = tmin, y = tmax)) + # Same as before, we always need to create a blank map and tell your code what's your X and Y axis
  geom_point(aes(color = location)) # Now we're telling R: we want the point color based on column `names`

# Layer 4: Let's add a smooth curve to see the trend

ggplot(weather_df, aes(x = tmin, y = tmax)) + # Same as before, we always need to create a blank map and tell your code what's your X and Y axis
  geom_point(aes(color = location)) + # Now we're telling R: we want the point color based on column `names`
  geom_smooth(se = FALSE) # ?geom_smooth to see what does `se` mean here

# Hmmm the smooth line isn't clear enough, maybe make the point a bit transparent?

ggplot(weather_df, aes(x = tmin, y = tmax)) + 
  geom_point(aes(color = location), alpha = 0.5) + # alpha can change the level of transparency from 0 to 1
  geom_smooth(se = FALSE) 

# Now we got a sense about the relationship of our variables but there're some overlaps. 
# Layer 5: separate three location to three panels!

ggplot(weather_df, aes(x = tmin, y = tmax, color = location)) +
  geom_point(alpha = .5) +
  geom_smooth(se = FALSE) + 
  facet_grid(. ~ location) # facet_grid() creates panels and this gives us a vertical plot

# What if we don't want a vertical but want a horizontal plot?

ggplot(weather_df, aes(x = tmin, y = tmax, color = location)) +
  geom_point(alpha = .5) +
  geom_smooth(se = FALSE) + 
  facet_grid(location ~ .)

# Let's play around with this dataset to make it more informative
# See the relationship between year and maximum temperature in each location
# We can also change the size of points by the amount of precipitation

ggplot(weather_df, aes(x = date, y = tmax, color = location)) + 
  geom_point(aes(size = prcp), alpha = .5) +
  geom_smooth(se = FALSE) + 
  facet_grid(. ~ location) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + # rotate x-axis label to 45 degrees by angle = 45. Adjust the text location using hjust argument.
  theme(legend.position="left") +
  labs(x = "Date",
       y = "Max Temperature",
       title = "Weather Comparison of Three Site: NY, HA, WA",
       subtitle = Sys.Date(),
       caption = "Plot made by Yama Chang.") 

# What if I want to change legend name? Try to solve this by yourself. 
# Hint: *google*

#--- Histogram ---#

ggplot(weather_df, aes(x = tmax, fill = location)) + 
  geom_histogram(position = "dodge", binwidth = 2) # position = "dodge" places the bars for each group side-by-side

#--- Density plot ---#

ggplot(weather_df, aes(x = tmax, fill = location)) + # fill color using an aesthetic mapping
  geom_density(alpha = 0.4, adjust = 0.5, color = "blue") # adjust argument is like binwidth in histogram

#--- Box plot ---#

ggplot(weather_df, aes(x = location, y = tmax, color = location)) + 
  geom_boxplot()


### Save/export plot to your laptop ###
# 1. Assign as an object 

weather_plot <- ggplot(weather_df, aes(x = date, y = tmax, color = location)) + 
  geom_point(aes(size = prcp), alpha = .5) +
  geom_smooth(se = FALSE) + 
  facet_grid(. ~ location) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + # rotate x-axis label to 45 degrees by angle = 45. Adjust the text location using hjust argument.
  theme(legend.position="left") +
  labs(x = "Date",
       y = "Max Temperature",
       title = "Weather Comparison of Three Site: NY, HA, WA",
       subtitle = Sys.Date(),
       caption = "Plot made by Yama Chang") # Change to your name or citation or whatever caption you think that will be helpful for your reader

# 2. run the plot
weather_plot # run the plot

# 3. save the plot by ggsave()
ggsave("weather_plot.jpg", weather_plot, width = 8, height = 5) # you can also save for different format like pdf, png, tiff etc

# 4. you can also save for different format like pdf, png, tiff etc
ggsave("weather_plot.pdf", weather_plot, width = 8, height = 5)
ggsave("weather_plot.png", weather_plot, width = 8, height = 5)
ggsave("weather_plot.tiff", weather_plot, width = 8, height = 5)

# Congrats! Now we know how to make basic plots! Usually, we need to figure out what kind of info we want to see first and then decide what plot we want to see before actual plotting.


################# Learning assessments V #################
# Make a histogram that compare precipitation across locations. Use aesthetic mappings to make your figure readable.




# Save it as a pdf file



################# Learning assessments V #################

