library(rcompanion)
library("dplyr")
library("car")

#Does the average price of avocados differ between Albany, Houston, and Seattle?
cities <- na.omit(avocados %>% filter(V14 %in% c("Albany", "Houston", "Seattle")))

cities$V3 <- as.numeric(cities$V3)

#Test Assumptions
plotNormalHistogram(cities$V3)

#positively skewed

cities$V3SQRT <- sqrt(cities$V3)
plotNormalHistogram(cities$V3SQRT)

#Much better, using SQRT

#Homogeneity of Variance

bartlett.test(V3 ~ V14, data=cities)
#Bartlett's K-squared = 104.28, df = 2, p-value < 2.2e-16
#Assumption of homogeneity of variance is violated due to p < 0.05(unequal variance)

ANOVA <- lm(V3 ~ V14, data=cities)
Anova(ANOVA, Type="II", white.adjust=TRUE)

#Analysis of Deviance Table (Type II tests)

#Response: V3
#Df     F    Pr(>F)    
#V14          2 261.8 < 2.2e-16 ***
#  Residuals 1011                    
#---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#There is a significant difference in price

pairwise.t.test(cities$V3, cities$V14, p.adjust="bonferroni", pool.sd = FALSE)

#Means
citiesMeans <- cities %>% group_by(V14) %>% summarize(Mean = mean(V3))

#Results
#Looking at the means, Albany has the highest price at 1.56, then Seattle at 1.44 then Houston at 1.05. 
#There is a small difference, but still a difference in average price




