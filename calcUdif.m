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


ang_vel = (v.*C.gear_ratio)./(C.pulley_radius); % of motor

Iwp = S.current(U_test);
%Umotor=(M.Ra.*Iwp)./M.Ke;
Imotor = (U_test -  M.emf(ang_vel))./M.Ra;
%Umotor=M.Ra.*Iwp+M.emf(ang_vel);

%Udif = Umotor - U_test;
Udif = Imotor - Iwp;

end