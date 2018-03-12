clc
close all

%%gear ratio 
rw=0.03; %%radius [m]  ????
m=0.3; %%mass of car [kg]
G=m*9.81
mu=0.32; %% friction coefficient ????
Tm=0.0047; %%motor torque [Nm] - from characteristics

alfadeg=45; %% angle of track [degrees]
alfa=alfadeg*pi/180; %% angle of track [rad]


Fn=G*cos(alfa) %% normal forces at each wheel [N](mass is distributed uniformly))


Ffx=mu*Fn*sin(alfa);
Ffy=mu*Fn*cos(alfa);
Ff=sqrt(Ffx^2+Ffy^2); %%friction force per wheel [N]
Twmin=Ff*rw; %%minimum Wheel torque per wheel [Nm]

Fx=Ffx; %%sum of x direction forces [N]
Fy=Ffy-G; %%sum of y direction forces [N]
F=sqrt(Fx^2+Fy^2) %%minimal force for steady state [N] - we need to know what speed we want to achieve

a=F/m; %%acceleration [m/s^2]

Tw=F*rw; %% torque needed [Nm]

GR=Tw/Tm %%gear ratio wheel torque/motor torque [-]

rmotor=0.01; %% radius of the gear on motor shaft [m] ?????
Fm=Tm/rmotor; %%motor force [N]