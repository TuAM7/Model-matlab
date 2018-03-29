%%
<<<<<<< HEAD
addpath ./DCmotor
addpath ./SolarPanel
addpath ./Track
=======

>>>>>>> 5ebf08b0fb36e099d4cc8309a0ad96727a6359cb

C.Mssv = 0.3;               % [kg] mass of the SSV
C.gear_ratio =5;         % [] gear ratio: input/output   (motor speed /wheel axel speed)
C.frc = 0.3;                % Friction coef
C.pulley_radius = 0.025;
C.voltage_offset = -0.2;

<<<<<<< HEAD
car.Mssv = 0.3;               % [kg] mass of the SSV
car.gear_ratio = 0.14;         % [] gear ratio: input/output   (motor speed /wheel axel speed)
car.frc = 0.3;                % Friction coef
car.pulley_radius = 0.025;
car.voltage_offset = -0.2;

=======
>>>>>>> 5ebf08b0fb36e099d4cc8309a0ad96727a6359cb

panel = SolarPanel(1.271,0.69);

motor = DCmotor();

<<<<<<< HEAD
track = Track(3, 2.2, 0.4);
=======

bumpstart = 3;
track = Track(bumpstart, 2.2, 0.4);
>>>>>>> 5ebf08b0fb36e099d4cc8309a0ad96727a6359cb

%set initial position and speed of the car on the track
x0 = 0;   %[m]
dx0 = 0;  %[m/s]
 
time = 0:0.01:5;

out = [];
i = 1;
for GR = 6:0.1:8
    car.gear_ratio = GR;
    % ode15s is (much) faster
    [timeOut,Pout]=ode15s(@(t,P) difEqCar(t,P,car,panel,motor,track),time,[x0 dx0]);
    index = find(Pout(:,1)>7,1);
    if index > 0
    out(i,1) = GR;
    out(i,2) = timeOut(index);
    out(i,3) = max(Pout([1 index],2));
    i = i+1;
    end
end


%% PLOT
figure
yyaxis left
plot(out(:,1),out(:,2),'-')
ylabel('Time to reach 7 m [s]')
yyaxis right
plot(out(:,1),out(:,3),'-')
grid on;
xlabel('Gear ratio')
title(num2str(bumpstart,'Gear ratio analysis (bump starts at %.1f m)'))
ylabel('max velocity [m/s]')

