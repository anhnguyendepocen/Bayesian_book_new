data {

  real nu;

  } 
  

parameters {

} 

model {


 }

generated quantities {
  matrix[4,4] aSigma;
  aSigma <- wishart_rng(nu,diag_matrix(rep_vector(1.0, 4)));
}	