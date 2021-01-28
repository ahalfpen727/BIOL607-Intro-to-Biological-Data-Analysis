Sign up to read and present one of the following from http://byrneslab.net/classes/biol607/readings/p_value_statements.zip

10_Ioannidis.pdf
11_Johnson.pdf
12_Lavine.pdf
13_Lew.pdf  - Elise Koob
14_Little.pdf Ross
15_Mayo.pdf
16_Millar.pdf  Zifeng
17_Rothman.pdf  Andrew Judell-Halfpenny
18_Senn.pdf Kelly
19_Stangl.pdf Kelly
1_Altman.pdf Elaine
20_Stark.pdf - Carolyn Wheeler
21_Ziliak.pdf / Daniel B.
2_Benjamin_Berger.PDF - Hannah Stroud
3_Benjamini.pdfBreck - Laura Howes
4_Berry.pdf   Kevin Mulkerrins
5_Carlin.pdf Anna
6_Cobb.pdf  - Shannon Davis
7_Gelman.pdf - Brianna Shaughnessy
8_Greenland.pdf Hannah Diebboll
9_Greenland_Senn_Rothman_Carlin_Poole_Goodman_Altman.pdf


-------
   QUIZ FOR MONDAY
http://bit.ly/t-test-pre-2018


10/1/18


Statistical Golems: take your data, parameterize it, and make sure its useful instead of leading down path of false conclusions

Z Test example
supposed box of 15 corgis
average of chest hair length between box, and gen population mean

want the difference between sample mean and population mean

Null: that they aren't different

Z test core: knowing something about population, and having your sample and assuming they aren't different


Philosophy

Question

Conceive model of system

(Breed is determined by chest hair length)

what data do you need to know to answer the question

what data do you need to parameterise your model (chest hair length)

experiment? what breadth of observations?

   Fit the model

Query the model (do the dogs in the box fit in or dffer from the model)

Z: test statisticm and compare to standard normal curve
1. know population mean, and standard deviation (assume std dev is same for pop and sample)
2. calc standard error (std dev/ sqrt(n))
3. calc T-statistic (Z)

assumptions about population and information drawn from data: if assumptions wrong- you're model will give you the wrong answer

lower sample sizes: fat tails, generally a lower peak- our assumption that we have a normal distribution is wrong

Student t distribution: based on sampling effort that has been put in

t=  data mean- mu/(stand dev from data/sqrt(n))

3/4 are drawn from data, only one assumption about the population

small samples will be a slightly different distribution that the population

T Distribution

assumes mean of 0, SD of 1, but changes shape based on its Degrees of Freedom (describes amount of sample effort put in)

for mean: degrees of freedom: N-1

for std dev: degress of freedom: N-2

deg of freedom: how much unique information you have, each time we calculate something- we use something and take it away

T test assumptions

- assume normal distribution

- assume equal variance

Unparied T test:

difference between 2 means/(pooled SD* sqrt(2/n))

assumptions go into denominator

2 group T test- assumes equal sample size --> change denominator if unequal sample size

Other ways to violate assumptions

unequal variance --> Welch's T test

residuals not normal-> transform, Non-Parametric Test, maybe use something entirely different


Z-test:
   Interested in the difference between sample mean and population mean- Null hyp is that they are not different

Want to calculate a test statistic (e.g. z) to query the model and compare to the standard normal curve (mean = 0, st.dev = 1)

Calc Z = mean of samples minus population mean and standardizing (dividing by) by standard error

Assume that error follows a normal distribution, assume population mean and st. dev

Fat tailed distribution - peak is lower, tails are fat (low sample sizes), therefore, should not use z test

Student-t distribution: based on how much sampling effort has been put in

Difference from z-test = instead of population st. dev, use st.dev from the sample data

Takes into account when you take sample the distribution will not be the same as that of the population

T and Normal distributions assume that world works in the same fundamental way; but degrees of freedom (amount of sampling effort) can change sampling distribution


Degrees of Freedom (aka number of free parameters): How much unique (free) information is there in calculating a parameter

T-test: estimating a mean (n-1 degrees of freedom), st. dev. (n-2 degrees of freedom)

Increase degrees of freedom (increasing sample size), then closer to normal distribution


T-statistic:
   To test for difference from 0, we assume population mean = 0; but other conditions can be used to look at differences

Bird Example:
   Question: Is there a difference?
   Model of System: Testosterone + Error (normally distributed) influences Immunity
What data needed: before and after implant, measure antibody production
Fit model to world
Query model to answer question

Paired t-test: mean difference between paired samples divided by st. error

Need to test assumptions: Assuming normal distribution

Assessing Normality:
   Visual inspection could be sufficient
Quantile-Quantile plot
Formal tests (e.g. Shapiro-Wilks test) (can have high Type I error rate)

QQ Plot: x=theoretical quantiles; y = sample quantiles

Can partition data into quantiles (e.g. 0%, 25%, 50%, 75%, 100%)

1/n quantitiles

*If values were normally distributed, there would be a linear relationship because the pattern of quantiles would be the same


What do you do about assumption violations?

   Choose different model (e.g. different distribution, non-parametric tests (lower power))

Apply transformation to data (e.g. log transformation)


Unpaired t-test:

   Difference between two means divided by pooled st.dev

Assumption that both groups have equal sample size (would have to change denominator formula if different)


Violations:
   Unequal sample sizes
