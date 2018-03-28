
clc
close all
addpath ./Track

track = Track(3, 2.2, 0.4);
%%gear ratio 
Rp=0.025; %%pulley radius [m] 
m=0.3; %%mass of car [kg]
G=m*9.81;
mu=0.3; %% friction coefficient 

Tms=0.021;
Icur=0.65;
Tm=(Icur-0.021)*Tms/(1.8-0.021); %%motor load torque [Nm] - from characteristics
x=0:0.1:7;
slope = track.slope(x);


Fn=G.*cos(slope); %% normal forces at each wheel [N](mass is distributed uniformly))


Ffx=mu*Fn.*sin(slope);
Ffy=mu*Fn.*cos(slope);
Ff=sqrt(Ffx.^2+Ffy.^2); %%friction force per wheel [N]

Fx=Ffx; %%sum of x direction forces [N]
Fy=Ffy-G; %%sum of y direction forces [N]
F=sqrt(Fx.^2+Fy.^2); %%minimal force for steady state [N] - we need to know what speed we want to achieve


Tp=F.*Rp; %% torque needed [Nm]

GR=Tm./Tp %%gear ratio wheel torque/motor torque [-]

rmotor=0.01; %% radius of the gear on motor shaft [m] ?????
Fm=Tm/rmotor; %%motor force [N]