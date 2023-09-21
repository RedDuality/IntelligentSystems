% Classification using perceptron

% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_P3 hsv_value_P4];
x2=[metric_A4 metric_A4 metric_A6 metric_P3 metric_P4];
% estimated features are stored in matrix P:
P=[x1;x2];

%Desired output vector
T=[1;1;1;-1;-1]; 


apple_colors=[hsv_value_A1, hsv_value_A2, hsv_value_A3, hsv_value_A4, hsv_value_A5, hsv_value_A6, hsv_value_A7, hsv_value_A8, hsv_value_A9];
apple_roundnesses=[metric_A1, metric_A2, metric_A3, metric_A4, metric_A5, metric_A6, metric_A7, metric_A8, metric_A9];

apple_color_mean = mean(apple_colors);
apple_color_variance = var(apple_colors);

apple_roundness_mean = mean(apple_roundnesses);
apple_roundness_variance = var(apple_roundnesses);


pear_colors = [hsv_value_P1, hsv_value_P2, hsv_value_P3, hsv_value_P4];
pear_roundnesses = [metric_P1, metric_P2, metric_P3, metric_P4];

pear_color_mean = mean(pear_colors);
pear_color_variance = var(pear_colors);

pear_roundness_mean = mean(pear_roundnesses);
pear_roundness_variance = var(pear_roundnesses);


P_apple = 9/13;
P_pear = 4/13;

tote = 0;

for i = 1:5

    P_color_apple = (1/sqrt(2 * pi * apple_color_variance)) * exp( (-(x1(i) - apple_color_mean)^2) / (2*apple_color_variance));
    P_roundness_apple = (1/sqrt(2 * pi * apple_roundness_variance)) * exp( (-(x2(i) - apple_roundness_mean)^2) / (2*apple_roundness_variance));

    P_color_pear=(1/sqrt(2 * pi * pear_color_variance)) * exp( (-(x1(i) - pear_color_mean)^2) / (2*pear_color_variance));
    P_roundess_pear = (1/sqrt(2 * pi * pear_roundness_variance)) * exp( (-(x2(i) - pear_roundness_mean)^2) / (2 * pear_roundness_variance));
    
    post_num_apple = P_apple * P_color_apple * P_roundness_apple;
    post_num_pear = P_pear * P_color_pear * P_roundess_pear;
 
    

    if (post_num_apple > post_num_pear) 
        disp("apple!")
	    y = 1;
    else
        disp("pear!")
	    y = -1;
    end

    e = T(i) - y;

    tote = tote + abs(e);
    

end


if tote == 0
    disp("it works!")
else
    disp("it's broken!")
end
