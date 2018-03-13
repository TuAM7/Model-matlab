%rough outline of the overall program to simulate the movement of your car.
%this program will simulate the movement for one set of variables only and
%will have to be reworked into a function (with inputs and outputs) in
%order to investigate the effect of a parameter on the movement of the car
 
 
 
%starting with a clean slate.  
%!to be removed if you want to rework this into an input-output function!
%once you have created an input/output function out of this file you can
%use it to do an optimization of e.g your gear ratio
clear all
close all
clc
 
 
 
%definition of variables.
%you can add additional variables if needed
%!values have to be changed but variable names have to remain identical
 
 
%car parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To Do add correct values              %
%To Do add additional parameters       %
%To Do add correct units and comments  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

car.Mssv = 0.3;            %[kg] mass of the SSV
car.gear_ratio = 1;      %[] gear ratio: input/output   (motor speed /wheel axel speed)
%add aditional car paramters
 
% parameter of solar panel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To Do add correct values              %
%To Do add additional parameters       %
%To Do add correct units and comments  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
panel = SolarPanel(1.271);

motor = DCmotor();

track = Track(3,2.2, 0.4);
 
%%%%%%%%%%%%%%%%%%%%
       
%set initial position and speed of the car on the track
x0 = 0;   %[m]
dx0 = 0;  %[m/s]
 
 
 
%call the ode45 function in order to solve the differential equation problem
endTime = 20; %[sec] overall time you want the simulation to run for 
%e.g. simulate the movement of the car from 0 to 10 sec
[timeOut,Pout]=ode45(@(t,P)difEqCar(t,P,car,panel,motor,track),endTime,[x0 dx0]);
%using ode45 to numerically solve the differential equations from time 0 to
%end time 
%initial conditions set by x0 and dx0;
%the differential Equations to be solved have to be place in a separate
%function (which in this case is called difEqCar)
%timeOut will hold all the time points for which an output Xout is provided
%Pout holds the position and speed of the car for all times in timeOut
 
 
 
%post processing of the results
%e.g.
f1=figure;  %create a new figure which is referred to as f1
plot(timeOut,Pout(:,1))  %creates of plot of the position of the car as a function of time, (all rows first column is selected for Xout)
grid on;
title('position of the car on the track over time')
xlabel('time [sec]')
ylabel('position [m]')
 
 
%some more processing to return the time the car needed to reach the end of
%the track.  To be done using interpolation of the Xout and timeOut results
 
%define and create multiple files that generate different
%output values/graphs

 
 
 
 













% addpath ./SolarPanel
% addpath ./Track
% addpath ./DCmotor
% 
% sp = SolarPanel(1.271)
% 
% trackLength = 7;
% bumpStart = 3;
% bumpLength = 2.2;
% bumpHeight = 0.4;
% track = Track(bumpStart,bumpLength, bumpHeight)
% 
% xspan = 0:0.1:trackLength;
% y0 = [0 0];
% [x,y] = ode45(@(x,y) car(x,y,track), xspan, y0)
% 
% 
% plot(x,y(:,2),'-')
% title('Distance travelled and velocity over time')
% xlabel('Distance')
% legend('velocity')
% 
% 
% function dX = car(x, X, track)
%     P = 1; % motor force
%     F = P - 0.3*9.81*sin(track.slope(x));
%     a = F/0.3;
%     dX(1,1) = X(2,1);  % speed is the derivative of position
%     dX(2,1) = a;       % acceleration is the derivative of speed
% end