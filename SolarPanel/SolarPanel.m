classdef SolarPanel
    properties
        m;                  %%Diode factor
        k=1.38*10^(-23);    %%Boltzmann constant [J/K]
        q=1.6*10^(-19);     %%charge of an electron [As]
        T=300;              %%Temperature [K]
        Ur=0.0259;          %%Thermal voltage [V]
        
        Is=1*10^(-8);       %%Reverse saturation current [A]
        N=16;               %%Amount of solar cells
    end
    
    methods
        function obj = SolarPanel(m)
            obj.m = m;
        end
        function I = current(obj,Isc,U)
            I = Isc - obj.Is*(exp(U/(obj.m*obj.Ur*obj.N))-1);
        end
    end
end

