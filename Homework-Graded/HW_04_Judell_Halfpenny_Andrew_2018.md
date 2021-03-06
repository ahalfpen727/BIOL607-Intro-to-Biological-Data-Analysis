---
title: 'BIOL-607 Biological Data Analysis Homework 04: Hypothesis Testing'
author: "Andrew Judell-Halfpenny"
date: "September 27, 2018"
output: 
  slidy_presentation: 
    keep_md: yes
---

# Environment Prepration


```r
library(knitr);library(rmarkdown)
#install.packages("revealjs")
#devtools::install_github(gganimate)
#devtools::install_github(treeio)
```

# Environment Initialization
   

```r
library(animation);library(ggvis);library(gganimate)
```

```
## Loading required package: ggplot2
```

```
## 
## Attaching package: 'ggplot2'
```

```
## The following object is masked from 'package:ggvis':
## 
##     resolution
```

```
## 
## Attaching package: 'gganimate'
```

```
## The following object is masked from 'package:ggvis':
## 
##     view_static
```

```r
library(devtools);library(dplyr);library(ggplot2)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(readr);library(magrittr);library(revealjs)
library(tidyr);library(tidygraph);library(lubridate)
```

```
## 
## Attaching package: 'tidyr'
```

```
## The following object is masked from 'package:magrittr':
## 
##     extract
```

```
## 
## Attaching package: 'tidygraph'
```

```
## The following object is masked from 'package:stats':
## 
##     filter
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following object is masked from 'package:base':
## 
##     date
```

```r
library(ggtree);library(forcats)
```

```
## Loading required package: treeio
```

```
## ggtree v1.10.5  For help: https://guangchuangyu.github.io/ggtree
## 
## If you use ggtree in published research, please cite:
## Guangchuang Yu, David Smith, Huachen Zhu, Yi Guan, Tommy Tsan-Yuk Lam. ggtree: an R package for visualization and annotation of phylogenetic trees with their covariates and other associated data. Methods in Ecology and Evolution 2017, 8(1):28-36, doi:10.1111/2041-210X.12628
```

```
## 
## Attaching package: 'ggtree'
```

```
## The following object is masked from 'package:tidyr':
## 
##     expand
```

```
## The following object is masked from 'package:magrittr':
## 
##     inset
```

```
## The following object is masked from 'package:dplyr':
## 
##     collapse
```

---

# Part 1-W&S Chapter 6 questions 15, 21, 29

> 15) For the following alternative hypotheses, give the appropriate null hypothesis.

---

## 15.a) H~a~ = Pygmy mammoths and continental mammoths differ in their mean femur lengths.
> H~0~ = Mean femur lengths for Pygmy mammoths and continental mammoths equal.

## 15.b) H~a~ = Patients who take phentermine and topira-mate lose weight at a different rate than control patients without these drugs.
> H~0~ = Patients who take phentermine and topira-mate lose weight at a the same rate as control patients without these drugs.

## 15.c) H~a~ = Patients who take phentermine and topiramate have different proportions of their babies born with cleft palates than do patients not taking these drugs.
> H~0~ = Patients who take phentermine and topiramate the same proportions of their babies born with cleft palates than do patients not taking these drugs.

## 15.d) H~a~ = Shoppers on average buy different amounts of candy when Christmas music is playing in the shop compared to when the usual type of music is playing.
> H~0~ =Shoppers on average buy the same amount of candy when Christmas music is playing in the shop compared to when the usual type of music is playin

## 15.e) H~a~ = Male white-collared manakins (a tropical bird) dance more often when females are present than when they are absent.
> H~0~ = Male white-collared manakins (a tropical bird) dance exactly as often when females are present as when they are absent.

---

## 21) Imagine that two researchers independently carry out clinical trials to test the same null hypothesis, that COX-2 selective inhibitors (which are used to treat arthritis) have no effect on the risk of cardiac arrest. They use the same population for their study, but one experimenter uses a sample size of 60 participants, whereas the other uses a sample size of 100. Assume that all other aspects of the studies, including significance levels, are the same between the two studies.

---

## 21.a) Which study has the higher probability of a Type II error, the 60-participant study or the 100-participant study?
> The 60-participant study has  a greater probability of producing a Type II error than the 100-participant study.  This is proportiion of participants chosen from random sample from the 60 participant study that produce a result that leads to rejection of a false null hypothesis is greater than the proportion in the 100 participant study.

## 21.b) Which study has higher power?
> The 100-participant study has greater power because of its reduced likelihood of a Type II error.

## 21.c) Which study has the higher probability of a Type I error?
> The study with 100 patients has a higher probability of a Typer I error (false positive) 

## 21.d) Should the tests be one-tailed or two-tailed? Explain.
> In each one of these statistical tests the null hypothesis is that there is no difference (up or down) between the two populations and therefor requires a two-tailed test.

---

