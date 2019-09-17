############ MSiA Boot Camp: Intro to R: Day 1 Exercises #############
### by Kumar Ramanathan, based on materials from Christina Maimone ###

#### REVIEW: BASICS AND DATA TYPES ####

#### Arithmetic ####

# Pick a number; save it as x

# Multiply x by 3

# Take the log of the above (Hint, you need the function log() here)

# Subtract 4 from the above

# Square the above
x<-6
x<-x*3
x<-log(x)
x<-x-4
x<-x*x
x
#### Comparisons and Logical Operators ####

# Check if 1 is bigger than 2

1<2
# Check if 1 + 1 is equal to 2


# Check if it is true that the strings "eat" and "drink" are not equal to each other


# Check if it is true that 1 is equal to 1 *AND* 1 is equal to 2 
# (Hint: remember what the operators & and | do)


# Check if it is true that 1 is equal to 1 *OR* 1 is equal to 2
1+1==2
'eat' == 'drink'
1==1 && 1 ==2
1==2 |1==1
#### Packages and Functions ####

# Load the package tidyverse


# Open the help file for the function recode 
# (Hint: remember what ? does)


#### REVIEW: DATA STRUCTURES ####

#### Vectors ####

# Run this code to generate variables x1 and x2
set.seed(1234)
x1 <- rnorm(5)
x2 <- rnorm(20, mean=0.5)

# Select the 3rd element in x1

x1[3]
# Select the elements of x1 that are less than 0
x1[x1<0]

# Select the elements of x2 that are greater than 1
x2[x2>1]

# Create x3 containing the first five elements of x2
x3<-x2[1:5]
x3
# Select all but the third element of x1
x1[-3]

#### Missing values ####

# Generate a vector
vec <- c(1, 8, NA, 7, 3)

# Calculate the mean of vec, excluding the NA value
mean(vec)
mean(vec, na.rm = TRUE)
# Count the number of missing values in vec
is.na(vec)
sum(is.na(vec))
#### Factors ####

# See lecture notes and DataCamp for guidance and practice

#### Lists ####

# See lecture notes and DataCamp for guidance and practice


#### Matricies ####

# Generate a matrix
mat <- matrix(c(1:51, rep(NA,4)), ncol=5)

# Select row 4, column 5


# Select column 3


# Bonus: How many NA values are there in this matrix?


#### Data frames ####

# Load one of R's example data frames, mtcars
data(mtcars)

# Identify the number of observations (rows) and number of variables (columns)
names(mtcars)
dim(mtcars)
# Identify the names of the variables


# Select the variable 'mpg'

mtcars$mpg
# Select the 4th row
mtcars[4,]

# Square the value of the 'cyl' variable and store this as a new variable 'cylsq'
mtcars$cylsq<-mtcars$cyl*mtcars$cyl

#### READING FILES ####

# Check your working directory. It should be the root folder where you downloaded the boot camp materials. If that's not the case, set your working directory accordingly.
getwd()
# Read gapminder data with read.csv()
gapminder <- read.csv("data/gapminder5.csv", stringsAsFactors=FALSE)

# Load the readr package

library(readr)
# Read gapminder data with read_csv()
gapminder<-read_csv("data/gapminder5.csv")
#### DATA MANIPULATION ####

#### Exploring data frames ####

# Run summary() on the gapminder data
summary(gapminder)
attach()
attach(gapminder)# Find the mean of the variable pop
mean(pop)
# Create a frequency table of the variable 'year'
# Hint: use table()
table(year)

# Create a proportion table of the variable 'continent'
table(continent)
prop.table(table(continent))
# Hint: use prop.table()

detach(gapminder)
#### Subsetting and Sorting ####

# Create a new data frame called gapminder07 contaning only those rows in the gapminder data where year is 2007

gapminder07<-subset(gapminder, subset = gapminder$year == 2007)
# Created a sorted frequency table of the variable continent in gapminder07
sort(table(gapminder07$year))

# Print out the population of Mexico in 2007
gapminder07$pop[gapminder07$country=="Mexico"]

# BONUS: Print out the rows represnting the 5 countries with the highest population in 2007
# Hint: Use order(), which we learned about, and head(), which prints out the first 5 rows of a data frame
sort(gapminder07$pop)
print(sort(gapminder07$pop)[1:5])

head(gapminder07[order(gapminder07$pop, decreasing = TRUE)])
#### Adding and removing columns ####

# See lecture notes for more guidance. We will practice this skill in the next section.


#### Recoding variables ####

# Round the values of the variable `lifeExp` using `round()` and store this as a new variable `lifeExp_round`
attach(gapminder07 )
lifeExp_round<-round(lifeExp)
# Print out the new variable to see what it looks like
lifeExp_round

# This code creates the new variable 'lifeExp_over70'. Try to understand what it does.
gapminder07$lifeExp_over70 <- NA  # Initialize a variable containing all "NA" values
gapminder07$lifeExp_over70[gapminder07$lifeExp>70] <- "Yes"
gapminder07$lifeExp_over70[gapminder07$lifeExp<70] <- "No"
table(gapminder07$lifeExp_over70)

# Try to create a new variable 'lifeExp_highlow' that has the value 
# "High" when life expectancy is over the mean and the value "Low" 
# when it is below the mean. When you are done, print a frequency table.
lifeExp_highlow<- NA
lifeExp_highlow[lifeExp>mean(lifeExp)]<-"High"


lifeExp_highlow[lifeExp<mean(lifeExp)]<-"Low"

table(lifeExp_highlow)

#### Aggregating ####

# Find the mean of life expectancy in 2007 for each continent
# Hint: use the aggregate() function
aggregate(lifeExp~continent, FUN = mean)

#### Statistics, part 1 ####

# Calculate the correlation between 'lifeExp' and 'gdpPercap'.
cor(lifeExp,gdpPercap)

# Use a t-test to evaluate the difference between 'gdpPercap' in "high" and "low" life expectancy countries. Store the results as t1, and then print out t1.
t.test(gdpPercap~lifeExp_highlow)

#### Statistics, part 2 ####

# Conduct a linear regression predicting 'lifeExp' as a function of 'gdpPercap' and 'pop', and store the results as reg1.
reg1<-lm(lifeExp~gdpPercap+pop)

# Print out reg1.

reg1
# Run summary() on reg1.
summary(reg1)

#### WRITING FILES ####

#### Writing a data file ####
write.csv(gapminder07, file = "data/gapminder07.csv")
# Save the gapminder07 data frame as a CSV file using write.csv() in the "data" subfolder within the working directory
# Set the argument `row.names = FALSE`.
write.csv(gapminder07, row.names = FALSE)


#### Save R objects ####

# See lecture notes for guidance and more examples.


#### DATA VISUALIZATION ####

#### Histograms ####

# Create a histogram of the variable 'lifeExp' in gapminder07

hist(lifeExp, main = "LifeExp", ylab = "frequency", xlab = "life")
# Re-create the histogram with a title and axis labels


# Bonus: Change the `breaks = ` argument from its default setting and see what happens.
hist(lifeExp, main = "LifeExp", ylab = "frequency", xlab = "life", breaks = 6)
hist(lifeExp, main = "LifeExp", ylab = "frequency", xlab = "life", breaks = 10)


#### Scatterplots ####

# Create a scatterplot with `lifeExp` on the y-axis and `gdpPercap` on the x-axis
plot(lifeExp~gdpPercap, main = "scatterplot", xlab = "gdp", ylab = "LifeExpentency")
# Add a title and axis labels.


# Bonus: Add a horizontal line indicating the mean of `lifeExp` onto the plot using `abline()`.
abline( mean(lifeExp),0)

