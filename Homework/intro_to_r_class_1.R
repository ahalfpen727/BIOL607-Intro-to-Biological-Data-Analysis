#Calculator
2 + 2

#order of operations
3 + 4 * 2

(3 + 4) / 2


#scientific notation
1e5
100000
10^5

#mathematic functions
log(2) #natural log
log10(2) #base 10 log
log(2, base=2) #base 2 log

exp(log(2))


#Comparisons

2 == 2
2 == 3


#not equal
2 != 3
2 != 2

#greater than, less that

2 < 3
2 > 3

2 < 2
2 <= 2
2 >= 3

#------------------
#Let's meet gapminder

#install.packages("gapminder")
library(gapminder)


str(gapminder)
dplyr::glimpse(gapminder)


head(gapminder)
tail(gapminder)
View(gapminder)
dim(gapminder)


#Look at values
life <- gapminder$lifeExp

class(gapminder[["lifeExp"]])
class(gapminder["lifeExp"])

life <- gapminder$lifeExp

head(life)
length(life)



life[1]
life[1:10]
life[c(1,2,3,100,700)]


#accessing data frame with column names
gapminder[1, 'country']
gapminder[1, c('country', 'year')]
gapminder[1, ]
gapminder[ , c('country', 'year')]


#Excerse

#1)
gapminder[100, ]

#2)
gapminder[40:50, c("continent", "lifeExp")]

#3
gapminder[c(1:3, 10, (nrow(gapminder)-5):nrow(gapminder)), ]

##########
# ggplot2
plot(pop ~ gdpPercap, data=gapminder)



library(ggplot2)

ggplot(data=gapminder, aes(x=continent, y=lifeExp)) +
  stat_ydensity()


ggplot(data=gapminder, aes(x = year, y = lifeExp, color=continent)) +
  geom_point()


p <- ggplot(data=gapminder, aes(x = year, 
                           y = lifeExp, 
                           color=continent, 
                           by=country)) +
  geom_line()

p

p+stat_smooth(method=lm)

#gapminder[which(gapminder$lifeExp==min(gapminder$lifeExp)), ]
