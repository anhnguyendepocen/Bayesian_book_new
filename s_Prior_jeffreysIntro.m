clear; close all; clc;

v_theta = 0:0.01:1;
v_pdfTheta = ones(size(v_theta));

v_pdfThetaSquared = zeros(size(v_theta));
for i = 1:length(v_pdfThetaSquared)
    v_pdfThetaSquared(i) = (1/(2*sqrt(v_theta(i))));
end
subplot(3,1,1),
plot(v_theta,v_pdfTheta,'LineWidth',3)
subplot(3,1,2),
plot(v_theta,v_pdfThetaSquared,'LineWidth',3)