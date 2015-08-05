rm(list=ls())

fit <- stan(file = 's_Distributions_multiT_testing.stan', algorithm="Fixed_param",
             iter = 2000, chains = 1,seed=1)

fitData <- as.data.frame(fit)
tMean <- fitData[,1:10]
sum(tMean)/10000
