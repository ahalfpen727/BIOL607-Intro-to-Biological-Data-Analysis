# Fitting probability models to frequency data: R code for Chapter 8 examples
# Download the R code on this page as a single file <a href="../wp-content/rcode/chap08.r">here.
# ------------------------------------------------------------

# Example 8.1. <a href="../wp-content/data/chapter08/chap08e1DayOfBirth.csv">Birth days of the week
# Fit the proportional probability model to frequency data.
# Read and inspect the data. Each row represents a single birth, and shows the day of the week of birth.

birthDay <- read.csv(url("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter08/chap08e1DayOfBirth.csv"))
head(birthDay)

# Put the days of the week in the correct order for tables and graphs.

birthDay$day <- factor(birthDay$day, levels = c("Sunday", "Monday",
 	"Tuesday", "Wednesday","Thursday","Friday","Saturday"))

# Frequency table of numbers of births (Table 8.1-1).

birthDayTable <- table(birthDay$day)
data.frame(Frequency = addmargins(birthDayTable))

# Bar graph of the birth data. The argument cex.names = 0.8 shrinks the names of the weekdays to 80% of the default size so that they fit in the graphics window -- otherwise one or more names may be dropped.

barplot(birthDayTable, cex.names = 0.8)

# Commands for a bar graph with more options (Figure 8.1-1) are given here.
# shortNames = substr(names(birthDayTable), 1, 3)
# barplot(table(birthDay$day), names = shortNames, 
# 	ylab = "Frequency", las = 1, col = "firebrick")
# &chi;2 goodness-of-fit test. The vector p is the expected proportions rather than the expected frequencies, and they must sum to 1 (R nevertheless uses the expected frequencies when calculating the &chi; statistic). The &chi;2 value you get here is slightly more accurate than the calculation in the book, which was affected by rounding.

chisq.test(birthDayTable, p = c(52,52,52,52,52,53,52)/365)

# ------------------------------------------------------------

# Example 8.4. <a href="../wp-content/data/chapter08/chap08e4XGeneContent.csv">Gene content of the human X chromosome
# Goodness-of-fit of the proportional model to data with two categories.
# Read and inspect the data. Each row is a different gene, with its occurrence on the X chromosome indicated.

geneContent <- read.csv(url("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter08/chap08e4XGeneContent.csv"))
head(geneContent)

# Order the categories as desired for tables and graphs.

geneContent$chromosome <- factor(geneContent$chromosome, levels = c("X","NotX"))

# Frequency table showing the number of genes on the X and on other chromosomes.

geneContentTable <- table(geneContent$chromosome)
data.frame(Frequency = addmargins(geneContentTable))

# The &chi;2 goodness-of-fit test to the proportional model.

chisq.test( geneContentTable, p = c(1055, 19235)/20290 )

# The Agresti-Coull 95% confidence interval for the proportion of genes on the X. The command here assumes that you have installed the binom package (see the R pages for Chapter 7).

library(binom)
binom.confint(781, n = 20290, method = "ac")

# ------------------------------------------------------------

# Example 8.5. <a href="../wp-content/data/chapter08/chap08e5NumberOfBoys.csv">Designer two-child families?
# Goodness-of-fit of the binomial probability model to data on the number of male children in two-child families.
# Read and inspect the data. Each row represents a family.

nBoys <- read.csv(url("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter08/chap08e5NumberOfBoys.csv"))
head(nBoys)

# Frequency table of the number of boys in 2-child families. 

nBoysTable <- table(nBoys)
data.frame(Frequency = addmargins(nBoysTable))

# Estimate the proportion of boys p. Calculate as the mean number of boys in families divided by family size (2).

pHat <- mean(nBoys$numberOfBoys)/2

# Calculate proportion of families in each category expected under the binomial distribution.

expectedPropFams <- dbinom(0:2, size = 2, prob = pHat)
data.frame(nBoys = c(0,1,2), Proportion = expectedPropFams)

# Show the expected number of families in each category under the null hypothesis of a binomial distribution.

data.frame(nBoys = c(0,1,2), Families = expectedPropFams * 2444)

# &chi;2 goodness-of-fit test. R doesn't know that you've estimated the proportion of boys, the proportion is not specified by the null hypothesis, so it won't use the correct degrees of freedom. Ignore the P-value that results. Instead, we need to take the &chi;2 value calculated by chisq.test and recalculate P using the correct degrees of freedom.

saveChiTest <- chisq.test(nBoysTable, p = expectedPropFams)
saveChiTest
# Wrong degrees of freedom, wrong P-value! Here's how to make things right:
pValue <- 1 - pchisq(saveChiTest$statistic, df = 1)
pValue

# ------------------------------------------------------------