# 29)  A team of researchers conducted 100 independent hypothesis tests using a significance level of α = 0.05.
## a) If all 100 null hypotheses were true, what is the probability that the researchers would reject none of them?
> At an alpha level of 0.05, the probability of 100 out of 100 true null hypotheses can be calculated from the discrete binomial distribution function with success defined as a type I error, and a rejection of the null hypothesis.


```r
pbnn<-dbinom(0, 100, 0.05)
pbnmp<-pbnn * 100
paste0(pbnmp,sep="%")
```

```
## [1] "0.592052922033403%"
```

## b)  If all 100 null hypotheses were true, how many of these tests on average are expected to reject the null hypothesis?
> Give 100 true null hypotheses, and the previously stated alpha level (0.05), 5 tests are expected to cause researchers to reject the null hypothesis.

---

# Part 2 W & S Chapter 7 questions 22

## 22) In a test of Murphy’s law, pieces of toast were buttered on one side and then dropped. Murphy’s law predicts that they will land butter-side down. Out of 9821 slices of toast dropped, 6101 landed butter-side down.

---

# 22.a) What is a 95% confidence interval for the probability of a piece of toast landing butter-side down? 
> Manual calculation of proportional confidence interval
 

```r
n=9821 # butter-side-down toast
p.hat=6101/n # Proportion estimate of the sample
p.hat
```

```
## [1] 0.6212198
```

```r
z=1.96  # for 95% confidence interval
se.p.est=((p.hat*(1-p.hat)/n)^.5)  # std.err
p.hatl=p.hat - (z*se.p.est)
p.hath=p.hat + (z*se.p.est)
paste0(p.hatl,sep=" to ", p.hath)
```

```
## [1] "0.611625950514112 to 0.630813719580583"
```

```r
# The 95% confidence interval of the proportion is from 
```

---
# 22.a) The binom.test function performs an automated version of the steps that were just performed


```r
dropped.bread.proportion<-binom.test(6101, n = 9821)
dropped.bread.proportion
```

```
## 
## 	Exact binomial test
## 
## data:  6101 and 9821
## number of successes = 6101, number of trials = 9821, p-value <
## 2.2e-16
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.6115404 0.6308273
## sample estimates:
## probability of success 
##              0.6212198
```

---

# 22.b) Using the results of part a), is it plausible that there is a 50:50 chance of the toast landing butter-side down or butter-side up?
> Given that the 95% confidence interval for the proportion of the population of butter side down slices of dropped bread is from 0.611626 to 0.6301837 and doesn't include 0.5, it would be incorrect to characterize the chances as 50:50. To produce a p-value for the hypothesis that the proportion of butter-down bread slices can be characterized as 50:50 despite a priori estimate of proportion of 0.6116 via sampling, the prop.test function can be used with the expected number of butter-down slices for 9821 trials given probability of 50:50 


```r
# assuming a 50:50 chance, the nnumber of butter side down slices in 9821 trials
std.er.not<-n/2
prop.test(round(std.er.not), n=n,p=p.hat,correct=F)        
```

```
## 
## 	1-sample proportions test without continuity correction
## 
## data:  round(std.er.not) out of n, null probability p.hat
## X-squared = 613.81, df = 1, p-value < 2.2e-16
## alternative hypothesis: true p is not equal to 0.6212198
## 95 percent confidence interval:
##  0.4900623 0.5098359
## sample estimates:
##         p 
## 0.4999491
```

---
# Part 3: From the Lab: A Simulation of Many SDs and Alphas
>- Here’s the exercise we started in lab. Feel free to look back copiously at the lab handout if you’re getting stuck. Remember, for each step, write-out in comments what you want to do, and then follow behing with code. 
>- Now, let’s assume an average population-wide resting heart rate of 80 beats per minute with a standard deviation of 6 BPM. 
>- A given drug speeds people’s heart rates up on average by 5 BPM. What sample size do we need to achieve a power of 0.8?

---

# Answer:
>- Using three standard deviations centered around the mean BPM, a distribution spanning 6 standard deviations was crafted to sample.
>- Extrene values were identified to represent the tails of the distribution and the area under the individual tails was verifired from a hypothesis test


```r
hrl<-80-(2*6); hrl # floor of 95% of the distribution of BPM
```

```
## [1] 68
```

```r
hrh<-80+(2*6); hrh # ceiling of 95 of the distribution of BPM
```

```
## [1] 92
```

>- An initial distribution of 2000, mean of 80 bpm, and a standard deviation 6 bpm from which to draw samples. Extreme and unlikely values in either direction were identified from one less than 3 standard deviations (63 and 97). 


```r
# The entire range of human BPM rates
hrh.avg <- c(seq(62,98, length.out=2000))
# The proportion of the distribution each section represents
#prob_observed =  c(rep(0.9/1000, 1000), rep(0.1/1000, 1000))
prob_observed =  c(rep(0.05/100, 100), rep(0.9/1800, 1800), rep(0.05/100, 100))
samp <- sample(hrh.avg, 10000, replace=TRUE,   # 100000
               prob = prob_observed)
#samp <- sample(hrh.avg, 2000, replace=TRUE,   # 100000
 #              prob = prob_observed)
# The area under both tails as well as each individual tail
length(which(samp >= 97 | samp <= 63))/length(samp)
```

