library("rcompanion")
library("car")
library("IDPmisc")
library("dplyr")

#Determine whether suicide rates has changed over the years, and see if the generation has any influence.

#Test Assumptions


plotNormalHistogram(suicide$V7)

suicide$V7SQRT <- sqrt(suicide$V7)
plotNormalHistogram(suicide$V7SQRT)

suicide$V7LOG <- log(suicide$V7)

suicide4 <- NaRV.omit(suicide)

plotNormalHistogram(suicide4$V7LOG)

#LOG shows the best data


leveneTest(V7LOG ~ V12, data=suicide4)

#failed the assumption, but want to dig in more



#Run analysis

RManova1 <- aov(V7LOG~(V12*V2)+Error(V1/(V2)), suicide4)
summary(RManova1)

#there is an effect between generation and suicide, and a connection to how the year has affected the generation



pairwise.t.test(suicide4$V7LOG, suicide4$V12, p.adjust="bonferroni")

#Looks like there is a difference in suicide rates among the generations

#Means and Draw Conclusions

suicideMeans <- suicide4 %>% group_by(V12, V2) %>% summarize(Mean=mean(V7))

# Generation Z is the least likely to commit suicide, while the G.I. generation is the most likely. 
