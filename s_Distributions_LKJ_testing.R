rm(list=ls())
setwd("C:/Users/Ben/Dropbox/Bayesian book/Figures/")
library('rstan')
library('R.matlab')
library('boot')
library('pracma')
library('pscl')
library('actuar')
library('VisCov')

fit <- stan(file = 's_Distributions_LKJ_testing.stan', data = list(eta=100),
              algorithm="Fixed_param",
            iter =2000000, chains = 1,seed=1,warmup=1)
fit <- sampling(get_stanmodel(fit), data = list(eta=10000),
            algorithm="Fixed_param",
            iter =2000000, chains = 1,seed=1,warmup=1)

fitData <- as.data.frame(fit)
tMean <- fitData[,1:10]
sum(tMean)/10000
write.csv(file="s_Distributions_LKJ.csv",fitData)

distribution = "Inverse Wishart"
dim = 4
param = list(prob = 0.5, dim = dim, nu = dim+1, scaleCov = diag(1,dim))
CovPlotData = VisCov(distribution, param, title.logical = FALSE)

