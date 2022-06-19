
install.packages("Ecdat")
library(Ecdat)
head(Cigarette)

library("ggplot2")
library("dplyr")

#boxplot of the average number of packs per capita by state
ggplot(Cigarette, aes(x = factor(state), y = packpc)) + geom_boxplot()

#Which states have the highest number of packs? Which have the lowest?
Cigarette %>% group_by(state) %>% summarise(Mean = mean(packpc)) %>% arrange((Mean))
Cigarette %>% group_by(state) %>% summarise(Mean = mean(packpc)) %>% arrange(desc(Mean))

#Utah, New Mexico and California have the lowest
#Kentucky, New Hampshire and North Carolina have the highest

#median over all the states of the number of packs per capita for each year
MedianCig <- Cigarette %>% group_by(year) %>% summarise(Median = median(packpc))

#Plot this median value for the years from 1985 to 1995
unique(Cigarette$year)

ggplot(MedianCig, aes(x=year, y=Median)) + geom_point()

#What can you say about cigarette usage in these years? 
#They have significantly declined


#scatter plot of price per pack vs number of packs per capita for all states and years
ggplot(Cigarette, aes(x=avgprs, y=packpc)) + geom_point() + geom_smooth(method=lm)

#Are the price and the per capita packs positively correlated, negatively correlated, or uncorrelated?
#negatively

ggplot(Cigarette, aes(x=avgprs, y=packpc, color=year)) + geom_point() + geom_smooth(method=lm)

#Do a linear regression for these two variables
regression <- lm(packpc~avgprs, Cigarette)
summary(regression)

#How much variability does the line explain? 34% of the variability

#adjust the price of a pack of cigarettes for inflation by dividing the avgprs variable by the cpi variable
Infl <- Cigarette %>% mutate(Inflation = avgprs / cpi)

#adjusted inflation scatterplot
ggplot(Infl, aes(x=Inflation, y= packpc)) + geom_point() +geom_smooth(method=lm)
  
#adjusted inflation linear regression
regression <- lm(packpc~Inflation, Infl)
summary(regression)

#How much variability does the line explain? 38% of the variability


#Create a data frame with just the rows from 1985  
Cigs1985 <- Cigarette %>% filter(year == 1985)
  
#Create a data frame with just the rows from 1995
Cigs1995 <- Cigarette %>% filter(year == 1995)

#vector of the number of packs per capita
#48

#paired t-test to see if the number of packs per capita in 1995 was significantly different than
#the number of packs per capita in 1985
t.test(Cigs1985$packpc, Cigs1995$packpc, paired = TRUE)

#It was significantly different, p-value = <2.2e-16, which is WAY less than 0.05
