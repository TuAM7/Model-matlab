%%

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

GR = 0.08:0.01:0.19;
out = [];
i = 1;
for GR = 0.08:0.01:0.19
    car.gear_ratio = 0.19;
    [timeOut,Pout]=ode45(@(t,P) difEqCar(t,P,car,panel,motor,track),0:0.01:10,[x0 dx0]);
    index = find(Pout(:,1)>7,1);
    out(i,1) = GR;
    out(i,2) = timeOut(index);
    i = i+1;
end
out

