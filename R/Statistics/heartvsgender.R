library("mvnormtest")
library("car")

#How does gender (sex) influence some of the heart attack predictors like resting blood pressure (trestbps) and cholesterol (chol)?

##wrangle
###check to see if numeric
str(heartAttacks$trestbps)
str(heartAttacks$chol)
###Good to go!

###subsetting
keeps <- c("trestbps", "chol")
heartAttacks1 <- heartAttacks[keeps]

###matrix
heartAttacks2 <- as.matrix(heartAttacks1)



##test assumptions
heartAttacks3 <- na.omit(heartAttacks2)

mshapiro.test(t(heartAttacks3))
###violated the assumption of multivariate normality, p value is significant at p < .05. Going to continue anyway



##Levene's Test
###resting blood pressure
leveneTest(heartAttacks$trestbps, heartAttacks$sex, data=heartAttacks)
### met assumption of homogeneity of variance at p = 0.2446

###cholesterol
leveneTest(heartAttacks$chol, heartAttacks$sex, data=heartAttacks)
### does not meet assumption of homogeneity of variance at p = 0.0008413



##Absence of Multicollinearity
cor.test(heartAttacks$trestbps, heartAttacks$chol, method="pearson", use="complete.obs")
### Assumption met with r = 0.1231742



##MANOVA Analysis
MANOVA <- manova(cbind(trestbps, chol) ~ sex, data = heartAttacks)
summary(MANOVA)

summary.aov(MANOVA, test = "wilks") 

###There is a large difference between sex/blood pressure and sex/cholesterol, where there is much more significance between
###sex and cholesterol.