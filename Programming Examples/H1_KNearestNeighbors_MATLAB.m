% Code by Dr. Alex Powell

N = 1000;
sigma = 1;

x_train = 2*rand(N, 1);
eps = sigma*randn(N, 1);
y_train = 2*x_train + sin(2*pi*x_train) + eps;

M = 100;
x_test = linspace(0,2,M)';

y_reg = 2*x_test + sin(2*pi*x_test);

K=25;
IDX = knnsearch(x_train, x_test, 'K', K);
for m=1:M
   y_predicted(m) = (1/K)*sum(y_train(IDX(m, :)));
end

plot(x_train, y_train, '.b', x_test, y_predicted, '-xr', x_test, y_reg, '-k')