Unequal population variances (Welch's t-test)
                              Residuals not normal - Transform - Non-Parametric Test

                              *Never just one test that will work, can usually use serval types/have many possibilities



                              10/3/2018

                              Class Notes:

                              Chi squared distribution is the square of a normal distribution.

                              Comparing observed vs. expectation

                              Always 1-tailed test


                              When you have 2 sets of categories: contingency table

                              Expected frequencies: probability; sum over categories


                              Assumptions of Chi Squared: No expected values less than 1; 80% of expected values must be >5.

                              -If violate assumptions: combine categories or use a different test (Fisher's Exact)






I can't make it to class today so I have attempted to summarize my assigned paper below- Hannah
Benjamin and Berger provide an alternative to p-values. They recognized that alternatives to the p-test fail because they are either more complicated and/or not acceptable to both frequentist and Bayesian schools of thought.

They propose replacing the p-value with the Bayes factor:

Bayes factor: B= (avg likelihood of observed data under alternative H/likelihood of observed data under the null)

(For reasons I don't understand, the Bayes factor satisfies both frequentist and Bayesian schools of thought.)

The best way to use Bayes factor is actually the upper limit of B (ie the largest possible B over any reasonable choice of prior distribution for the alternative hypothesis). The Bayes factor makes results which just reach conventional levels of significance look weak for rejecting the null- a Bayesian factor that corresponds to a p value of 0.05 favors the alternative hypothes2.44:1. They state the upper of B would indicate the strongest potentially justifiable inference from the data and prevent researchers from concluding too much from statistical significance of a finding.

They also suggested, in lieu of p-values that researchers calculate the pre-experimental odds of correct rejection to incorrect rejection of the null. This would be a result of multiplying the prior odds and a frequentist component called the rejection ratio. The rejection ratio is the ratio of Power of experiment to the Type I error of the experiment (ie the probability of rejection when the alternative is true, divided by the probability of rejection when the null is true). However this doesn't satisfy Bayesian school of thought (I think).

Kelly - Senn & Stangl (I'll be in class, but I figured it would be easier to put the main points of my readings here)
Senn: Are P-values the problem?
   1) The problem can be broken down into inference and idolization of p-values
2) Human pyschology and society, specifically academic culture, also pose problems
3) Criticism for p-values misplaced -> look at history
4) Modern critcism of p-values is a result of comparing direct interpretation with indirect interpretation (from Jeffreys 1961)
* The Bayesian "wars" are a bit confusing because I barely understand Bayesian methods, but hopefully this can be an item of discussion

Stangl: Role of Statistical Education Community
1) Responsibility of educators to teach about the misuse of p-values and to teach "suitable" alternatives (i.e. Bayesian decision theoretic methods)
2) Educators further perpetuate misuse by improving ways to conceptualize p-values like resampling and randomization methods
* Despite being short, I think Stangl commentary raises interesting questions about the role of statistical educators and their pedagogical approaches.

Kevin- Summary of Berry
Greatly in favor of the statement. Says that there have been criticisms about the use of p value for 50 years and that these criticisms have had no impact. Statisticians don't fully undertand the issues in applied settings
Collective credibility of statistics in the scientific community at risk because of failure to understand the issues.
Ignorance about statistical significance and misuse by scientists are the fault of statisticians, and statisticians need to do better at informing of proper use of p value
Problems:
-statistically significant conclusions often not reproduced
-undermining of public trust in the validity of studies
-Statistics texts fail to address potential confusion statistical measures can create in practical applications
-p values may have no inferential content, be scientifically meaningless, and may not be reproduced
-p values are good for measures of extremity, errors occur when attributing scientific import

Expansions on Principles 1 and 4:
-P values are descriptive summaries of a dataset but has no inferential content. Inferences require a broader interpretation of what data means than one based on numbers alone
-P values ignore many aspects of evidence in the experiment including information that is obviously known
-The specifics of data collection and motivation are critical for inference (for example is one data point an average of two measurements rather than another based on one and why is that)
-When viewed alone p values calculated from a set of numbers and assuming a statistical model are frequently meaningless
-Black box warning: "OUr study is exploratory and we make no claims for generalizability. Statistical calculations such as p-values and confidence intervals are descriptive only and have no inferential content."
-P values sometimes appropriate for inference, for example in drug regulation since a primary endpoint and its analysis is unambiguously stated

Statisticians are in a good position to teach scientists about the reproduceability of research. The remedy is changing the way statisticians are trained, and statisticians in turn will retrain the rest of the world.
Vast majority of small p values do not deserve the label statistically significant and do not imply any relevance.
Proposing alternatives is not the purpose of Berry's rejoinder, but rather to discuss propriety of using certain statistical tools

Lew Paper Summary-Elise Koob
Lew points out that the ASA statement does not detail how or when some standard practices are considered as “P-value hacking” or “cherrypicking.” The author provides 3 questions that p-values are often used to answer and suggests other analyses to pursue instead.
1.       What do these data say?

    Alternative: Use a likelihood function: “it allows comparison of all evidential support for all values of a parameter of interest”, i.e. not just the null hypothesis.

2.       What should I believe now that I have these data?

    Alternative: Use Bayesian methods with a prior probability distribution.

3.       What should I do or decide now that I have these data?

    Alternative: Should be answered while considering what the data say along with costs/benefits of certain decisions. Recommends Neyman & Pearson hypothesis test which includes a loss function to balance between false positive and negative error rates.

*Stresses that if p-values are used, a pre-study power analysis is required and comparisons should include a loss function.


