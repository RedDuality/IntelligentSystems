

x = 0.1:1/100:1;
y = 0.1:1/100:1;

[X, Y] = meshgrid(x, y);
d = ((1 + 0.6 * sin( 2 * pi * X/0.7))  + (0.3 * sin( 2 * pi * X ))) /2 + ((1 + 0.2 * sin( 2 * pi * Y/0.4))  + (0.5 * sin( 2 * pi * Y ))) /3;

%I layer

W1 = rand(2,6,1);
B1 = rand(6,1);

w11_1 = rand(1);
w21_1 = rand(1);
b1_1 = rand(1);

w12_1 = rand(1);
w22_1 = rand(1);
b2_1 = rand(1);

w13_1 = rand(1);
w23_1 = rand(1);
b3_1 = rand(1);

w14_1 = rand(1);
w24_1 = rand(1);
b4_1 = rand(1);

w15_1 = rand(1);
w25_1 = rand(1);
b5_1 = rand(1);

w16_1 = rand(1);
w26_1 = rand(1);
b6_1 = rand(1);

%II layer

W2 = rand(6,1);

w11_2 = rand(1);
w21_2 = rand(1);
w31_2 = rand(1);
w41_2 = rand(1);
w51_2 = rand(1);
w61_2 = rand(1);

b1_2 = rand(1);


eta = 0.001;

for index=1:100000

    %Training
    for i = 1:length(x)
        for j = 1:length(y)

            v1_1 = x(i) * w11_1 + y(j) * w21_1 + b1_1;
            v2_1 = x(i) * w12_1 + y(j) * w22_1 + b2_1;
            v3_1 = x(i) * w13_1 + y(j) * w23_1 + b3_1;
            v4_1 = x(i) * w14_1 + y(j) * w24_1 + b4_1;
            v5_1 = x(i) * w15_1 + y(j) * w25_1 + b5_1;
            v6_1 = x(i) * w16_1 + y(j) * w26_1 + b6_1;

            %activation

            y1_1 = sigmoidal(v1_1);
            y2_1 = sigmoidal(v2_1);
            y3_1 = sigmoidal(v3_1);
            y4_1 = sigmoidal(v4_1);
            y5_1 = sigmoidal(v5_1);
            y6_1 = sigmoidal(v6_1);

            %last layer

            v1_2 = y1_1 * w11_2 +...
                    y2_1 * w21_2 + ...
                    y3_1 * w31_2 + ...
                    y4_1 * w41_2 + ...
                    y5_1 * w51_2 + ...
                    y6_1 * w61_2 + ...
                    b1_2;


            y1_2 = v1_2;


            %error
            e = d(i,j) - y1_2;

            %update weights

            delta1_2 = e;

            w11_2 = w11_2 + eta * delta1_2 * y1_1;
            w21_2 = w21_2 + eta * delta1_2 * y2_1;
            w31_2 = w31_2 + eta * delta1_2 * y3_1;
            w41_2 = w41_2 + eta * delta1_2 * y4_1;
            w51_2 = w51_2 + eta * delta1_2 * y5_1;
            w61_2 = w61_2 + eta * delta1_2 * y6_1;

            b1_2 = b1_2 + eta * delta1_2;


            delta1_1 = sigmoidal(v1_1) * (1- sigmoidal(v1_1))  * delta1_2 * w11_2 ;
            delta2_1 = sigmoidal(v2_1) * (1- sigmoidal(v2_1))  * delta1_2 * w21_2 ;
            delta3_1 = sigmoidal(v3_1) * (1- sigmoidal(v3_1))  * delta1_2 * w31_2 ;
            delta4_1 = sigmoidal(v4_1) * (1- sigmoidal(v4_1))  * delta1_2 * w41_2 ;
            delta5_1 = sigmoidal(v5_1) * (1- sigmoidal(v5_1))  * delta1_2 * w51_2 ;
            delta6_1 = sigmoidal(v6_1) * (1- sigmoidal(v6_1))  * delta1_2 * w61_2 ;


            w11_1 = w11_1 + eta * delta1_1 * x(i);
            w12_1 = w12_1 + eta * delta2_1 * x(i);
            w13_1 = w13_1 + eta * delta3_1 * x(i);
            w14_1 = w14_1 + eta * delta4_1 * x(i);
            w15_1 = w15_1 + eta * delta5_1 * x(i);
            w16_1 = w16_1 + eta * delta6_1 * x(i);


            w21_1 = w21_1 + eta * delta1_1 * y(j);
            w22_1 = w22_1 + eta * delta2_1 * y(j);
            w23_1 = w23_1 + eta * delta3_1 * y(j);
            w24_1 = w24_1 + eta * delta4_1 * y(j);
            w25_1 = w25_1 + eta * delta5_1 * y(j);
            w26_1 = w26_1 + eta * delta6_1 * y(j);


            b1_1 = b1_1 + eta * delta1_1;
            b2_1 = b2_1 + eta * delta2_1;
            b3_1 = b3_1 + eta * delta3_1;
            b4_1 = b4_1 + eta * delta4_1;
            b5_1 = b5_1 + eta * delta5_1;
            b6_1 = b6_1 + eta * delta6_1;
        end
    end
    if (mod(index, 1000) == 0 )
        disp(index);
    end
end


%

%%testing


r = 0.1:1/100:1;
s = 0.1:1/100:1;

[R, S] = meshgrid(r, s);
D = zeros(length(r), length(s));

for i=1:length(r)
    for j = 1:length(s)
        v1_1 = r(i) * w11_1 + s(j) * w21_1 + b1_1;
        v2_1 = r(i) * w12_1 + s(j) * w22_1 + b2_1;
        v3_1 = r(i) * w13_1 + s(j) * w23_1 + b3_1;
        v4_1 = r(i) * w14_1 + s(j) * w24_1 + b4_1;
        v5_1 = r(i) * w15_1 + s(j) * w25_1 + b5_1;
        v6_1 = r(i) * w16_1 + s(j) * w26_1 + b6_1;

        y1_1 = sigmoidal(v1_1);
        y2_1 = sigmoidal(v2_1);
        y3_1 = sigmoidal(v3_1);
        y4_1 = sigmoidal(v4_1);
        y5_1 = sigmoidal(v5_1);
        y6_1 = sigmoidal(v6_1);

        v1_2 = y1_1 * w11_2 + ...
                y2_1 * w21_2 + ...
                y3_1 * w31_2 + ...
                y4_1 * w41_2 + ...
                y5_1 * w51_2 + ...
                y6_1 * w61_2 + ...
                b1_2;

        D(i,j) = v1_2;
    end
end



figure(2)
surf(x,y,d,'FaceColor', 'none')
hold on
surf(r,s,D)
hold off
grid on

disp("end");



function sig  = sigmoidal(input)
sig = 1/(1+exp(-input));
end


