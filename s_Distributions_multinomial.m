clear; clc; close all;

p = [1/2 1/3 1/6];
n = 5;

count1 = 1:n;
count2 = 1:n;
[x1,x2] = meshgrid(count1,count2);
x3 = n-(x1+x2);
y = mnpdf([x1(:),x2(:),x3(:)],repmat(p,(n)^2,1));

figure;
y = reshape(y,n,n);
bar3(y);
set(gca,'XTickLabel',1:n);
set(gca,'YTickLabel',1:n);
xlabel('Z_A');
ylabel('Z_B');
zlabel('Probability Mass');

print('Distributions_multinomial','-dpdf')