addpath './DCmotor'
addpath './SolarPanel'
addpath './Track'

WorkingPointGUI();

function WorkingPointGUI
% Add the UI components
hs = addcomponents;
plotwp();
% Make figure visible after adding components
hs.fig.Visible = 'on';

    function hs = addcomponents
        % Add components, save handles in a struct
        hs.fig = figure('Visible','off',...
            'Tag','fig',...
            'SizeChangedFcn',@resizeui);
        hs.lblIsc = uicontrol(hs.fig,...
            'Style','text',...
            'String','Short circuit current [A]');
        hs.txtIsc = uicontrol(hs.fig,...
            'Style','edit',...
            'String','0.69',...
            'Callback',@plotwp,...
            'Tag','text');
        hs.lblVo = uicontrol(hs.fig,...
            'Style','text',...
            'String','Peak voltage offset [V]');
        hs.txtVo = uicontrol(hs.fig,...
            'Style','edit',...
            'String','-0.1',...
            'Callback',@plotwp,...
            'Tag','text');
        hs.ax = axes('Parent',hs.fig,...
            'Units','pixels',...
            'Tag','ax');
    end

    function plotwp(hObject,event)
        Isc = str2double(get(hs.txtIsc,'String'));
        Vo = str2double(get(hs.txtVo,'String'));
        
        U = 0:0.001:10;
        
        sp = SolarPanel(1.271, Isc);
        
        I = sp.current(U);
        UI = [U;I]';
        P = sp.current(U).*U;
        UP = [U;P]';
        
        [Pp,Np] = max(UP(:,2));
        Uwp = UP(Np,1)+Vo;
        Pwp = sp.current(Uwp).*Uwp;
        Iwp = sp.current(Uwp);
        
        plot(U,I, 'Color', [0 0.25 1]);
        hold on
        plot(U,P, 'Color', [0.5 0.75 1]);
        
        plot([Uwp,Uwp], [Pwp,Iwp], 'ro');
        
        line([Uwp Uwp], [0 Pp+1], 'Color', [0.5 0.5 0.5]);
        
        M = DCmotor();
        Wp = (Uwp - M.Ra.*Iwp)./M.Ke % Peak angular velocity
        Im=(U-M.emf(Wp))./M.Ra;
        plot(U,Im, 'Color', [1 0 0.25])
        
        axis([0 10 0 Pp+0.2])
        title('Solar panel and motor characteristics')
        xlabel('Voltage [V]')
        ylabel('Current [A] / Power [W]')
        legend('Solar Panel Current','Solar Panel Power',num2str([Pwp,Iwp],'Peak power (%.2f W) and current (%.2f A)'),num2str(Uwp,'Peak voltage (%.2f V)'),num2str(Wp,'Motor current @ %.1f rad/s'),'location','NorthWest');
        grid on
        
        hold off
    end

    function resizeui(hObject,event)
        % Get figure width and height
        figwidth = hs.fig.Position(3);
        figheight = hs.fig.Position(4);
        
        edge = 10;
        
        % Set textbox position
        sheight = 20;
        sgap = 5;
        swidth = (figwidth - 2 * edge - sgap*3)/4;
        sbottomedge = edge;
        sleftedge = edge;
        hs.lblIsc.Position = [sleftedge sbottomedge swidth sheight];
        hs.txtIsc.Position = [sleftedge+1*(swidth+sgap) sbottomedge swidth sheight];
        hs.lblVo.Position = [sleftedge+2*(swidth+sgap) sbottomedge swidth sheight];
        hs.txtVo.Position = [sleftedge+3*(swidth+sgap) sbottomedge swidth sheight];
        
        
        % Set axes position
        axtray = 40;
        axheight = figheight - 2 * edge - sheight - 2 * axtray;
        axbottomedge = max(0,edge + sheight + edge + axtray);
        axleftedge = edge + axtray;
        axwidth = max(0,figwidth - 2 * edge - axtray);
        hs.ax.Position = [axleftedge axbottomedge axwidth axheight];
    end

end