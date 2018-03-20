%rough outline of the overall program to simulate the movement of your car.
%this program will simulate the movement for one set of variables only and
%will have to be reworked into a function (with inputs and outputs) in
%order to investigate the effect of a parameter on the movement of the car
 
addpath ./DCmotor
addpath ./SolarPanel
addpath ./Track
 
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

car.Mssv = 1;             % [kg] mass of the SSV
car.gear_ratio = 0.2;        % [] gear ratio: input/output   (motor speed /wheel axel speed)
car.frc = 0.3;              % Friction coef
car.pulley_radius = 0.025;

panel = SolarPanel(1.271,0.36);

motor = DCmotor();

track = Track(3, 2.2, 0.0);


%set initial position and speed of the car on the track
x0 = 0;   %[m]
dx0 = 0;  %[m/s]

 
%call the ode45 function in order to solve the differential equation problem
endTime = 5; %[sec] overall time you want the simulation to run for 
%e.g. simulate the movement of the car from 0 to 10 sec
[timeOut,Pout]=ode45(@(t,P) difEqCar(t,P,car,panel,motor,track),[0 endTime],[x0 dx0]);
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
subplot(2,1,1)
plot(timeOut,Pout(:,1))  %creates of plot of the position of the car as a function of time, (all rows first column is selected for Xout)
grid on;
title('position of the car on the track over time')
xlabel('time [sec]')
ylabel('position [m]')

subplot(2,1,2)
plot(Pout(:,1),Pout(:,2)) 
grid on;
axis([0 7 0 inf])
title('Velocity of the car on the track ')
xlabel('position [m]')
ylabel('velocity [m/s]')
 
 
%some more processing to return the time the car needed to reach the end of
%the track.  To be done using interpolation of the Xout and timeOut results
 
%define and create multiple files that generate different
%output values/graphs


