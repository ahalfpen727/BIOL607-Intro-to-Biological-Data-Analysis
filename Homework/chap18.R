# Multiple explanatory variables: R code for Chapter 18 examples
# Download the R code on this page as a single file <a href="../wp-content/rcode/chap18.r">here
# ------------------------------------------------------------

# Figure 18.1-1 <a href="../wp-content/data/chapter17/chap17e3PlantDiversityAndStability.csv">Modeling with linear regression
# Compare the fits of the null and univariate regression models to data on the relationship between stability of plant biomass production and the initial number of plant species assigned to plots. The data are from Example 17.3.
# Read and inspect data.

prairie <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter17/chap17e3PlantDiversityAndStability.csv"))
head(prairie)

# Take the log-transformation of stability.

prairie$logStability <- log(prairie$biomassStability)
head(prairie)

# Fit the null model to the data, which in simple linear regression is a line of 0 slope.

prairieNullModel <- lm(logStability ~ 1, data = prairie)

# Fit the full model, which includes the treatment variable.

prairieRegression <- lm(logStability ~ nSpecies, data = prairie)

# Scatter plot to compare models visually.

plot(logStability ~ nSpecies, data = prairie, bty = "l", col="firebrick",
     pch = 1, las = 1, cex = 1.5, xlim = c(0,16), xaxp = c(0,16,8),
     xlab = "Species number treatment",
     ylab = "Log-transformed ecosystem stability")
abline(prairieNullModel, lty = 2)
abline(prairieRegression)

# The F-test of improvement in fit of the full (regression) model.

anova(prairieRegression)

# ------------------------------------------------------------

# Figure 18.1-2. <a href="../wp-content/data/chapter15/chap15e1KneesWhoSayNight.csv">Generalizing linear regression
# Compare the fits of the null and single-factor ANOVA model to data on phase shift in the circadian rhythm of melatonin production in participants given alternative light treatments. The data are from Example 15.1.
# Read and inspect data.

circadian <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter15/chap15e1KneesWhoSayNight.csv"))

# Set the order of groups for tables and graphs.

circadian$treatment <- factor(circadian$treatment,
                              levels = c("control", "knee","eyes"))

# Fit the null model to the data. In single-factor ANOVA, this fits a constant (grand mean) to all groups.

circadianNullModel <- lm(shift ~ 1, data = circadian)

# Fit the full model to the data, which includes the treatment effect.

circadianAnova <- lm(shift ~ treatment, data = circadian)

# Strip chart to compare models visually. The dashed line is the null model. The value adjustAmount is used to control the width of the horizontal line segments.

par(bty="l")
adjustAmount <- 0.15
stripchart(shift ~ treatment, data = circadian, method = "jitter",
           vertical = TRUE, las = 1, pch = 1, xlab = "Light treatment",
           ylab = "Shift in circadian rhythm (h)", col = "firebrick",
           cex = 1.2)

xpts <- as.numeric(circadian$treatment)
ypts <- predict(circadianNullModel)
segments(xpts - adjustAmount, ypts, xpts + adjustAmount, ypts, lty = 2)

xpts <- as.numeric(circadian$treatment)
ypts <- predict(circadianAnova)
segments(xpts - adjustAmount, ypts, xpts + adjustAmount, ypts, col = "firebrick")

# F-test of improvement in fit of the full model.

anova(circadianAnova)

# ------------------------------------------------------------

# Example 18.2. <a href="../wp-content/data/chapter18/chap18e2ZooplanktonDepredation.csv">Zooplankton depredation
# Analyze data from a randomized block experiment, which measured the effects of fish abundance (the factor of interest) on zooplankton diversity. Treatments were repeated at 5 locations in a lake (blocks).
# Read and inspect data.

zooplankton <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter18/chap18e2ZooplanktonDepredation.csv"))
head(zooplankton)

# Set the order of groups in tables and plots.

zooplankton$treatment <- factor(zooplankton$treatment, levels = c("control","low","high"))

# Table of the data (Table 18.2-1). One measurement is available from each combination of treatment and block

tapply(zooplankton$diversity, list(Treatment = zooplankton$treatment,
                                   Location = zooplankton$block), unique)

# A blocking variable is typically analyzed as a random effect. We need to load the nlme package.

library(nlme)

# Fit the null model, which includes block but leaves out the treatment variable.

zoopNullModel <- lme(diversity ~ 1, random = ~ 1| block, data = zooplankton)

