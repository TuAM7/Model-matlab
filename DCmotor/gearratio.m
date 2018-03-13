clc
close all
%% gear ratio data
rw=0.025; %%radius of wheel [m]  ????
m=0.3; %%mass of car [kg]
G=m*9.81;
mu=0.54; %% friction coefficient ????
Tm=0.0047; %%motor torque [Nm] - from torque
a=20; %% acceleration [m/s^2]

%% linking the track slope degrees 
track=Track(); 
trackLength = 7;
track.bumpLength = 2.2;
track.bumpStart = rand(1)*(trackLength-track.bumpLength);
track.bumpHeight = 0.4;
%% Determining the degrees of the slope at different places of the track
alfa=[];
for x=0:0.1:7
    alfadeg=track.slope(x); %% angle of track [degrees]
    alfa1=alfadeg.*pi/180; %% angle of track [rad]
    alfa=[alfa,alfa1];
end
alfad=alfa.*180/pi;
salfa=numel(alfa);
%% calculating the forces of the free body diagram
Fn=G*cos(alfa); %% normal force [N]

Ffx=mu.*Fn.*sin(alfa);
Ffy=mu.*Fn.*cos(alfa);
Ff=sqrt(Ffx.^2+Ffy.^2);%%friction force [N]

Fx=Ffx; %%sum of x direction forces [N]
Fy=Ffy+G; %%sum of y direction forces [N]
Fmin=sqrt(Fx.^2+Fy.^2); %%minimal force for steady state [N] - we need to know what speed we want to achieve
Twmin=Fmin*rw; %%minimum Wheel torque [Nm]
%% I don't know ?????
F=m*a;
Tw=m*a*rw; %% Desired wheel torque at certain acceleration [Nm]
F=m*a; %%
Twmin=Fmin*rw; %% torque needed [Nm]
%GRmin=Twmin./T; %%min gear ratio wheel torque/motor torque [-]
%GR=Tw./T;