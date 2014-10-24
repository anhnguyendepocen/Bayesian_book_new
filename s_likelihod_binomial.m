clear; close all; clc;

N = 2;
c_beta1 = 0;
c_beta2 = 1;
c_beta3 = 2;
v_theta = 0:0.01:1;
v_likelihood1 = binopdf(c_beta1,N,v_theta);
v_likelihood2 = binopdf(c_beta2,N,v_theta);
v_likelihood3 = binopdf(c_beta3,N,v_theta);
subplot(2,2,3),plot(v_theta,v_likelihood1,'b','LineWidth',3)
hold on
plot(v_theta,v_likelihood2,'r','LineWidth',3)
plot(v_theta,v_likelihood3,'g','LineWidth',3)
plot(0.25*ones(length(v_theta),1),0:0.01:1,'k--')
plot(0.5*ones(length(v_theta),1),0:0.01:1,'k--')
plot(0.75*ones(length(v_theta),1),0:0.01:1,'k--')
scatter([0.25,0.25,0.25,0.5,0.5,0.75,0.75,0.75],[0.56,0.38,0.06,0.25,0.5,0.56,0.38,0.06],'k','filled')

xlabel('\theta')
ylabel('Likelihood')
legend('Zero cases','One case','Two cases')
hold off
subplot(2,2,1),plot(v_theta,v_likelihood1+v_likelihood2+v_likelihood3,'LineWidth',3)
hold on
plot(0.25*ones(length(v_theta),1),0:0.01:1,'k--')
plot(0.5*ones(length(v_theta),1),0:0.01:1,'k--')
plot(0.75*ones(length(v_theta),1),0:0.01:1,'k--')
ylim([0 1])
ylabel('Sum of probabilities')
xlabel('\theta')
hold off
v_integrals = [1/3,1/3,1/3]
subplot(2,2,4),bar(v_integrals)
xlabel('Disease case number')
ylabel('Sum of likelihood')
ylim([0 1])