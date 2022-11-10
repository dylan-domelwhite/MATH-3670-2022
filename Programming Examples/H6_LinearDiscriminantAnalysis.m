% Matlab example: classification using linear discriminant analysis
% Homework 6 Problem 4
rng('default') %initialize seed for random number generator
rng(1)

%class conditional means
mu1=[0;0];
mu2=[0;10];
mu3=[0;-10];


Sigma = [8 0; 0 1]; % covariance
N=1000; %number of training points
y = zeros(N,1);
x = zeros(2,N);
b= rand(N,1);

for j=1:N
    if (0 <= b(j))&(b(j) <.3)
        y(j) = 1;
        x(:,j) = mvnrnd(mu1,Sigma);
    elseif (.3<= b(j))&(b(j) < .7)
        y(j) = 2;
        x(:,j) = mvnrnd(mu2,Sigma);
    elseif (.7<= b(j))&(b(j) <=1)
        y(j) = 3;
        x(:,j) = mvnrnd(mu3,Sigma);
    end
end

N1=sum(y==1);
N2=sum(y==2);
N3=sum(y==3);

%estimates for Prob[Y=C_k]
pi1 = (N1/N);
pi2 = (N2/N);
pi3 = (N3/N);
I1=find(y==1);
I2=find(y==2);
I3=find(y==3);

%estimates of class-conditional means
mu1s=(1/N1)*[sum(x(1,I1)); sum(x(2,I1))];
mu2s=(1/N2)*[sum(x(1,I2)); sum(x(2,I2))];
mu3s=(1/N3)*[sum(x(1,I3)); sum(x(2,I3))];
S_hat1=(x(:,I1)-mu1s)*(x(:,I1)-mu1s)';
S_hat2=(x(:,I2)-mu2s)*(x(:,I2)-mu2s)';
S_hat3=(x(:,I3)-mu3s)*(x(:,I3)-mu3s)';

%pooled covariances estimate
S_hat= (1/(N-3))*(S_hat1+S_hat2+S_hat3);
M=10000;
xt = 40*(rand(2,M)-.5);

%linear discriminant functions
SI=(S_hat^(-1));
delt1 = xt'*(SI)*mu1s - .5*mu1s'*SI*mu1s + log(pi1);
delt2 = xt'*(SI)*mu2s - .5*mu2s'*SI*mu2s + log(pi2);
delt3 = xt'*(SI)*mu3s - .5*mu3s'*SI*mu3s + log(pi3);
D=[delt1'; delt2'; delt3'];
[B C]= max(D);
CI1=find(C==1);
CI2=find(C==2);
CI3=find(C==3);

plot(xt(1,CI1),xt(2,CI1),'sg', xt(1,CI2),xt(2,CI2),'+b', ...
    xt(1,CI3),xt(2,CI3),'or',x(1,:),x(2,:),'*k')

axis equal
grid on