```
## [1] 0.0528
```

# 3.1) Start the Simulation
> Make a simulated data frame to look at the effects of multiple sample sizes: from 1-20, with 500 simulations per sample size, and also multiple SD values, from 3 through 10.


```r
#first make a data frame with a priori mean centered 80 BPM but sample from SD from 3-10
sim_data <- data.frame(samps = rep(1:20, 500), sd = rep(x=c(3:10), each=20, length.out=10000)) %>%
  #a trick - group by 1:n() means you don't need sim numbers!
  group_by(1:n()) %>%
  #get a sample mean
  mutate(sample = mean(rnorm(samp, 85, 6))) %>%
  #clean up
  ungroup()
```

# 3.2) Z-Tests
# Now the simulated data can be used to perform hypothesis tests.


```r
sim_data <- sim_data %>%
  mutate(se_y = sd/sqrt(samps)) %>%
  mutate(z = (sample-80)/se_y) %>%
  mutate(p = 2*pnorm(abs(z), lower.tail=FALSE))

ggplot(data = sim_data, mapping = aes(x=samps, y=p, color=sd)) +
  geom_jitter(alpha=0.4) 
```

![](HW_04_Judell_Halfpenny_Andrew_2018_files/figure-slidy/unnamed-chunk-5-1.png)<!-- -->

# 3.3) P and Power
> Now plot power for an alpha of 0.05, but use color for different SD values. Include our threshold power of 0.8.


```r
sim_power.samp <- sim_data %>%
   group_by(samps) %>%
  mutate(power = 1-sum(p>0.05)/n()) %>% 
  ungroup()

ggplot(data=sim_power.samp, mapping = aes(x=samps, y=power, color=sd)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept=0.8, lty=2)
```

![](HW_04_Judell_Halfpenny_Andrew_2018_files/figure-slidy/unnamed-chunk-6-1.png)<!-- -->

```r
  scale_color_discrete(guide = guide_legend(title=expression(sd)))
```

```
## <ggproto object: Class ScaleDiscrete, Scale, gg>
##     aesthetics: colour
##     axis_order: function
##     break_info: function
##     break_positions: function
##     breaks: waiver
##     call: call
##     clone: function
##     dimension: function
##     drop: TRUE
##     expand: waiver
##     get_breaks: function
##     get_breaks_minor: function
##     get_labels: function
##     get_limits: function
##     guide: guide, legend
##     is_discrete: function
##     is_empty: function
##     labels: waiver
##     limits: NULL
##     make_sec_title: function
##     make_title: function
##     map: function
##     map_df: function
##     n.breaks.cache: NULL
##     na.translate: TRUE
##     na.value: grey50
##     name: waiver
##     palette: function
##     palette.cache: NULL
##     position: left
##     range: <ggproto object: Class RangeDiscrete, Range, gg>
##         range: NULL
##         reset: function
##         train: function
##         super:  <ggproto object: Class RangeDiscrete, Range, gg>
##     reset: function
##     scale_name: hue
##     train: function
##     train_df: function
##     transform: function
##     transform_df: function
##     super:  <ggproto object: Class ScaleDiscrete, Scale, gg>
```


# 3.4) Many alphas

# Last, use crossing again to explore changing alphas from 0.01 to 0.1. Plot power curves with different alphas as different colors, and use faceting to look at different SDs.


```r
sim_tradeoff <- sim_data %>%
   #more alphas!
 crossing(alpha = 10^(-1:-10)) %>%
    #now calculate power for each alpha
  group_by(sd, alpha) %>%
   # group_by(samps, alpha) %>%
  summarise(power = 1-sum(p>alpha)/length(samps)) %>%
  ungroup()

ggplot(data=sim_tradeoff, mapping = aes(x=sd, y=power, color=sd)) +
  geom_point() +
  geom_line() +
  geom_hline(yintercept=0.8, lty=2)
```

![](HW_04_Judell_Halfpenny_Andrew_2018_files/figure-slidy/powerplot-1.png)<!-- -->

```r
sim_tradeoff <- sim_data %>%
  #more alphas!
  crossing(alpha = 10^(-1:-10)) %>%
  #now calculate power for each alpha
  group_by(samps, alpha) %>%
  summarise(power = 1-sum(p>alpha)/500) %>%
  ungroup()

ggplot(sim_tradeoff) +
  aes(x=samps, y=power, color=factor(alpha)) +
  geom_point() + geom_line() +
  xlab("Sample Size") +
  
  scale_color_discrete(guide = guide_legend(title=expression(alpha)))
```

![](HW_04_Judell_Halfpenny_Andrew_2018_files/figure-slidy/powerplot-2.png)<!-- -->


