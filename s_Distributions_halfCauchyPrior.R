rm(list=ls())
setwd("C:/Users/Ben/Dropbox/Bayesian book/Figures/")
library('rstan')
library('R.matlab')
library('boot')
library('pracma')
library('pscl')
library('actuar')

N <- 3
lengths <- rnorm(N,4.5,3)


dataList = list(N=N,
                selector=1,
                lengths=lengths,
                cauchyParam=5,
                gamParam=0.0001,
                chiParam=0.01,
                unifParam=100
                )

# fit <- stan(file = 's_Distributions_halfCauchyPrior.stan', data = dataList, 
#             iter = 2000, chains = 1,seed=1)
print(fit)
fitData <- as.data.frame(fit)
hist(fitData$sigmaSq)

fit1 <- sampling(get_stanmodel(fit), data = list(N=N,
                                                 selector=4,
                                                 lengths=lengths,
                                                 cauchyParam=5,
                                                 gamParam=0.0001,
                                                 chiParam=0.01,
                                                 unifParam=100), 
            iter = 100000, chains = 1,seed=1)

fitData <- as.data.frame(fit1)
hist(fitData$sigmaSq,100,xlim=c(0,20))
print(fit1)
write.csv(fitData$sigmaSq,file="distributions_halfcauchy4.csv",row.names=FALSE)
