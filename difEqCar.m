%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To Do create proper file header
% To Do add differential equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function called difEqCar will have to return the derivative of the
%two variables (V) we keep track of in the simulation: position and speed of the car
%for each of these variables we will have to provide a value for the
%derivative (dV) of that variable, given a certain input
function dV = difEqCar(t,V,C,S,M,T)
 
%input
%t:     [sec] time
%V:     current value of the parameters we keep track of
%       the size of V = 2x1, V(1,1) is the position and V(2,1) the speed
%C:     structure containing parameters of the car
%S:     structure containing parameters of the solar panel
%M:     structure containing parameters of the motor
%T:     structure containing parameters of the track
 
 
%current position and speed
xcur  = V(1,1);
dxcur = V(2,1);
 
 
%given the current speed (dxcur) calculate the new working point between
%solar panel and motor
[Ucur,Icur]=calcCurWp(dxcur,C,S,M);   %function that calculates the new working point
%using power, calculate the current torque available for car acceleration
power = Ucur*Icur;

Tmotor = (Icur-0.021)*0.0232/(1.8-0.021);
ang_vel=Tmotor/power;

if ang_vel < eps
    Tmotor = M.Tms;
end

%using the Tcur, calculate the current acceleration of the car
slope = T.slope(xcur);

N = C.Mssv.*9.81.*cos(slope);           % Normal force

Fwx=C.frc*N.*sin(slope);
Fwy=C.frc*N.*cos(slope);
Fw=sqrt(Fwx^2+Fwy^2); % Friction
Fw = max(0,Fw);

Fx=Fwx; %%sum of x direction forces [N]
Fy=Fwy-C.Mssv*9.81; %%sum of y direction forces [N]
F=sqrt(Fx^2+Fy^2); %%Force

Tpulley=F.*C.pulley_radius; %% torque pulley                    
GR=Tmotor/Tpulley %%gear ratio

ang_vel = (GR.*dxcur)/(C.pulley_radius);
ddxcur = F./C.Mssv;

 
%create the output dV of this function difEqCar
%dV(1,1) is the derivative of the current position = current speed
dV(1,1) = dxcur;
%dV(2,1) is the derivative of the current speed = current acceleration
dV(2,1) = ddxcur;
 
 
end
