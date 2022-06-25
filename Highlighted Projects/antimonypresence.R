library("caret")
library("magrittr")
library("dplyr")
library("tidyr")
library("lmtest")
library("popbio")
library("e1071")


names(minerals)[1] <- 'Antimony'


#test assumptions

## run base model
mylogit <- glm(Gold ~ Antimony, data=minerals, family="binomial")


## predict gold or not gold

probabilities <- predict(mylogit, type = "response")
minerals$Predicted <- ifelse(probabilities > .5, "pos", "neg")

minerals$PredictedR <- NA
minerals$PredictedR[minerals$Predicted=='pos'] <- 1
minerals$PredictedR[minerals$Predicted=='neg'] <- 0

### convert variables to factors
###### ISSUESSSSSSSSS #######

#confusion matrix

conf_mat <- caret::confusionMatrix(minerals$PredictedR, minerals$Gold)
conf_mat



#logit linearity

minerals1 <- minerals %>% 
  dplyr::select_if(is.numeric)

predictors <- colnames(minerals1)

minerals1 <- minerals1 %>%
  mutate(logit=log(probabilities/(1-probabilities))) %>%
  gather(key= "predictors", value="predictor.value", -logit)


### PLOT

ggplot(minerals1, aes(logit, predictor.value))+
  geom_point(size=.5, alpha=.5)+
  geom_smooth(method= "loess")+
  theme_bw()+
  facet_wrap(~predictors, scales="free_y")

#### graph errors

plot(mylogit$residuals)

#### outliers

infl <- influence.measures(mylogit)
summary(infl)


# interpret output

summary(mylogit)

logi.hist.plot(minerals$Antimony,minerals$Gold, boxp=FALSE, type="hist", col="gray")

