##################################################################
# Date: Oct 8, 2021
# Instructor: Yama Chang
# Course: Data Science in R
# Topic: Data Analysis - session 4
##################################################################

# As usual, let's do some set up:
setwd("~/Desktop/Protect/GitHub/R_workshop_2021fall")
library(tidyverse)
library(corrplot) # for correlation 
library(psych)

# Load today's dataset
data <- read_csv("./data/s4_practice.csv") # Load a csv file I stored in a folder called "data" in my working directory
  

# Today, we'll go through basic inferential statistics which can be used to test our hypotheses.
# Ex. Whether higher depressive severity is associated with higher frequency of suicide attempt in late-life suicide?
# X: independent variables (IV) / predictor variables
# Y: dependent variable (DV) / outcome variables
# IV --> DV: If IV could predict DV
#  X --> Y : If X could predict Y

# In R, the we use this direction: Y ~ X: If X could predict Y

#--- 1. Correlation ---#
# Q: Whether MMSE score is associated with DRS subscales/total in late-life suicide?
# Let's take a look
plot(data$MMSE_score, data$drs_total)

# Correlation of X1, X2, X3 ...XN: `cor()`
# Select the variables we need
df_corr <- data[c("MMSE_score", "drs_total", "drs_attention", "drs_initandpers", "drs_construction", "drs_conceptualization", "drs_memory")]

# Let's take a look at correlation between variables
cor(df_corr, use = 'pairwise.complete.obs', method = "pearson")

# corr.test() gives us p-value of correlation
cor <- corr.test(df_corr,
                 use = "pairwise.complete.obs", method="pearson", alpha=.05)
# Plot it!
print(corrplot(cor$r, method="number", type="upper", # what if you change "circle" to "number"?
               p.mat = cor$p, sig.level=0.05, insig = "blank",
               order="hclust")) 

#--- 2. T-test ---#
# Compare TWO group difference
# Whether the (mean) differences between TWO groups of data are statistically significant?
# Q: Is there difference of HAM score between male and female? 

# Plot first!
boxplot(data$HAM_16 ~ data$Gender) # What does the dot mean? 

# Let's run a t-test to test 2 group difference
t.test(data$HAM_16 ~ data$Gender) # What's the p-value? 

# Q: Is there difference of pre-morbid IQ between pt with lifetime substance use hx
boxplot(data$wtar_s_adj ~ data$pres_curr_subs) 
t.test(data$wtar_s_adj ~ data$pres_curr_subs)



#--- 3. ANOVA (Analysis of variance) ---#
# Compare two and MORE group difference
# Whether the (mean) differences between 2 and MORE groups of data are statistically significant?
# Q: Is there difference of depression severity between suicidal attempters, ideators, and depressed group?

# Need to make the group as factor format (a categorical variable with levels)
data$Group <- as.factor(data$Group)
class(data$Group) # check if the class is factor?

# Fit our ANOVA model (fit: pick the model that best describes the data/sample)
model <- aov(HAM_16 ~ Group, data = data) 
print(summary(model)) # results 
TukeyHSD(model) # pairwise comparison between 2 paired groups


#--- 4. Regression Analysis ---#
# Model the relationship between two variables X & Y
# Y ~ X: If X could predict Y
# X: predictor, IV (independent variable)
# Y: outcome variable, DV (dependent variable)
# Linear regression VS Logistic regression
# Linear regression: when your outcome variable (Y) is continuous variable
# Logistic regression: when your outcome variable (Y) is binary variable

### Let's start from a simple linear regression model ###
# Q: Does physical burden has effect on cognitive function (MMSE)?

?lm

model_a <- lm(MMSE_score ~ CIRS_totalScore, data = data)

# Output
summary(model_a)
summary(model_a)$coef

# Another summary of the model and for cleaning up the coefficient table
model_a %>% 
  broom::glance()

# Q: Does physical burden, depression severity, age has effect on memory?
model_b <- lm(drs_memory ~ CIRS_totalScore + HAM_16 + AgeConsent, data = data)
summary(model_b)

# check assumption for linear regression
plot(model_b)

### Logistic Regression ###
# Q: Does physical burden has effect on current substance abuse

?glm

model_c <- glm(pres_curr_subs ~ MMSE_score + AgeConsent + Gender, data = data)
summary(model_c)
model_c %>% 
  broom::glance()



# Congrats! Now you've learned the basic of using R including cleaning data, manipulating data frame, plotting, and analyzing data. 
# R is a strong tool in psych research, and can be very flexible with all the packages out there. 
# I hope you find this fun and enjoy these intro-level session :) 
# Please always feel free to ask me questions - I'm happy to help with all kinds of questions!
# Thank you!!

