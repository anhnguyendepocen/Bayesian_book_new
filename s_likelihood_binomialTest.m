clear; close all; clc;

N = 100;
v_x = 10:100;
c_prop = sum(binopdf(v_x,N,0.01));