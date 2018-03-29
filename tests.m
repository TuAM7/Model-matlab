%%
addpath ./DCmotor
addpath ./SolarPanel
addpath ./Track

C.Mssv = 0.3;               % [kg] mass of the SSV
C.gear_ratio =5;         % [] gear ratio: input/output   (motor speed /wheel axel speed)
C.frc = 0.3;                % Friction coef
C.pulley_radius = 0.025;
C.voltage_offset = -0.2;

car.Mssv = 0.3;               % [kg] mass of the SSV
car.gear_ratio = 0.14;         % [] gear ratio: input/output   (motor speed /wheel axel speed)
car.frc = 0.3;                % Friction coef
car.pulley_radius = 0.025;
car.voltage_offset = -0.2;


panel = SolarPanel(1.271,0.69);

motor = DCmotor();

track = Track(3, 2.2, 0.4);

%set initial position and speed of the car on the track
x0 = 0;   %[m]
dx0 = 0;  %[m/s]
 
%call the ode45 function in order to solve the differential equation problem
endTime = 50; %[sec] overall time you want the simulation to run for 
%e.g. simulate the movement of the car from 0 to 10 sec
out = [];
i = 1;
for GR = 8:1:20
    car.gear_ratio = GR;
    [timeOut,Pout]=ode45(@(t,P) difEqCar(t,P,car,panel,motor,track),0:0.01:10,[x0 dx0]);
    index = find(Pout(:,1)>7,1);
    out(i,1) = GR;
    out(i,2) = timeOut(index);
    out(i,3) = max(Pout([1 index],2));
    i = i+1;
end



yyaxis left
plot(out(:,1),out(:,2),'-o')
ylabel('Time to reach 7 m [s]')
yyaxis right
plot(out(:,1),out(:,3),'-o')
grid on;
xlabel('Gear ratio')
title('Gear ratio analysis')
ylabel('max velocity [m/s]')