# Example 8.6. <a href="../wp-content/data/chapter08/chap08e6MassExtinctions.csv">Mass extinctions
# Goodness-of-fit of the Poisson probability model to frequency data on number of marine invertebrate extinctions per time block in the fossil record.
# Read and inspect the data. Each row is a time block, with the observed number of extinctions listed.

extinctData <- read.csv(url("http://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter08/chap08e6MassExtinctions.csv"))
head(extinctData)

# Generate the frequency table for the number of time blocks in each number-of-extinctions category. Notice that a simple table does what's needed, but some extinction categories are not represented (e.g., 0, 12 and 13 extinctions). 

extinctTable <- table(extinctData$numberOfExtinctions)
data.frame(Frequency = addmargins(extinctTable))

# To remedy the problem of missing categories, save the original variable as a factor that has all counts between 0 and 20 as levels (note that 20 is not the maximum possible number of extinctions, but it is a convenient cutoff for this table).

extinctData$nExtinctFactor <- factor(extinctData$numberOfExtinctions, levels = c(0:20))
extinctTable2 <- table(extinctData$nExtinctFactor)
data.frame(Frequency = addmargins(extinctTable2))

# Estimate the mean number of extinctions per time block from the data. The estimate is needed for the goodness-of-fit test.

meanExtinctions <- mean(extinctData$numberOfExtinctions)
meanExtinctions

# Calculate expected frequencies under the Poisson distribution using the estimated mean. (For now, continue to use 20 extinctions as the cutoff, but don't forget that the Poisson distribution includes the number-of-extinctions categories 21, 22, 23, and so on.)

expectedProportion <- dpois(0:20, lambda = meanExtinctions)
expectedFrequency <- expectedProportion * 76

# Show the frequency distribution in a histogram.

hist(extinctData$numberOfExtinctions, right = FALSE, breaks = seq(0, 21, 1),
	xlab = "Number of extinctions")

# Commands for a fancier histogram, with the expected frequencies overlaid (Figure 8.6-2), are shown here.

# The tricky part is to have the curve overlay the midpoints 
#	of the bars, not bar edges, for optimal visual comparison
hist(extinctData$numberOfExtinctions, right = FALSE, breaks = seq(0, 21, 1),
	las = 1, col = "firebrick", xaxt = "n", main = "", 
	xlab = "Number of extinctions")
axis(1, at = seq(0.5, 20.5, 1), labels = seq(0,20,1))  
lines(expectedFrequency ~ c(0:20 + 0.5), lwd = 2) 

# <hr class = "short">
# Make a table of observed and expected frequencies, saving as a data frame.

extinctFreq <- data.frame(nExtinct = 0:20, obsFreq = as.vector(extinctTable2), 
	expFreq = expectedFrequency)
extinctFreq

# The low expected frequencies will violate the assumptions of the &chi;2 test, so we will need to group categories. Create a new variable that groups the extinctions into fewer categories.

extinctFreq$groups <- cut(extinctFreq$nExtinct, 
	breaks = c(0, 2:8, 21), right = FALSE,
	labels = c("0 or 1","2","3","4","5","6","7","8 or more"))
extinctFreq

# Then sum up the observed and expected frequencies within the new categories.

obsFreqGroup <- tapply(extinctFreq$obsFreq, extinctFreq$groups, sum)
expFreqGroup <- tapply(extinctFreq$expFreq, extinctFreq$groups, sum)
data.frame(obs = obsFreqGroup, exp = expFreqGroup)

# The expected frequency for the last category, "8 or more", doesn't yet include the expected frequencies for the categories 21, 22, 23, and so on. However, the expected frequencies must sum to 76. In the following, we recalculate the expected frequency for the last group, expFreqGroup[length(expFreqGroup)], as 76 minus the sum of the expected frequencies for all the other groups.

expFreqGroup[length(expFreqGroup)] = 76 - sum(expFreqGroup[1:(length(expFreqGroup)-1)])
data.frame(obs = obsFreqGroup, exp = expFreqGroup)

# Finally, we are ready to carry out the &chi;2 goodness-of-fit test. R gives us a warning here because one of the expected frequencies is less than 5. However, we have been careful to meet the assumptions of the &chi;2 test, so let's persevere. Once again, R doesn't know that we've estimated a parameter from the data (the mean), so it won't use the correct degrees of freedom when calculating the P-value. As before, we need to grab the &chi;2 value calculated by chisq.test and recalculate P using the correct degrees of freedom. Since the number of categories is now 8, the correct degrees of freedom is 8 - 1 - 1 = 6.

saveChiTest <- chisq.test(obsFreqGroup, p = expFreqGroup/76)
saveChiTest # Wrong degrees of freedom, so wrong P-value!
pValue <- 1 - pchisq(saveChiTest$statistic, df = 6)
unname(pValue) # correct P-value!

