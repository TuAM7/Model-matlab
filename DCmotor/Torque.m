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
w=[0:250:w_nl];%% rot speed [rad/s]

lw=2; %%linewidth for plotting

Ua=0:0.00001:10;

%%Calculating counter Emf for different w
E=[];
for w=w
    E1=Ke*w;
    E=[E,E1];
end 
sE=numel(E);

%working point values
u=[];
for j=1:1:sE
    dcm=@(Ua) (Ua-E(1,j))/Ra; %% DC motor
    sp=@SolarPaneleq; %% Solar panel
    common=@(Ua) sp(Ua)-dcm(Ua); %% DCmotor-Solarpanel characteristic
    
    u0=3;
    u1=fzero(common,u0); %%u value at intersection
    
    
    plot(Ua,dcm(Ua),'linewidth',lw)
    hold on
    xlim([0 10]);
    xlabel('U [V]');
    ylim([0 1]);
    ylabel('I [A]');
    title('Solar panel and DC motor working points');
    plot(Ua,sp(Ua),'-k','linewidth',lw)
    grid;
    
    u=[u,u1]; %%U value at intersection points
end
hold off
dcm(u); %% I value at intersection
Pl=sp(u).*u; %% Electric power into the motor at certain E emf value


%Mechanical power
Pm=[]; %%Mechanical power at E(i) emf value
for j=1:1:sE
    Pm1=sp(u(1,j))*E(1,j);
    Pm=[Pm,Pm1];
end


%Torque
w2=[0:250:w_nl];%% rot speed [rad/s]
T=[];
for j=1:1:sE
    T1=Pm(1,j)/w2(1,j);%%Torque at certain speed and Emf [Nm]
    T=[T,T1];
end

% writing out values
i=sp(u) %% I value [A] at working point
u %%U value [V] at working point
T %% Motor torque [Nm] at working point