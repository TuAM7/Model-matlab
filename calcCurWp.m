%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To Do create proper file header
% To Do add equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%this function will return the voltage and current of the working point
%between solar panel and motor.  
function [Uwp,Iwp] = calcCurWp(v,C,S,M)
%intput
%
%v:     [?] the speed of the car
%C:     structure containing parameters of the car
%S:     structure containing parameters of the solar panel
%M:     structure containing parameters of the motor
 
%to calculate a wp between to curves f(x)=g(x) we can use fzero of
%h(x)=f(x)-g(x)
%example
%If we start with a given Utest we can calculate e.g. Isolar panel.  
%Given this Isolar we can calculate the the Udifference = Utest - Umotor.   
%fzero will try to find Udifference = 0 by changing Utest.
%You can do the same with first calculating the Imotor or with some Itest.
%What would be the advantages/disadvantages of the different approaches? (first Imotor/Ipanel/Umotor/Upanel 



Uwp = fzero(@(U) calcUdif(U,v,C,S,M),[0 9]);
Iwp = S.current(Uwp);


if Iwp < 0
    Iwp = 0;
end

end