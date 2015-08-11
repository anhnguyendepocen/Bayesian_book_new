data {

  real eta;

  } 
  

parameters {

} 

model {


 }

generated quantities {
  matrix[4,4] aSigma;
  aSigma <- lkj_corr_rng(4,eta);
  
}	