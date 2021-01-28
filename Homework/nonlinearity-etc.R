##-------------------------------------------------##
##            Regression Diagnostics               ##
##                  John Fox                       ##
##                FIOCRUZ Brasil                   ##
##                November 2009                    ##
##                                                 ##
##        Nonlinearity and Other Problems          ##
##                                                 ##
##-------------------------------------------------##

library(car)

# SLID data

url <- "http://socserv.socsci.mcmaster.ca/jfox/Books/Applied-Regression-2E/datasets/SLID-Ontario.txt"
SLID <- read.table(url, header=TRUE)

mod0 <- lm(compositeHourlyWages ~ sex + age + yearsEducation, data=SLID)
summary(mod0)

# checking normality

qq.plot(mod0, simulate=TRUE, line="none")

plot(density(rstudent(mod0)))

mod1 <- lm(log2(compositeHourlyWages) ~ sex + age + yearsEducation, data=SLID)
summary(mod1)

qq.plot(mod1, simulate=TRUE, line="none")

plot(density(rstudent(mod1)))

# checking constant error variance

plot(fitted(mod0), rstudent(mod0), col="gray")
abline(h=0, lty=2)
lines(lowess(fitted(mod0), rstudent(mod0)))

spread.level.plot(mod0)

plot(fitted(mod1), rstudent(mod1), col="gray")
abline(h=0, lty=2)
lines(lowess(fitted(mod1), rstudent(mod1)))

spread.level.plot(mod1)

# checking linearity

cr.plots(mod1)
cr.plots(mod1, ask=FALSE)

mod2 <- lm(log2(compositeHourlyWages) ~ sex + poly(age, degree=2, raw=TRUE)
    + I(yearsEducation^2), data=SLID)
summary(mod2)

lm(log2(compositeHourlyWages) ~ sex + age + I(age^2) + I(yearsEducation^2),
    data=SLID) # equivalent

cr.plots(mod2)

library(effects)

plot(allEffects(mod2), ask=FALSE)

# discrete data

url <- "http://socserv.socsci.mcmaster.ca/jfox/Books/Applied-Regression-2E/datasets/Vocabulary.txt"
Vocab <- na.omit(read.table(url, header=TRUE))

    # testing linearity

voc1 <- lm(vocabulary ~ education, data=Vocab)
voc2 <- lm(vocabulary ~ as.factor(education), data=Vocab)

anova(voc1)
anova(voc2)
anova(voc1, voc2)

with(Vocab, plot(0:20, tapply(vocabulary, education, mean), pch=16,
    cex=sqrt(table(education))/20, type="b",
    xlab="Education (years)", ylab="Mean Vocabulary Score"))
abline(voc1, lty=2, lwd=2)

    # testing constant variance

with(Vocab, levene.test(vocabulary, as.factor(education)))
with(Vocab, tapply(vocabulary, as.factor(education), sd)) #SDs
xtabs(~ education, data=Vocab) # counts

# ML Methods

    # Box-Cox regression

library(MASS)
boxcox(mod0)

mod.bc <- update(mod0, . ~ . + box.cox.var(compositeHourlyWages))
summary(mod.bc)
av.plots(mod.bc)  # constructed-variable plot

    # Box-Tidwell regression

box.tidwell(log2(compositeHourlyWages) ~ I(age - 15) + I(yearsEducation + 1),
    other.x=~sex, data=SLID)

mod.bt <- lm(log2(compositeHourlyWages) ~ I(age - 15) + I(yearsEducation + 1) + sex
    + I((age - 15)*log(age - 15)) + I((yearsEducation + 1)*log(yearsEducation + 1)),
    data=SLID)
av.plots(mod.bt)  # constructed-variable plots

    # non-constant error variance

ncv.test(mod0)
ncv.test(mod0, ~ age + yearsEducation + sex, data=SLID)
