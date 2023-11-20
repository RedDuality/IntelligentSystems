
start = 0.0;
x = start : 1/22: 1;

d = ((1 + 0.6 * sin (2 * pi * x / 0.7)) + 0.3 * sin (2 * pi * x)) / 2;


maxs = findMaxs(d);
centers = findCenters(maxs,d,start);

%c1 = 0.19;
xc1 = centers(1);
%r1 = 0.15;
range = 1:10;
things1 = findRadius(d(range),xc1, x(range));
yc1 = things1(1);
r1 = things1(2);

%c2 = 0.92;
xc2 = centers(2);

%r2=0.17;
range = 14:20;
things2 = findRadius(d(range),xc2, x(range));
yc2 = things2(1);

r2 = things2(2);

w1 = rand(1);
w2 = rand(1);
b = rand(1);


eta = 0.7;

for j = 1 : 1000000
    for i = 1 : length(x)
        v1 = exp(-(x(i)- xc1 )^2/(2* r1 ^2));
        v2 = exp(-(x(i)- xc2 )^2/(2* r2 ^2));

        y = w1 * v1 + w2 * v2 + b;

        e = d(i) - y;

        w1 = w1 + eta * e * v1;
        w2 = w2 + eta * e * v2;

        b = b + eta * e;
    end
end



X = start : 1/200: 1;



Y = zeros(1,length(X));
for i = 1 : length(X)
    v1 = exp(-(X(i)- xc1 )^2/(2* r1 ^2));
    v2 = exp(-(X(i)- xc2 )^2/(2* r2 ^2));

    Y(i) = w1 * v1 + w2 * v2 + b;
end


hold on
plot(xc1,yc1, 'r*');
plot(xc2,yc2, 'r*');
plot(X, Y, "r", x, d,"b");
hold off



function maximums = findMaxs(f)
m1 = f(1);
m2 = f(length(f));

for i = 2 : length(f)-1
    if(f(i)>f(i-1) && f(i)>f(i+1)) %maximum
        if(f(i)>=m1)
            m2 = m1;
            m1 = f(i);
        else
            m2 = f(i);
        end
    end

end

maximums(1) = m1;
maximums(2) = m2;

end

function centers = findCenters(maxs,f,start)

centers(1) = (find(f == maxs(1))-1) * 1/22 + start;
centers(2) = (find(f == maxs(2))-1) * 1/22 + start;
end


function radius = findRadius(f,center, x)
l = length(f);
minimumAverage = 1;

for ycenter = 0.1: 1/40: 1
   
    currentCenter = [center, ycenter];
    total = 0;
    for j = 1 : l
        currentFunctionValue = [x(j), f(j)];
        d = norm(currentCenter-currentFunctionValue);
        total = d + total;
    end
    average = total/l;
    if(average < minimumAverage)
        minimumAverage = average;
        besty = ycenter;
    end
    
end
radius = [besty,minimumAverage];
end

