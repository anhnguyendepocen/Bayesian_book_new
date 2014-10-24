clear; close all; clc;

N = 100; % Number in sample
X = 30; % Number that test disease positive
a = 1; % Selects a uniform prior
b = 1;
n_points = 1000;

v_theta = linspace(0,1,n_points);
v_prior = betapdf(v_theta,a,b);
v_theta = linspace(0,1,n_points);
v_likelihood = binopdf(X,N,v_theta)';
v_posterior = betapdf(v_theta,X+a,N-X+b);

f_priorLikelihoodPosteriorPlotter_null(v_theta,v_prior,v_likelihood,v_posterior)