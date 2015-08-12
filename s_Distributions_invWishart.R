rm(list=ls())
setwd("C:/Users/Ben/Dropbox/Bayesian book/Figures/")
library('rstan')
library('R.matlab')
library('boot')
library('pracma')
library('pscl')
library('actuar')
library('VisCov')

fit <- stan(file = 's_Distributions_invWishart.stan', data = list(nu=5),
            algorithm="Fixed_param",
            iter =200000, chains = 1,seed=1,warmup=1)
fit <- sampling(get_stanmodel(fit), data = list(nu=50),
                algorithm="Fixed_param",
                iter =200000, chains = 1,seed=1,warmup=1)
fitData <- as.data.frame(fit)

write.csv(file="s_Distributions_invWishart50.csv",fitData)
