library(reprex);library(datapasta)
library (brms)

rstan_options (auto_write=TRUE)
options (mc.cores=parallel::detectCores ()) # Run on multiple cores

set.seed (607)

pois.data<-rpois(10, lambdaq= 10)

ir <- data.frame (scale (iris[, -5]), Species=iris[, 5])

### With improper prior it takes about 12 minutes, with about 40% CPU utilization and fans running,
### so you probably don't want to casually run the next line...

system.time (b1 <- brm (Species ~ Petal.Length + Petal.Width + Sepal.Length + Sepal.Width, data=ir,
                        family="categorical", n.chains=3, n.iter=3000, n.warmup=600))
                        )
install.packages(datapasta)
                 )
