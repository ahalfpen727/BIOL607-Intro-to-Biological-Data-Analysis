library(car)
library(models)
library(emmeans);library(ggplot2)
library(tidyverse);library(visreg)
zooplankton<-read.csv("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter18/chap18e2ZooplanktonDepredation.csv")

zooplankton %>%
   mutate(block=factor(block))

zooplankton %>%
   group_by(block, treatment) %>%
   tally


ggplot(data = zooplankton, aes(x=block, y=zooplankton)) +
   geom_boxplot()

plot(data=zooplankton, aes(x=treatment, y=zooplankton), geom="boxplot")

zooplankton.lm<-lm(diversity ~ treatment + block, data=zooplankton)
Anova(zooplankton.lm)
visreg(zooplankton.lm)

zoop.em<-emmeans(zooplankton.lm, ~ treatment)
contrast(zoop.em,method="tukey")

bees <- read.csv("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter18/chap18q08BeeGeneExpression.csv")

bees %>%
   mutate(colony=factor(colony))

#Visualize
qplot(colony, expression, data=bees, geom="boxplot")


#fit
bee_lm <- lm(expression ~ colony + type, data=bees)
summary(update(bee_lm, . ~ . -1))
#assumptions
plot(bee_lm, which=c(1,2,4,5))

residualPlots(bee_lm)
Anova(bee_lm)
bee_em <- contrast(emmeans(bee_lm, ~ type), method="tukey")

bee_em
#ANOVA

#Tukey's HSD
contrast(bee_em, method = "tukey")



intertidal <- read.csv("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter18/chap18e3IntertidalAlgae.csv")

intertidal %>%
   group_by(herbivores, height) %>%
   tally

#Visualize
qplot(herbivores, sqrtArea, data=intertidal,color=height, geom = "boxplot")

#fit
intertidal_lm <- lm(sqrtArea ~ height + herbivores, data=intertidal)
intertidal_lm1 <- lm(sqrtArea ~ height + herbivores + height:herbivores, data=intertidal)
# interaction effect
intertidal_lm2 <- lm(sqrtArea ~ height * herbivores, data=intertidal)
summary(intertidal_lm)
#assumptions
par(mfrow=c(2,2))
plot(intertidal_lm, which=c(1,2,4,5))

residualPlots(intertidal_lm)

#ANOVA
Anova(intertidal_lm)
Anova(intertidal_lm, type="III")
summary(Anova(intertidal_lm, type="III"))

#Tukey's HSD

emmeans(intertidal_lm2 ~ height | type)



kelp <- read_csv("/home/drew/Downloads/BIOL607-Introduction-to-Biological-Data-Analysis/BIOL607-Intro-to-Biological-Data-Analysis/Homework/data/kelp_pred_div_byrnesetal2006.csv")

## Check and correct for non-factors
kelp %>%
   mutate(Trial=factor(Trial))
#Visualize
qplot(Treatment, Porp_Change, data=kelp, geom="boxplot", color=Trial)
qplot(Trial, Porp_Change, data=kelp, geom="boxplot", color=Treatment)

#fit
kelp_lm <- lm(Porp_Change ~ Treatment * Trial, data=kelp)

#assumptions
par(mfrow=c(2,2))
plot(kelp_lm, which=c(1,2,4,5))

residualPlots(kelp_lm)

#ANOVA
leveneTest(kelp_lm)
Anova(kelp_lm)
kelp_em<-emmeans(kelp_lm)
#Tukey's HSD for simple effects
bee_em <- contrast(emmeans(bee_lm, ~ type), method="tukey")
contrast(emmeans(kelp_lm, ~Treatment, method = "tukey"))
