% Matlab example: classification by regression with indicator matrix
% Homework 6 Problem 3
rng('default') %initialize seed for random number generator
rng(1)

%class conditional means
mu1=[-5;5];
mu2=[5;5];
mu3=[0;-10];


Sigma = [8 0; 0 1]; % covariance
N=1000; % number of data points
y = zeros(N,3);
x = zeros(2,N);
b= rand(N,1);

for j=1:N
    if (0 <= b(j))&(b(j) <.3)
        Z(j,:) = [1 0 0];
        x(:,j) = mvnrnd(mu1,Sigma);
    elseif (.3<= b(j))&(b(j) < .7)
        Z(j,:) = [0 1 0];
        x(:,j) = mvnrnd(mu2,Sigma);
    elseif (.7<= b(j))&(b(j) <=1)
        Z(j,:) = [0 0 1];
        x(:,j) = mvnrnd(mu3,Sigma);
    end
end
D=x';
B=((D'*D)^(-1))*(D')*Z;
M=10000;
xt=40*(rand(2,M)-.5);
fhat = xt'*B;
[A C]=max(fhat');
CI1=find(C==1);
CI2=find(C==2);
CI3=find(C==3);
plot(xt(1,CI1),xt(2,CI1),'sg', xt(1,CI2),xt(2,CI2),'+b', ...
    xt(1,CI3),xt(2,CI3),'or',x(1,:),x(2,:),'*k')
axis equal
grid on