# Fit the full model, which includes treatment.

zoopRBModel <- lme(diversity ~ treatment, random = ~ 1| block, data = zooplankton)

#
# Visualize model fits, beginning with the null model. The result here differs from that in the book, which shows block means. Lines are coincident when we analyze the data using lme, which estimates hardly any variance among the block means.

interaction.plot(zooplankton$treatment, zooplankton$block,
                 response = predict(zoopNullModel), ylim = range(zooplankton$diversity),
                 trace.label = "Block", las = 1)
points(zooplankton$treatment, zooplankton$diversity,
       pch = as.numeric(zooplankton$block))

# Visualize model fits, continuing with the full model. With the treatment term included, lme estimates that there is indeed variation among block means.

interaction.plot(zooplankton$treatment, zooplankton$block,
                 response = predict(zoopRBModel), ylim = range(zooplankton$diversity),
                 trace.label = "Block", las = 1)
points(zooplankton$treatment, zooplankton$diversity,
       pch = as.numeric(zooplankton$block))

# F--test of improvement in fit of the full model. This represents the test of treatment effect. Notice that R will not test the random (block) effect of an lme model.
anova(zoopRBModel)

# ------------------------------------------------------------

# Example 18.3 <a href="../wp-content/data/chapter18/chap18e3IntertidalAlgae.csv">Intertidal interaction zone
# Analyze data from a factorial experiment investigating the effects of herbivore presence, height above low tide, and the interaction between these factors, on abundance of a red intertidal alga using two-factor ANOVA.
# Read and inspect the data.

algae <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter18/chap18e3IntertidalAlgae.csv"))
head(algae)

# Fit the null model having both main effects but no interaction term. Note that we use lm because both factors are fixed effects.

algaeNoInteractModel <- lm(sqrtArea ~ height + herbivores, data = algae)

# Fit the full model, with interaction term included.

algaeFullModel <- lm(sqrtArea ~ height * herbivores, data = algae)

# Visualize the model fits, beginning with the no-interaction model.

interaction.plot(algae$herbivores, algae$height, response = predict(algaeNoInteractModel),
                 ylim = range(algae$sqrtArea), trace.label = "Height", las = 1,
                 ylab = "Square root surface area (cm)", xlab = "Herbivore treatment")
adjustAmount = 0.05
points(sqrtArea ~ c(jitter(as.numeric(herbivores), factor = 0.2) + adjustAmount),
       data = subset(algae, height == "low"))
points(sqrtArea ~ c(jitter(as.numeric(herbivores), factor = 0.2) - adjustAmount),
       data = subset(algae, height == "mid"), pch = 16)

# Visualize the model fits, continuing with the full model including the interaction term.

interaction.plot(algae$herbivores, algae$height, response = predict(algaeFullModel),
                 ylim = range(algae$sqrtArea), trace.label = "Height", las = 1,
                 ylab = "Square root surface area (cm)", xlab = "Herbivore treatment")
adjustAmount = 0.05
points(sqrtArea ~ c(jitter(as.numeric(herbivores), factor = 0.2) + adjustAmount),
       data = subset(algae, height == "low"))
points(sqrtArea ~ c(jitter(as.numeric(herbivores), factor = 0.2) - adjustAmount),
       data = subset(algae, height == "mid"), pch = 16)

#
# Test the improvement in fit of the model including the interaction term.

anova(algaeNoInteractModel, algaeFullModel)

# Test all terms in the model in a single ANOVA table. Most commonly, this is done using either "Type III" sums of squares (see footnote 5 on p 618 of the book) or "Type I" sums of squares (which is the default in R). In the present example the two methods give the same answer, because the design is completely balanced, but this will not generally happen when the design is not balanced.
# Here is how to test all model terms using "Type III" sums of squares. We need to include a contrasts argument for the two categorical variables in the lm command. Then we need to load the car package and use its Anova command. Note that "A" is in upper case in Anova - a very subtle difference.

algaeFullModelTypeIII <- lm(sqrtArea ~ height * herbivores, data = algae,
                            contrasts = list(height = contr.sum, herbivores = contr.sum))
library(car)
Anova(algaeFullModelTypeIII, type = "III") # note "A" in Anova is capitalized

# Here is how we test all model terms using "Type I" (sequential) sums of squares. Note that "a" is in lower case in anova.

anova(algaeFullModel)

# A residual plot from the full model.

plot( residuals(algaeFullModel) ~ fitted(algaeFullModel) )
abline(0,0)

