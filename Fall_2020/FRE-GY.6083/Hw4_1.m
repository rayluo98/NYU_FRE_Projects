lambda = 2;
T = 5;
N = 100;
hold on 
for i = 1:N
    t = 0;
    x = [0];
    len = 0;
    while t < T
        r = exprnd(1/lambda);
        t = t + r; 
        x = [x t];
        len = len + 1;
    end
    y = 0:len;
    x(1) = 0;
    plot(x,y);
    xlim([0 T]);
end
hold off