rr = data.frame(rivers)

#histogram
r <- ggplot(rr, aes(x = rivers))

r + geom_histogram(binwidth = 200, fill = "darkblue", color = "white") +
ggtitle("Lengths of Major Rivers") +
xlab("Length (in miles)")

#boxplot
r <- ggplot(rr, aes(x = "", y = rivers))
r + geom_boxplot() + xlab("")
summary(rr$rivers)

#normal probabilty plot
ggplot(rr, aes(sample = rivers)) + geom_qq()
