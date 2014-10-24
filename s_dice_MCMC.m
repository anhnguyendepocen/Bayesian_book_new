clear; close all; clc;
% A script which simulates the PDF from a die via Monte Carlo

% Throw the dice N times
N = 10000;
v_dice = randi(6,N,1);

% Show the simulated PDF
v_a = hist(v_dice);
v_a = v_a(v_a>0);
bar(v_a/sum(v_a))

