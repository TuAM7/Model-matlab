U = 0:0.01:10;

sp = SolarPanel(1.2129, 0.69);

I = sp.current(U);
UI = [U;I]';
P = sp.current(U).*U;
UP = [U;P]';

[Pp,Np] = max(UP(:,2));
Up = UP(Np,1);
Ip = UI(Np,2);

plot(U,I, 'Color', [0 0.25 1]);
hold on
plot(U,P, 'Color', [0.5 0.75 1]);

plot([Up,Up], [Pp,Ip], 'ro');

line([Up Up], [0 Pp+1], 'Color', [0.75 0.75 0.75]);

M = DCmotor();
Wp = (Up - M.Ra.*Ip)./M.Ke; % Peak angular velocity
Im=(U-M.emf(Wp))./M.Ra;
plot(U,Im, 'Color', [1 0 0.25]);

axis([0 10 0 Pp+1])
xlabel('Voltage [V]')
ylabel('Current [A] / Power [W]')
legend('Current','Power',num2str([Pp,Ip],'Peak power (%.1f W) and current (%.1f A)'),num2str(Up,'Peak voltage (%.1f V)'),num2str(Wp,'Motor current @ %.1f rad/s'),'location','NorthWest');
grid on

hold off


