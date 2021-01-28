#------------------
# 9/22/2015
# Gapminder and ggplot3
#------------------

library(gapminder)
library(ggplot2)
library(dplyr)

str(gapminder)

filter(gapminder, country =="Canada")

select(gapminder, country)


#Doesn't work because there is no column name of Canada



head(select(gapminder, starts_with('C')))


group_by(gapminder, continent) %>%
  summarise(mean_life = mean(lifeExp))


group_by(gapminder, continent) %>%
  mutate(gdp = gdpPercap * pop) %>%
  arrange(desc(lifeExp))


gap <- tbl_df(gapminder)
str(gap)



#1
gapminder %>%
  filter(year %in% c(1952, 1972, 2002)) %>%
  group_by(year, continent) %>%
  arrange(pop) %>%
  summarise(smCount = country[1], smPop = pop[1])


#2 Total population in each continent over time
gapSum <- gapminder %>% 
  group_by(continent, year) %>%
  summarise(pop=sum(pop), sdPop = sd(pop))
            
ggplot(gapSum,
       aes(x=year, y=pop, color=continent)) +
  geom_line()


#3 mean gdp for each country
gapminder %>%
  group_by(country) %>%
  summarise(mean(gdpPercap*pop, na.rm=T))
