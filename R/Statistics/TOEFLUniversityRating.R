library("rcompanion")
library("car")
library("IDPmisc")
library("dplyr")

#Does University Rating significantly predict your college GPA when holding TOEFL score constant?

#Testing Assumptions

### Normality for both GPA and TOEFL score

plotNormalHistogram(graduate_admissions$CGPA)

graduate_admissions$CGPAsq <- graduate_admissions$CGPA * graduate_admissions$CGPA
plotNormalHistogram(graduate_admissions$CGPAsq)

#squared helped normalize the data better


plotNormalHistogram(graduate_admissions$TOEFL.Score)

graduate_admissions$TOEFL.ScoreSQ <- graduate_admissions$TOEFL.Score * graduate_admissions$TOEFL.Score
plotNormalHistogram(graduate_admissions$TOEFL.ScoreSQ)

#squared looks better for this data as well



##Homogeneity of Variance

leveneTest(CGPAsq~University.Rating, data=graduate_admissions)

#Results are not significant, assumption is met



##Homogeneity of Regression Slopes

Homogeneity_RegrSlp = lm(CGPA~TOEFL.Score, data=graduate_admissions)
anova(Homogeneity_RegrSlp)

# This wasn't met, but going to dig in anyway. Normally this would be used as an IV



##Run Analysis

ANCOVA = lm(CGPA~TOEFL.Score + University.Rating*TOEFL.Score, data=graduate_admissions)
anova(ANCOVA)

# Significant impact between TOEFL score and University Rating, but also a significant impact on university rating and on TOEFL score as well


##Post Hocs

postHocs <- glht(ANCOVA,linfct=mcp(University.Rating = "Tukey"))
summary(postHocs)

#It looks like the overall significance in the F test above was just a Type I error, no group really differs from any other group

##Adjusted Means

adjMeans <- effect("University.Rating", ANCOVA)
adjMeans

#This confirms my conclusion, all of these have a GPA that is about the same.
