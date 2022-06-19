library('gmodels')
library('dplyr')
library('tidyr')


#Part 1

#Does the term of the loan influence loan status? If so, how?
CrossTable(loans$term, loans$loan_status, chisq=TRUE, expected=TRUE, sresid=TRUE, format="SPSS")

#From the table, it looks like people are more likely to have 36 months fully paid, and more likely to have 60 month terms charged off


loans %>% group_by(loan_status) %>% summarise(count=n())

# This shows that there are way more paid off than charged off or current


#Part 2

#reformat loan date
loans$DateR <- as.Date(paste(loans$Date), "%m/%d/%Y")

loans1 <- separate(loans, DateR, c("Year", "Month", "Day"), sep="-")

loans1$YearR <- NA
loans1$YearR[loans1$Year <= 2009] <- 0
loans1$YearR[loans1$Year > 2009] <- 1

loans1$RentvOwn <- NA
loans1$RentvOwn[loans1$home_ownership == "RENT"] <- 0
loans1$RentvOwn[loans1$home_ownership == "OWN"] <- 1

CrossTable(loans1$RentvOwn, loans1$YearR, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS") 

#How has the ability to own a home changed after 2009?
CrossTable(loans$home_ownership, loans$DateR, chisq=TRUE, expected=TRUE, sresid=TRUE, format="SPSS")

#The p value is not significant, and there is not a big difference in expected values to count, therefore it is safe to say that the ability
#to own a home has not significantly changed



#Part 3

#The news just ran a story that only 15% of homes are fully paid for in America, and that another 10% have given up on paying it back, 
#so the bank has "charged off" the loan. Does it seem likely that the data for this hands on came from the larger population of America?


observed = c(18173, 3282)
expected = c(0.85, 0.15)

chisq.test(x = observed, p = expected)

#Per the chi-squared test results this data did come from the larger population

