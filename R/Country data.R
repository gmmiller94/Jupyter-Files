library("dplyr")
library("ggplot2")
library("gapminder")

#filtered data to country, year, lifeExp, GDP
levels(gapminder$country)
gm_RandomClean5 <- filter(gapminder,
                     country %in% c("Iceland", "Norway", "Finland", "Ireland", "Peru"))%>%
  select(country, year, lifeExp, gdpPercap)

#scatter plot for GDP
ggplot(gm_RandomClean5) + geom_line(aes(x = year, y = gdpPercap, color = country)) +
  ylab("Per Capita GDP") + ggtitle("GDP in Five Countries")


gm.big <- gm_RandomClean5 %>%
  filter(year == 1952) %>%
  arrange(desc(gdpPercap))

head(gm.big)

gm.big <- gm_RandomClean5 %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

head(gm.big)

#lowest per Capita GDP in 1952? In 2007? Peru for both

#highest per Capita GDP in 1952? In 2007? Norway for both



#line plot with year on the horizontal axis and lifeExp on the vertical axis for the five countries; 
#give each country a different color line. Describe the variations in life expectancy between the countries.

ggplot(gm_RandomClean5) + geom_line(aes(x = year, y = lifeExp, color = country)) +
  ylab("Life Expectancy") + ggtitle("Life Expectancy in Five Countries")

#Peru has the lowest life expectancy by far. The other four countries are more comparable, with Iceland and Norway 
#having the highest average and Ireland and Finland started off lower but both have gotten closer to the top two averages
#in recent years.


#On the entire gapminder data frame, compute the median of lifeExp for each year.

#gapminder frame
gm_medians <- gapminder %>%
  group_by(year) %>%
  summarise(life_med = median(lifeExp), gdp_med = median(gdpPercap))
gm_medians

#For what years is the life expectancy for your five countries above the median life expectancy for the entire gapminder data frame?
#Including Peru, none. Excluding Peru, the other four countries stay above the average life expectancy continuously.