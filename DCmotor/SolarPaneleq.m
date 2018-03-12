function Isp=SolarPaneleq(Ua)

Is=1*10^-8; %%Reverse saturation current [A]
N=16;
k=1.38*10^-23;  %%Boltzmann constant [J/K]
q=1.6*10^-19;  %%charge of an electron [As]
T=300;  %%Temperature [K]
Ur=(k*T)/q;  %%Thermal voltage [V]
Uoc=9.47; %%Open circuit voltage [V]
Isc=0.860; %%Short-cicuit current [A] measured
m=1.13; %% Diode factor, average value

Isp=Isc-Is*(exp(Ua/(m*Ur*N))-1);

end