#------------------
# 9/22/2015
# Gapminder and ggplot3
#------------------

library(gapminder)
library(ggplot2)

p <- ggplot(data=gapminder, aes(x=year, y=lifeExp))

p+geom_point()


ggplot(data=gapminder, aes(x=year, y=lifeExp, by=country)) +
  geom_line(aes(colour=continent)) +
  geom_point()


p2 <- ggplot(data=gapminder, aes(x=year, y=lifeExp, 
                           by=country, colour=log(gdpPercap)))+
  geom_point()

p2 

p2+scale_color_gradientn( colours = cmyk.colors(6))


p2+
  facet_wrap(~continent)+
  scale_color_gradientn( colours = topo.colors(6))

