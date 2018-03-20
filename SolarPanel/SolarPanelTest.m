U = 0:0.01:10;

sp = SolarPanel(1.2129, 0.36);

I = sp.current(U);
UI = [U;I]';
P = sp.current(U).*U;
UP = [U;P]';

[Pp,Np] = max(UP(:,2));
Up = UP(Np,1);
Ip = UI(Np,2);

plot(U,I);
hold on
plot(U,P);

plot(Up, Pp, 'o');
plot(Up, Ip, 'o');

line([Up Up], [0 3]);

M = DCmotor();
Wp = (Up - M.Ra.*Ip)./M.Ke % Peak angular velocity
Im=(U-M.emf(Wp))./M.Ra;
plot(U,Im);

axis([0 10 0 inf])
xlabel('Voltage (V)')
ylabel('Current (A)')
legend('Current','Power','Peak power','Current at peak power','Peak voltage','Motor current','location','NorthWest');
grid on

hold off


