classdef DCmotor
    properties 
        Tms=23.2; %%Stall torque [mNm]
        Ra=3.32; %%Terminal Resistance [Ohm]
        Kt=0.0085; %%Torque constant [mNm/A]
        Kv=1120/60*2*pi; %%speed constant [rad/Vs]
        Ke=0.0085; %%Inverse of the speed constant [Vs/rad]
        
    end
    methods
        function ret=emf(obj,w)
            ret=obj.Ke*w;
        end
    end
end

