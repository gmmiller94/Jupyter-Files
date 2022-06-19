library("car")
library("caret")
library("gvlma")
library("predictmeans")

## linearity

scatter.smooth(x=heights$AM_Height, y=heights$PM_Height, main="Morning by Evening Height")

### This looks linear,so the assumption of linearity is met


## homoscedasticity
lmModHeights = lm(PM_Height~AM_Height, data=heights)

par(mfrow=c(2,2))
plot(lmModHeights)

#### There should be a mostly flat line, and it looks like the top left graph curves
#### and the bottom left graph has a dip, so the assumption of homoscedasticity is possibly not be met

### breusch-pagan test

lmtest::bptest(lmModHeights)

#### Test was not significant, so assumption is met

### non-constant variance

car::ncvTest(lmModHeights)

#### Same as above, assumption is met



## Homogeneity of Variance

### GVLMA test

gvlma(lmModHeights)

#### All assumptions have been met


###Cook's D

CookD(lmModHeights, group=NULL, plot=TRUE, idn=3, newwd=TRUE)

#### observations 3, 4, and 12 might be an issue


### Leverage values

lev = hat(model.matrix(lmModHeights))
plot(lev)

heights[lev>.2,]

#### 3 is the only issue


### outliers

car::outlierTest(lmModHeights)

#### Test is significant, so there is an outlier


###influential points

summary(influence.measures(lmModHeights))

#### values on list are 3, 11, 37


### model without outliers to test against orginal model

heightsNoO <- heights[c(1,2,5,6,7,8,9,10,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,38,39,40,41),]
lmModHeightsNoO = lm(PM_Height~AM_Height, data=heightsNoO)


summary(lmModHeights)


summary(lmModHeightsNoO)

#### similar results as original model, so can still use orginial model