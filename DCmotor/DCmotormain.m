clear all
clc
close all

dc= DCmotor(); 

E=[];
for w=0:250:1000
    dc.emf(w);
    E=[E,dc.emf(w)];
end 
sE=numel(E);

Ua=0:10;
%%plotting DC motor characteristics for different w
for i=1:1:sE
   Ia=(Ua-E(1,i))/dc.Ra;
   plot(Ua,Ia)
   grid;
   xlabel('U [V]');
   ylabel('I [A]');
   title('DC motor characteristic')
   ylim([0 1]);
   xlim([0 10]);
   hold on
end
hold off
