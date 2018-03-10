
sp = SolarPanel(1.2129);

fplot(@(U) sp.current(0.36,U),[0 10])
axis([0 10 0 0.5])
title('Power over voltage')
xlabel('Voltage (V)')
ylabel('Current (A)')
