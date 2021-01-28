library(gapminder)
library(ggplot2)
library(dplyr)

#1. Calculate the mean gdp percap for each country

gapminder %>%
  group_by(country) %>%
  summarise(mean_gpdPercap = mean(gdpPercap))


#2 calculate mean gdp for each country


gapminder %>% 
  group_by(country) %>%
  mutate(gdp = pop*gdpPercap)


#3. Create a graph of the total population of each continent over time

totalPopDF <- gapminder %>% 
  group_by(continent, year) %>%
  summarize(total_pop = sum(pop))

ggplot(data=totalPopDF, aes(x=year, y=total_pop, color=continent)) +
  geom_point()


#4. For each continent, what country had the smallest 
# population in 1952, 1972, and 2002?

gapminder %>%
  #only 1952, 1972, 2002
  filter(year %in% c(1952, 1972, 2002)) %>% 
  #by continent and year
  group_by(continent, year) %>%
  # miniumum population
  slice(which.min(pop)) %>%
  ungroup() %>%
  select(continent, year, pop)
#  arrange(pop) %>% 
 # summarize(country = country[1], pop = pop[1])


#1) How many countries are there on each continent
gapminder %>%
  group_by(continent) %>%
  summarise(countries = length(unique(country)))

#2) Which countries have the best and worst life expentancies in each continent
gapminder %>%
  group_by(continent) %>%
  slice(which.min(lifeExp))

gapminder %>%
  group_by(continent) %>%
  slice(which.max(lifeExp))

#3) which country experiencesd the sharpest 5-year drop in life expentancy
gapminder %>%
  group_by(country) %>%
  arrange(year) %>%
  mutate(diffLifeExp = lifeExp - lag(lifeExp)) %>%
  group_by(continent) %>%
  slice(which.min(diffLifeExp))
#Challenge: