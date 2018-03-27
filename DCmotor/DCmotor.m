classdef DCmotor
    properties 
        Tms=0.0232;         % Stall torque [Nm]
        Ra=3.32;            % Terminal Resistance [Ohm]
        Kt=0.0085;          % Torque constant [Nm/A]
        Kv=1120/(60*2*pi);  % speed constant [rad/Vs]
        Ke=0.0085;          % Inverse of the speed constant [Vs/rad]
        Eff=0.84;           % Max efficiency
    end
    methods
        function ret=emf(obj,w)
            ret=obj.Ke.*w;
        end
        function ret=torque(obj,I)
            ret=obj.Kt.*I;
        end
    end
end

