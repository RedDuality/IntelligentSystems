
x = 0.1: 1/22: 1;

d = ((1 + 0.6 * sin (2 * pi * x / 0.7)) + 0.3 * sin (2 * pi * x)) / 2;


c1 = 0.19;
r1 = 0.15;

c2 = 0.92;
r2 = 0.17;

w1 = rand(1);
w2 = rand(1);
b = rand(1);


eta = 0.7;

for j = 1 : 1000000
    for i = 1 : length(x)
        v1 = exp(-(x(i)- c1 )^2/(2* r1 ^2));
        v2 = exp(-(x(i)- c2 )^2/(2* r2 ^2));

        y = w1 * v1 + w2 * v2 + b;

        e = d(i) - y;

        w1 = w1 + eta * e * v1;
        w2 = w2 + eta * e * v2;

        b = b + eta * e;
    end
end

Y = zeros(1,length(x));
for i = 1 : length(x)
    v1 = exp(-(x(i)- c1 )^2/(2* r1 ^2));
    v2 = exp(-(x(i)- c2 )^2/(2* r2 ^2));

    Y(i) = w1 * v1 + w2 * v2 + b;
end

plot(x, Y, "r", x, d,"b");
