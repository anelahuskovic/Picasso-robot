%%  crtanje kružnice
%  r - radijus kružnice
% x, y -koordinate središta kružnice
% brzina - brzina iscrtavanja točaka, zadaje se u glavnom programu drugi_gui

function f=crtanje_kruznice(r,x,y,z_tren,kut1,kut2,brzina)

% prebacivanje sklopke u simulatoru na izlaze iz bloka za transformaciju
% (x,y) (fi1,fi2)

set_param('model_ruke/sw1', 'sw', '0');
set_param('model_ruke/sw2', 'sw', '0');


% odreživanje točaka u koje će se pozicionirati ruka
k=odredi_k(2*pi,0,0,r,0,0,1,brzina);
fi=linspace(0,2*pi,k);


% zadane duljine ruku u zadatku
l1=10;
l2=10;



global linija1 linija2 tren_koor;

set_param('model_ruke','SimulationCommand','continue') ;

% spusti se na visinu pogodnu za pisanje po podlozi
kut=kutevi(x+r,y,l1,l2);
pozicioniraj_se(r+x,y,3,z_tren,kut(1),kut(2),brzina);

%ispisivanje zadanih točaka
for i=1:k
    x_ul=x+r*cos(fi(i));
    y_ul=y+r*sin(fi(i));
    kut=kutevi(x_ul,y_ul,l1,l2);
    x1=l1*cos(kut(1));
    x2=l1*cos(kut(1))+l2*cos(kut(2));
    y1=l1*sin(kut(1));
    y2=l1*sin(kut(1))+l2*sin(kut(2));
    set(linija1,'xData',[0 x1],'yData',[0 y1]);
    set(linija2,'xData',[x1 x2],'yData',[y1 y2]);
    plot(x2,y2);
    drawnow;
    set(tren_koor,'String',['x=',num2str(x2,'% .1f'), '   y=',num2str(y2,'% .1f'), '   z=',num2str(0,'% .1f')]);

    assignin ('base', 'x_tren', x_ul);
    assignin ('base', 'y_tren', y_ul);
    
    set_param('model_ruke','SimulationCommand','update');
    pause(0.005);
end  
% vrati se na prijašnju visinu i pauziraj simulaciju
pozicioniraj_se(r+x,y,z_tren,3,kut(1),kut(2),brzina);
set_param('model_ruke','SimulationCommand','pause'); 
set_param('model_ruke','SimulationCommand','update');


% vrati nove kuteve
f=[kut1 kut2 z_tren];
return