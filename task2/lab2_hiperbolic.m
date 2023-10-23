

x = 0.1:1/220:1;

d = ((1 + 0.6 * sin( 2 * pi * x/0.7))  + (0.3 * sin( 2 * pi * x ))) /2;


%plot(x,d);




%I layer
w11_1 = rand(1);
b1_1 = rand(1);

w12_1 = rand(1);
b2_1 = rand(1);

w13_1 = rand(1);
b3_1 = rand(1);

w14_1 = rand(1);
b4_1 = rand(1);


%II layer

w11_2 = rand(1);
w21_2 = rand(1);
w31_2 = rand(1);
w41_2 = rand(1);

b1_2 = rand(1);


eta = 0.01;

for index=1:100000

    %Training
    for i =1:length(x)

        v1_1 = x(i) * w11_1 + b1_1;
        v2_1 = x(i) * w12_1 + b2_1;
        v3_1 = x(i) * w13_1 + b3_1;
        v4_1 = x(i) * w14_1 + b4_1;

        %activation

        y1_1=tanh(v1_1);
        y2_1=tanh(v2_1);
        y3_1=tanh(v3_1);
        y4_1=tanh(v4_1);

        %last layer

        v1_2 = y1_1 * w11_2 + y2_1 * w21_2 + y3_1 * w31_2 + y4_1 * w41_2 + b1_2;
        y1_2 = v1_2;


        %error
        e = d(i) - y1_2;

        %update weights

        delta1_2 = e;

        w11_2 = w11_2 + eta * delta1_2 * y1_1;
        w21_2 = w21_2 + eta * delta1_2 * y2_1;
        w31_2 = w31_2 + eta * delta1_2 * y3_1;
        w41_2 = w41_2 + eta * delta1_2 * y4_1;

        b1_2 = b1_2 + eta * delta1_2;


        delta1_1 = (1-(tanh(y1_1)^2)) * delta1_2 * w11_2;
        delta2_1 = (1-(tanh(y2_1)^2)) * delta1_2 * w21_2;
        delta3_1 = (1-(tanh(y3_1)^2)) * delta1_2 * w31_2;
        delta4_1 = (1-(tanh(y4_1)^2)) * delta1_2 * w41_2;

        w11_1 = w11_1 + eta * delta1_1 * x(i);
        w12_1 = w12_1 + eta * delta2_1 * x(i);
        w13_1 = w13_1 + eta * delta3_1 * x(i);
        w14_1 = w14_1 + eta * delta4_1 * x(i);

        b1_1 = b1_1 + eta * delta1_1;
        b2_1 = b2_1 + eta * delta2_1;
        b3_1 = b3_1 + eta * delta3_1;
        b4_1 = b4_1 + eta * delta4_1;

    end


end


%

%%testing

X = 0.1:1/220:1;
Y = zeros(1,length(X));

for i=1:length(X)
    v1_1 = X(i) * w11_1 + b1_1;
    v2_1 = X(i) * w12_1 + b2_1;
    v3_1 = X(i) * w13_1 + b3_1;
    v4_1 = X(i) * w14_1 + b4_1;

    y1_1 = tanh(v1_1);
    y2_1 = tanh(v2_1);
    y3_1 = tanh(v3_1);
    y4_1 = tanh(v4_1);

    v1_2 = y1_1 * w11_2 + y2_1 * w21_2 + y3_1 * w31_2 + y4_1 * w41_2 + b1_2;
    Y(i) = v1_2;
end


plot(X, Y, "r", x, d,"b");
disp("end");


