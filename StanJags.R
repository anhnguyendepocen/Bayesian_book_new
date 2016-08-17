rm(list=ls())
library(rstan)
library(shinystan)
rstan_options(auto_write = TRUE)
setwd("C:/Users/Ben/Dropbox/Bayesian book/StanCode")

aModel <- stan_model('StanJags_samplingStatement.stan')
fit <- sampling(aModel,iter=100,chains=1)
theta <- extract(fit,'theta')[[1]]

bModel <- stan_model('StanJags_simpleNormal.stan')
Y <- rnorm(10,1.5,0.2)
cModel <- stan_model('StanJags_simpleNormal.rda')
fit1 <- stan('StanJags_simpleNormal.stan',iter=100,chains=4,data=list(Y=Y))
print(fit1)
mu <- extract(fit1,'mu')[[1]]
qplot(mu)
aFit <- as.shinystan(fit1)
launch_shinystan(aFit)


# Covariate model -------
N <- 100
X <- rnorm(N,60,10)
qplot(X)
alpha <- 0.1
beta <- 0.3
Y <- beta * log(X) + rnorm(N,0,0.3)
qplot(Y)

dModel <- stan_model('StanJags_simpleNormalCovariate.stan')
fit2 <- sampling(dModel,iter=200,chains=4,data=list(Y=Y,X=X,N=N))
print(fit2)

aFit <- as.shinystan(fit2)
launch_shinystan(aFit)

