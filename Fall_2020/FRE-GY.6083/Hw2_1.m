N = 10000;
q = 0.5;
r = rand(1,N);
for i = 1:N
    if r(i) > q
        r(i) = 1;
    else
        r(i) = -1;
    end
end
P = cumsum(r);
x = 1:N;
w_x = sqrt(x);
W_n = P./w_x;
figure(1) ;
%hold on;
plot(x, P, '*');
xlabel('Step');
ylabel('Position');

figure(2)
plot(x, W_n, '-');
xlabel('Step');
ylabel('Position');
%hold off;
