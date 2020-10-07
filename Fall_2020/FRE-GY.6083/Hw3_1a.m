P = [1/6, 5/6; 1/3, 2/3];
Pi = [500000 200000];
total = sum(Pi);
Pi = Pi/total;
delta = 1;
count = 0;
while delta > 0.0000001
    temp = Pi*P;
    arr = [0, 0];
    for i = 1:2
        arr(i) = temp(i) - Pi(i);
    end
    delta = max(arr);
    Pi = temp;
    count = count + 1;
    if count > 1000
        break;
    end
end
disp(Pi*total);