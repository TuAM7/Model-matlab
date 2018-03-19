


addpath ./SolarPanel
addpath ./Track
addpath ./DCmotor

sp = SolarPanel(1.271, 0.36)

trackLength = 7;
bumpStart = 3;
bumpLength = 2.2;
bumpHeight = 0.4;
track = Track(bumpStart,bumpLength, bumpHeight)

xspan = 0:0.1:trackLength;
y0 = [0 0];
[x,y] = ode45(@(x,y) car(x,y,track), xspan, y0)


plot(x,y(:,2),'-')
title('Distance travelled and velocity over time')
xlabel('Distance')
legend('velocity')


function dX = car(x, X, track)
    P = 1; % motor force
    F = P - 0.3*9.81*sin(track.slope(x));
    a = F/0.3;
    dX(1,1) = X(2,1);  % speed is the derivative of position
    dX(2,1) = a;       % acceleration is the derivative of speed
end