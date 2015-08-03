data {
	int N; ## Number of samples
	int selector; ## Allows for selection of each of the types of prior distribution
	real lengths[N]; ## Actual data
	real cauchyParam;
	real gamParam;
	real chiParam;
	real unifParam;
  } 
  

parameters {
	real mu;
	real<lower=0> sigma; 
} 

model {
	lengths ~ normal(mu,sigma);
	
	if (selector==1){
		sigmaSq ~ cauchy(0,cauchyParam);
	}
	else if (selector == 2){
	    sigmaSq ~ inv_gamma(gamParam,gamParam);
	}
	else if (selector == 3){
	    sigmaSq ~ inv_chi_square(chiParam);
	}
	else {
	    sigmaSq ~ uniform(0,unifParam);
	}
	mu ~ normal(4.5,3);

 }

generated quantities {

 
}	