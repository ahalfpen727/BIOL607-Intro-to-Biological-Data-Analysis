http://yihui.name/knitr/options/ for more on options

```{r code_block, cache=TRUE}
#This take a really really really long time
```

```{r dont_show_code, echo=FALSE}
#Code I want to execute but not show
```

```{r code_to_show_but_not_run, eval=FALSE}
#show something pretty
```

```{r suppress_messages_in_this_block, warning=FALSE, message=FALSE}
#Do some things
#but supress printing of messages
#and warnings
```
##################################################
######### Tidy Data
##################################################
library(dplyr);library(tidyr)
library(readxl);library(ggplot2)

mammals <- data.frame(site = c(1,1,2,3,3,3),
                      taxon = c('Suncus etruscus', 'Sorex cinereus',
                                'Myotis nigricans', 'Notiosorex crawfordi',
                                'Scuncus etruscus', 'Myotis nigricans'),
                      density = c(6.2, 5.2, 11.0, 1.2, 9.4, 9.6)
)

#Make a biplot?
m_wide <- mammals %>%
  spread(key = taxon, value = density, fill = 0)

m_wide

qplot(`Myotis nigricans`, `Notiosorex crawfordi`, data = m_wide,)

#fill in zeros as a long set
m_complete <- mammals %>%
  complete(site, taxon, fill = list(density = 0))

m_complete

#what if we wanted to go from wide to long?
#and exlude the site column
m_long <- m_wide %>%
  gather(Species, density, -site)

m_long

#tell us which coluns to include in the gather
m_long_2.a <- m_wide %>%
  gather(Species, density, `Myotis nigricans`:`Suncus etruscus`)

m_long_2.b <- m_wide %>%
   gather(key=Species, value=density, `Myotis nigricans`:`Suncus etruscus`)

m_long_2.a
m_long_2.b

#get summary information
m_summary <- m_long %>%
  group_by(Species) %>%
  summarise(density = mean(density)) %>%
  ungroup()



########## Multi-measurment mammals
mammals_height <- mammals %>%
  mutate(height = rnorm(n(), 10))

mammals_height

#How do I go from long to wide? Or just make a really long data set
mammals_height_long <- mammals_height %>%
  gather(Measurement, Value, `density`, `height`)

mammals_height_long

mammals_height_long <- mammals_height_long %>%
  complete(site, taxon, Measurement, fill = list(Value = 0))

mammals_height_long

mammals_height_good <- mammals_height_long %>%
  spread(Measurement, Value)

mammals_height_good

#fil in different values for missing densities and heights
mammals_height_good2 <- mammals_height %>%
  complete(site, taxon, fill = list(density = 0, height = NA))

mammals_height_good2

#unite and semarate mammals
mam_2 <- mammals %>%
  separate(taxon, into = c("Genus", "Species"), sep = " ")
mam_2

mam_u <- mam_2 %>%
  unite(col = Taxon, Genus, Species, sep = "_")
mam_u

########## Hemlock

setwd("./data/")
dir()
hemlock<-readxl::read_xlsx(path="hemlock.xlsx")

head(hemlock)

qplot(`Hem Den`, `Dead Hem Den`, data = hemlock)

#Select out the density columns and make a long data set
# Transform data into long form
hemlock
hem_long <- hemlock %>%
  select(Stand:Latitude, `Hem Den`:`Tree Den`) %>%
  gather(Variable, Value, `Hem Den`:`Tree Den`)

hem_long

class(hem_long$Latitude)
class(hem_long$Stand)
#Plot how the three densities change over time
qplot(Year, Value, color=Variable, data=hem_long)

hemlock

#Aggregate by year and variable
Hem.Sum <- hem_long %>%
   group_by(Year, Variable) %>%
   summarise(mean = mean(Value)) %>%
   ungroup()
Hem.Sum

qplot(Year, mean, data=Hem.Sum,xlab="Time (year)", ylab="Mean Density",
      geom=c("point", "line"), color=Variable)

#And now a break for a gsub
my_string <- "Bakers"

gsub("s", "", my_string)

my_string2 <- "Baskers"
gsub("s$", "", my_string2)

my_string_3 <- "Basker 13"
gsub(" \\d*", "", my_string_3)

#How jarrett does regexp
#1) write down the pattern in plain english
#2) Google a regexp tutorial
#3) Test out my regexp at https://regex101.com/


hem_long_town <- hem_long %>%
  mutate(Town = gsub(" \\d+", "", Stand)) %>%
  group_by(Year, Town, Variable) %>%
  summarise(mean_value = mean(Value)) %>%
  ungroup()










