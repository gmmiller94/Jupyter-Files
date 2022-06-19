library("corpcor")
library("GPArotation")
library("psych")
library("IDPmisc")

#wrangle data
studentSurvey1 <- studentSurvey[, 31:42]

studentSurvey2 = NaRV.omit(studentSurvey1)

#test assumptions
studentSurveymatrix = cor(studentSurvey2)
View(round(studentSurveymatrix, 2))

##Bartlett's Test
cortest.bartlett(studentSurvey2)

##Check your Determinants
det(studentSurveymatrix)

### have a sufficient relation between variables


#Initial Pass to Determine Approximate Number of Factors
model = principal(studentSurvey2, nfactors = 12, rotate = 'none')
model

##Examine the Scree Plot
plot(model$values, type = 'b')

### 2 factors?


#Second Pass to Test the Suspected Number of Factors

model2 = principal(studentSurvey2, nfactors = 2, rotate = 'none')
model2

##Examining Residuals to Determine Model Fit
residuals <- factor.residuals(studentSurveymatrix, model2$loadings)
residuals <- as.matrix(residuals[upper.tri(residuals)])
largeResid <- abs(residuals) > .05
sum(largeResid)
sum(largeResid/nrow(residuals))

### 45% residuals


#Rotate the Factors to Determine Where Each Survey Item Fits

##Oblique Rotation
model3 = principal(studentSurvey2, nfactors = 2, rotate = "oblimin")
model3

##Orthogonal Rotation
model4 <- principal(studentSurvey2, nfactors = 2, rotate = "varimax")
print.psych(model4, cut=.3, sort=TRUE)

#Subsetting your Data

goodSurvey <- studentSurvey2[2,4,5,7,10,11,12]
badSurvey <- studentSurvey2[1,3,6,8,9]


studentSurvey2$Area1r <- NA
studentSurvey2$Area1r[studentSurvey2$Area1 == 1] <- 5
studentSurvey2$Area1r[studentSurvey2$Area1 == 2] <- 4
studentSurvey2$Area1r[studentSurvey2$Area1 == 3] <- 3
studentSurvey2$Area1r[studentSurvey2$Area1 == 4] <- 2
studentSurvey2$Area1r[studentSurvey2$Area1 == 5] <- 1

studentSurvey2$Area3r <- NA
studentSurvey2$Area3r[studentSurvey2$Area3 == 1] <- 5
studentSurvey2$Area3r[studentSurvey2$Area3 == 2] <- 4
studentSurvey2$Area3r[studentSurvey2$Area3 == 3] <- 3
studentSurvey2$Area3r[studentSurvey2$Area3 == 4] <- 2
studentSurvey2$Area3r[studentSurvey2$Area3 == 5] <- 1

studentSurvey2$Area6r <- NA
studentSurvey2$Area6r[studentSurvey2$Area6 == 1] <- 5
studentSurvey2$Area6r[studentSurvey2$Area6 == 2] <- 4
studentSurvey2$Area6r[studentSurvey2$Area6 == 3] <- 3
studentSurvey2$Area6r[studentSurvey2$Area6 == 4] <- 2
studentSurvey2$Area6r[studentSurvey2$Area6 == 5] <- 1

studentSurvey2$Area8r <- NA
studentSurvey2$Area8r[studentSurvey2$Area8 == 1] <- 5
studentSurvey2$Area8r[studentSurvey2$Area8 == 2] <- 4
studentSurvey2$Area8r[studentSurvey2$Area8 == 3] <- 3
studentSurvey2$Area8r[studentSurvey2$Area8 == 4] <- 2
studentSurvey2$Area8r[studentSurvey2$Area8 == 5] <- 1

studentSurvey2$Area9r <- NA
studentSurvey2$Area9r[studentSurvey2$Area9 == 1] <- 5
studentSurvey2$Area9r[studentSurvey2$Area9 == 2] <- 4
studentSurvey2$Area9r[studentSurvey2$Area9 == 3] <- 3
studentSurvey2$Area9r[studentSurvey2$Area9 == 4] <- 2
studentSurvey2$Area9r[studentSurvey2$Area9 == 5] <- 1

studentSurvey3 <- studentSurvey2[, c(2,4,5,7,10,11,12,13,14,15,16,17)]


#Calculating Reliability in R
alpha(goodSurvey)
alpha(goodSurvey)
alpha(studentSurvey3)
