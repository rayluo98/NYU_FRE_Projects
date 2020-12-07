K = input('Strike Price:');
r = input('Interest Rate: ');
sigma = input('Annual Volatility: ');
T = input('Days Observed: ');
R = input('R: ');
delta_t = input('t_Steps: ');
delta_y = input('y_Steps: ');
%Note that delta_t*N = T
N = T/delta_t;
%Note that delta_y*M = R
M = R/delta_y;

a = (-0.5*delta_t*(sigma^2)/(delta_y^2)+delta_t*(r-0.5*(sigma^2))/(2*delta_y));
b = (1+delta_t*(r+(sigma^2)/(delta_y^2)));
c = delta_t*(-1*(r-0.5*(sigma^2))/(2*delta_y) - 0.5*(sigma^2)/(delta_y^2));
A_h = diag(a*ones(1,2*M),-1) + diag(b*ones(1,2*M+1)) + diag(c*ones(1,2*M),1);
a = a*ones(1,2*M+1);
b = b*ones(1,2*M+1);
c = c*ones(1,2*M+1);
u_n = max(exp([-M:1:M]*delta_y) - K, 0);

for n = 0:N-1
   B_n = u_n;
   B_n(1) =0;
   B_n(2*M+1) = B_n(2*M) + delta_t*(0.5*(sigma^2)/(delta_y^2)+(r-0.5*(sigma^2))/(2*delta_y))*(exp(M*delta_y)-exp(-r*(n+1)*delta_t*K));
   u_next = TDMAsolver(a,b,c,B_n);
end

hold on;
x = [-R:delta_y:R];
plot(exp(x),u_next,'DisplayName','*');
plot(exp(x), blsprice(exp(x),K,r,T,sigma),'DisplayName','--');
legend('Finite Differences Option Value','Blsprice Option Value')
%disp(mean(u_next)*exp(-r*T));
hold off;

%hold on;
%error_1 = abs(u_next-blsprice(exp(x),K,r,T,sigma));
%disp(mean(error_1));
%plot(exp(x), error_1);


function x=TDMAsolver(a,b,c,d)
    % a, b, c are column vectors for compressed tridiagonal matrix, d is the
    % right vector
     %n is the number of rows
    n = length(b);
    % Modify the first row cofficients
    c(1)=c(1)/ b(1); % Division by zero risk.
    d(1)=d(1)/b(1);  % division by zero would imply a singular matrix
    for i=2:n-1
        temp=b(i)-a(i)*c(i-1);
        c(i)=c(i)/temp;
        d(i)=(d(i)-a(i)*d(i-1))/temp;
    end
    d(n)=(d(n)-a(n)*d(n-1))/(b(n)-a(n)*c(n-1));
    %back to substitute 
    x(n)=d(n);
    for i =n-1:-1:1
        x(i)=d(i)-c(i)*x(i+1);
    end
end