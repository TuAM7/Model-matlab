clc
close all

%%Data sheet
Tms=23.2; %%Stall torque [nNm]
Ra=3.32; %%Terminal Resistance [Ohm]
Kt=0.0085; %%Torque constant [nNm/A]
Kv=1120/60*2*pi; %%speed constant [rad/Vs]
w_nl=9630*2*pi/60; %%no load speed [rad/s] ~1000 rad/s
Ke=Kt; %%Inverse of the speed constant [Vs/rad]
w=0:250:w_nl; %% rot speed [rad/s]

Ua=0:10;

%%Calculating counter Emf for different w
E=[];
for w=w
    E1=Ke*w;
    E=[E,E1];
end 
sE=numel(E);

%%plotting DC motor characteristics for different n
for i=1:1:sE
   Ia=(Ua-E(1,i))/Ra;
   Ia=min(0.8,max(0,Ia));
   plot(Ua,Ia)
   grid;
   xlabel('U [V]');
   ylabel('I [A]');
   title('DC motor characteristic')
   hold on
end
hold off