# A normal quantile plot of the residuals.

qqnorm(residuals(algaeNoInteractModel), pch = 16, col = "firebrick",
       las = 1, ylab = "Residuals", xlab = "Normal quantile", main = "")

# ------------------------------------------------------------

# Example 18.4 <a href="../wp-content/data/chapter18/chap18e4MoleRatLayabouts.csv">Mole-rat layabouts
# Analyze a factor while adjusting for a covariate, comparing energy expenditure of two castes of naked mole-rat while adjusting for differences in body mass using analysis of covariance ANCOVA.
# Read and inspect the data.

moleRat <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter18/chap18e4MoleRatLayabouts.csv"))
head(moleRat)

# We are going to sort the data according to the value of the ln of body mass. This simplifies graphing of the model fits. The graph commands below assume that the data are sorted in this way.

moleRatSorted <- moleRat[ order(moleRat$lnMass), ]

# Scatter plot of the data.

plot(lnEnergy ~ lnMass, data = moleRat, type = "n", las = 1, bty = "l")
points(lnEnergy ~ lnMass, data = subset(moleRatSorted, caste == "worker"),
       pch = 1, col = "firebrick")
points(lnEnergy ~ lnMass, data = subset(moleRatSorted, caste == "lazy"),
       pch = 16, col = "firebrick")

# Fit models to the data, beginning with the model lacking an interaction term. Use lm because caste and mass are fixed effects. Save the predicted values in the data frame.

moleRatNoInteractModel <- lm(lnEnergy ~ lnMass + caste, data = moleRatSorted)
moleRatSorted$predictedNoInteract <- predict(moleRatNoInteractModel)

# Fit the full model, which includes the interaction term. Again, save the predicted values in the data frame.

moleRatFullModel <- lm(lnEnergy ~ lnMass * caste, data = moleRatSorted)
moleRatSorted$predictedInteract <- predict(moleRatFullModel)

# Visualize the model fits, beginning with the fit of the no-interaction model. Redraw the scatter plot (see commands above), if necessary, before issuing the following commands.

lines(predictedNoInteract ~ lnMass, data = subset(moleRatSorted,
                                                  caste == "worker"), lwd = 1.5)
lines(predictedNoInteract ~ lnMass, data = subset(moleRatSorted,
                                                  caste == "lazy"), lwd = 1.5)

# Visualize the fit of the full model, including the interaction term. Redraw the scatter plot, if necessary, before issuing the following commands.

lines(predictedInteract ~ lnMass, data = subset(moleRatSorted,
                                                caste == "worker"), lwd = 1.5, lty = 2)
lines(predictedInteract ~ lnMass, data = subset(moleRatSorted,
                                                caste == "lazy"), lwd = 1.5, lty = 2)

# Test the improvement in fit of the full model, including the interaction term. This is a test of the interaction term only.

anova(moleRatNoInteractModel, moleRatFullModel)

# Test for differences in ln body mass between castes, assuming that no interaction term is present in the mole rat population (i.e., assuming that the two castes hve equal slopes). Most commonly this is done using either "Type III" sums of squares (see footnote 5 on p 618 of the book) or "Type I" sums of squares (the default in R). The two methods do not give identical answers here because the design is not balanced (in a balanced design, each value of the x-variable would have the same number of y-observations from each group).
# Test using "Type III" sums of squares. We need to include a contrasts argument for the categorical variable in the lm command. Then we need to load the car package and use its Anova command. Note that "A" is in upper case in Anova().

moleRatNoInteractModelTypeIII <- lm(lnEnergy ~ lnMass + caste, data = moleRat,
                                    contrasts = list(caste = contr.sum))
library(car)
Anova(moleRatNoInteractModelTypeIII, type = "III") # note "A" in Anova is capitalized

# Test using "Type I" (sequential) sums of squares. Make sure that the covariate (lnMass) comes before the factor (caste) in the lm formula, as shown. Note that "a" is in lower case in anova.

moleRatNoInteractModel <- lm(lnEnergy ~ lnMass + caste, data = moleRat)
anova(moleRatNoInteractModel)

# Residual plot from the linear model.

plot( residuals(moleRatNoInteractModel) ~ fitted(moleRatNoInteractModel) )
abline(0,0)

# Normal quantile plot of residuals.

qqnorm(residuals(moleRatNoInteractModel), pch = 16, col = "firebrick",
       las = 1, ylab = "Residuals", xlab = "Normal quantile", main = "")

