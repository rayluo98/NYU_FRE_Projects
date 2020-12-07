S_0 = input('S(0)');
K = input('Strike Price');
r = input('Interest Rate');
sigma = input('Volatility');
T = input('Maturity');
n = input('Sample Paths');
noise = randn(n,T+1);
S = zeros(n,T+1);
S(:,1) = S_0;
for i = 2:T+1
    S(:,i) = S(:,i-1).*exp((r-sigma^2/2)+noise(:,i).*sigma);
end 
%We plot the pattern of the prices to verify
%plot(S);

%%Keep track of Payoff in vector
C = exp(-r*T)*max(S(:,T+1)-K,0);

%%The expected payoff through monte-carlo method
disp(mean(C));