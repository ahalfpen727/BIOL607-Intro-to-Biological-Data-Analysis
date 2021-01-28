##-------------------------------------------------##
##            Regression Diagnostics               ##
##                  John Fox                       ##
##                FIOCRUZ Brasil                   ##
##                November 2009                    ##
##                                                 ##
##   Diagnostics for Generalized Linear Models     ##
##                                                 ##
##-------------------------------------------------##

# Poisson regression for Ornstein's interlocking-directorate data

library(car)
data(Ornstein)

attach(Ornstein)
tab <- table(interlocks)
tab
x <- sort(unique(interlocks))

plot(x, tab, type='h', xlab='Number of Interlocks', ylab='Frequency')
points(x, tab, pch=16)

mod.ornstein <- glm(interlocks ~ assets + nation + sector, family=poisson)
summary(mod.ornstein)

Anova(mod.ornstein)

    # quasi-Poisson model

mod.ornstein.qp <- glm(interlocks ~ assets + nation + sector,
    family=quasipoisson)
summary(mod.ornstein.qp)

Anova(mod.ornstein.qp)

Anova(mod.ornstein.qp, test="F")

    # effect plot, based on quasi-Poisson model

library(effects)

plot(all.effects(mod.ornstein.qp), ask=FALSE)

    # diagnostics

        # unusual data

influencePlot(mod.ornstein.qp)

outlier.test(mod.ornstein.qp)

D <- dfbeta(mod.ornstein.qp)

plot(D[,"assets"])
abline(h=c(-3.389e-06, 0, 3.389e-06), lty=2) #  +/- SE(B)
identify(D[,"assets"])

        # nonlinearity

cr.plot(mod.ornstein.qp, "assets", span=.9)

mod.ornstein.qp.1 <- glm(interlocks ~ log10(assets) + nation + sector,
    family=quasipoisson)
summary(mod.ornstein.qp.1)
deviance(mod.ornstein.qp)

cr.plot(mod.ornstein.qp.1, "log10(assets)")

influence.plot(mod.ornstein.qp.1)

