data {

  } 
  

parameters {

} 

model {


 }

generated quantities {
  vector[10] tSamples;
  matrix[10,10] aSigmaIdentity;
  vector[10] mu;
  mu <- rep_vector(15,10);
  
  aSigmaIdentity <- diag_matrix(rep_vector(1.0, 10));
  tSamples <- multi_student_t_rng(3,mu,aSigmaIdentity);
}	