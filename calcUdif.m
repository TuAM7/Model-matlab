%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To Do create proper file header
% To Do add equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Udif = calcUdif(U_test,v,C,S,M)
%given a velocity (car or motor?) and the motor and panel characteristics,
%calculate the difference in voltage between the test voltage and a voltage
%corresponding to the current associated with Utest (associated to the
%motor or panel? )
%intput
%
%test voltage
%v:     [?] the speed of the car
%C:     structure containing parameters of the car
%S:     structure containing parameters of the solar panel
%M:     structure containing parameters of the motor

U_test;
ang_vel = (v.*C.gear_ratio)./(C.pulley_radius); % of motor


Iwp = S.current(U_test);
Umotor=(U_test - M.Ra.*Iwp)./M.Ke;

Udif = Umotor - U_test;

end