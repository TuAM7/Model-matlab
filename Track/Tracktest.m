%% Slope polynomial
t = 0:0.01:0.8;
y = [-25/16 15/8 0 0];

f = figure('Name','Track height and slope','NumberTitle','off');
subplot(2,3,[1,4])
plot(t,polyval(y,t));
legend('y = (-25/16)t^3+(15/8)t^2');
title('Slope polynomial');

%% Track function
trackLength = 7;

track = Track;
track.bumpLength = 2.2;
track.bumpStart = rand(1)*(trackLength-track.bumpLength);
track.bumpHeight = 0.4;


subplot(2,3,[2,3]) 
fplot(@(x) track.height(x),[0,trackLength]);
ylim([0 0.5]);
pbaspect([7 0.5 1]) %sets aspect ratio of image to same scale on both axes
xlabel('position (m)');
ylabel('height (m)');
title('Track height');

subplot(2,3,[5,6]) 
fplot(@(x) track.slope(x),[0,trackLength]);
ylim([0 inf]);
xlabel('position (m)');
ylabel('slope (degrees)');
title('Track slope');