clc
close all

Ra=3.32; %%Terminal Resistance [Ohm]
w_nl=9630*2*pi/60; %%no load speed [rad/s] ~1000 rad/s

Ua=0:0.00001:10;
n=150; %% increment of the rotational speed in foor loops

%%Calculating counter Emf for different w
dc= DCmotor(); 
E=[];
for w=0:n:w_nl
    dc.emf(w);
    E=[E,dc.emf(w)];
end 
sE=numel(E);


%working point values
u=[];
for j=1:1:sE
    dcm=@(Ua) (Ua-E(j))/Ra; %% DC motor
    sp=@SolarPaneleq; %% Solar panel
    common=@(Ua) sp(Ua)-dcm(Ua); %% DCmotor-Solarpanel characteristic
    
    u0=0;
    u1=fzero(common,u0); %%u value at intersection
    
    lw=2; %%linewidth for plotting
    plot(Ua,dcm(Ua),'linewidth',lw) %%dc motor plot
    hold on
    xlim([0 10]);
    xlabel('U [V]');
    ylim([0 1]);
    ylabel('I [A]');
    title('Solar panel and DC motor working points');
    plot(Ua,sp(Ua),'-k','linewidth',lw) %% solar panel plot
    grid;
    
    u=[u,u1] %%U value at intersection points
end
hold off
dcm(u); %% I value at intersection
Pl=sp(u).*u; %% Electric power into the motor at certain E emf value


%Mechanical power
Pm=[]; %%Mechanical power at E(j) emf value
for j=1:1:sE
    Pm1=Pl(j)-sp(u(j)).^2*Ra;
    Pm=[Pm,Pm1];
end


%Torque
w2=[0:n:w_nl];%% rot speed [rad/s]
T=[];
for j=1:1:sE
    T1=Pm(j)/w2(j);%%Torque at certain speed and Emf [Nm]
    T=[T,T1];
end

% writing out values
i=sp(u) %% I value [A] at working point
u %%U value [V] at working point
T %% Motor torque [Nm] at working point