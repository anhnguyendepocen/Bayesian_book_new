clear; close all; clc;

v_prior = [1/12;1/6;1/4;1/4;1/6;1/12];
v_likelihood = zeros(6,1);

for i = 1:6
    v_likelihood(i) = (i-1)/5;
end

v_posterior = v_prior.*v_likelihood/sum(v_prior.*v_likelihood);

subplot(3,1,1),
bar(v_prior)
title('Prior')
set(gca,'XTickLabel',{'0', '1', '2','3','4','5'})
ylabel('pmf')
subplot(3,1,2),
bar(v_likelihood)
title('Likelihood')
ylabel('likelihood')
set(gca,'XTickLabel',{'0', '1', '2','3','4','5'})
subplot(3,1,3),
bar(v_posterior)
title('Posterior')
set(gca,'XTickLabel',{'0', '1', '2','3','4','5'})
xlabel('Number of red balls')
ylabel('pmf')