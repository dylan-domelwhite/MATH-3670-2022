N = 1000;
x1 = rand(N,1);
x2 = rand(N,1);
z = 2*(rand(N,1) - .5);
y = 2*x1.^2 +2*x2.^2 + z;

D = [x1 x2];
beta = ((D'*D)^(-1))*D'*y