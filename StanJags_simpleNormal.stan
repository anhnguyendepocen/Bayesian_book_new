data {
    real Y[10]; // Heights for 10 people
}

parameters {
    real mu; // mean height in population
    real<lower=0> sigma; //sd of height pop distribution
}

model {
    for(i in 1:10){
        Y[i] ~ normal(mu,sigma); // Likelihood
    }
    mu ~ normal(1.5,0.1); // Prior for mu
    sigma ~ gamma(1,1); // Prior for sigma
}

generated quantities{
   vector[10] lSimData;
    int aMax_indicator;
    int aMin_indicator;
      
    // Generate posterior predictive samples
    for(i in 1:10){
      lSimData[i] = normal_rng(mu,sigma);
    }
     
    // Compare with real data 
    aMax_indicator = max(lSimData) > max(Y);
    aMin_indicator = min(lSimData) < min(Y);
}