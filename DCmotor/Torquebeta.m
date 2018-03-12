clear all
clc
close all

%%Data sheet
Tms=23.2; %%Stall torque [nNm]
Ra=3.32; %%Terminal Resistance [Ohm]
Kt=0.0085; %%Torque constant [nNm/A]
Kv=1120/60*2*pi; %%speed constant [rad/Vs]
w_nl=9630*2*pi/60; %%no load speed [rad/s] ~1000 rad/s
Ke=Kt; %%Inverse of the speed constant [Vs/rad]
w=[0:250:w_nl]; %% rot speed [rad/s]

Ua=0:10;

%%Calculating counter Emf for different w
E=[];
for w=w
    E1=Ke*w;
    E=[E,E1];
end 
sE=numel(E);

%%plotting DC motor characteristics for different w
for i=1:1:sE
   Ia=(Ua-E(1,i))/Ra;
   Ia=min(1,max(0,Ia));
   %plot(Ua,Ia)
   grid;
   xlabel('U [V]');
   ylabel('I [A]');
   title('DC motor characteristic')
   hold on
end
hold off

% Just trying to build up the solution, and see if it works, before making
% it in a loop
z=@(Ua) (Ua-E(3))/Ra; %% DC motor
sp=@SolarPaneleq; %% Solar panel

y=@(Ua) sp(Ua)-z(Ua); %% DCmotor-Solarpanel characteristic
plot(Ua,y(Ua))
grid;
ylim([0 0.9]);
x0=3;
x=fzero(y,x0); %%x value at intersection

z(x); %%I value at intersection

plot(Ua,z(Ua))
xlim([0 10]);
ylim([0 1]);
hold on
plot(Ua,sp(Ua))
grid;
hold off

Pl=z(x)*x  %% Electric power into the motor at E(3) emf value
Pm=z(x)*E(3) %%Mechanical power at E(3) emf value
T=Pm/750 %%Torque at certain speed and Emf [Nm]
