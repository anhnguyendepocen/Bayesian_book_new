clear; close all; clc;

x1 = 0;
x2 = 1;
theta = 0:0.001:1;
L1 = (theta.^x1).*(1-theta).^(1-x1);
L2 = (theta.^x2).*(1-theta).^(1-x2);
subplot(2,2,3),plot(theta,L1,'b',theta,L2,'r','LineWidth',3)
legend('No disease','Disease')
xlabel('\theta')
ylabel('Likelihood')
hold on
plot(0.25*ones(length(theta),1),0:0.001:1,'k--')
plot(0.5*ones(length(theta),1),0:0.001:1,'k--')
plot(0.75*ones(length(theta),1),0:0.001:1,'k--')
scatter([0.25,0.25,0.5,0.75,0.75],[0.25,0.75,0.5,0.25,0.75],'k','filled')
hold off
subplot(2,2,1),plot(theta,L1+L2,'g','LineWidth',3)
ylabel('Sum of probabilities')
xlabel('\theta')
hold on
plot(0.25*ones(length(theta),1),0:0.001:1,'k--')
plot(0.5*ones(length(theta),1),0:0.001:1,'k--')
plot(0.75*ones(length(theta),1),0:0.001:1,'k--')
hold off
subplot(2,2,4),bar([0.5,0.5])
xlabel('Status')
ylabel('Sum of likelihood')
ylim([0 1])
str = {'No disease','Disease'};
set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
