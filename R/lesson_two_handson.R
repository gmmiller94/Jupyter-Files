#What is the average age of those who use each web browser type?
airbnb2 <- aggregate(age~first_browser, airbnb_test_users, mean)

#What is the total signup_flow for each device?
airbnb3 <- aggregate(signup_flow~first_device_type, airbnb_test_users, sum)


#They need the country information included in the airbnb_test_users file
airbnb4 <- merge(airbnb_sample_submission,airbnb_test_users, by=c("id"), all=TRUE)


#Add additional users to the test file
names(airbnb4)[names(airbnb4) == "country"] <- "country_destination"
airbnb5 <- merge(airbnb4, airbnb_users, all=TRUE)