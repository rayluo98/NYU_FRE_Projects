P = [1/2, 1/4, 1/4; 1/2, 0, 1/2; 1/4, 0, 3/4];
Pi = [1/3, 1/3, 1/3];
delta = 1;
count = 0;
while delta > 0.0000001
    temp = Pi*P;
    arr = [0, 0, 0];
    for i = 1:3
        arr(i) = temp(i) - Pi(i);
    end
    delta = max(arr);
    Pi = temp;
    count = count + 1;
    if count > 1000
        break;
    end
end
disp(Pi);

%%Hw3_1
%%   0.3636    0.0909    0.5455