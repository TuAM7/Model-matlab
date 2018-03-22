classdef SolarPanel
    properties
        m;                  % Diode factor
        Isc;                % Short circuit current
        k=1.38*10^(-23);    % Boltzmann constant [J/K]
        q=1.6*10^(-19);     % Charge of an electron [As]
        T=300;              % Temperature [K]
        Ur=0.0259;          % Thermal voltage [V]
        Is=1*10^(-8);       % Reverse saturation current [A]
        N=16;               % Amount of solar cells
        Voc = 9.47;
    end
    
    methods
        function obj = SolarPanel(m, Isc)
            obj.m = m;
            obj.Isc = Isc;
        end
        function I = current(obj,U)
            I = obj.Isc - obj.Is.*(exp(U./(obj.m*obj.Ur*obj.N))-1);
        end
    end
end

