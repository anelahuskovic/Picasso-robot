%% pozicioniranje sa trenutnog mjesta na početak željenih koordinata
% x_kon, y_kon, z_kon - koordinate na koje se treba pozicionirati
% z_tren, fi1, fi2 - koordinate na kojima se trenutno nalazi

function f=pozicioniraj_se(x_kon,y_kon,z_kon,z_tren,fi1,fi2, brzina)
% prebavivanje sklopke u simulatoru na izlaze iz bloka za transformaciju
% (x,y) (fi1,fi2)
    set_param('model_ruke/sw1', 'sw', '0');
    set_param('model_ruke/sw2', 'sw', '0');

% zadane duljine ruku u zadatku
    l1=10;
    l2=10;
    
%određivanje koordinata na kojima se nalazi na početku
    x_poc=l1*cos(fi1)+l2*cos(fi2);
    y_poc=l1*sin(fi1)+l2*sin(fi2);
    
% odreživanje točaka u koje će se pozicionirati ruka
    k=odredi_k(x_kon, y_kon,z_tren,x_poc,y_poc,z_kon,2,brzina);
    x=linspace(x_poc,x_kon,k);
    y=linspace(y_poc,y_kon,k);
    z=linspace(z_tren,z_kon,k);
   
    global linija1 linija2 duljina_prsta tren_koor;
    
%ispisivanje zadanih točaka
    for i=1:k
        kut=kutevi(x(i),y(i),l1,l2);
        x1=l1*cos(kut(1));
        x2=l1*cos(kut(1))+l2*cos(kut(2));
        y1=l1*sin(kut(1));
        y2=l1*sin(kut(1))+l2*sin(kut(2));
        set(linija1,'xData',[0 x1],'yData',[0 y1]);
        set(linija2,'xData',[x1 x2],'yData',[y1 y2]);
        plot(x2,y2)
        drawnow;
        set(tren_koor,'String',['x=',num2str(x(i),'% .1f'), '   y=',num2str(y(i),'% .1f'), '   z=',num2str(z(i)-duljina_prsta,'% .1f')]);

        assignin ('base', 'x_tren', x(i));
        assignin ('base', 'y_tren', y(i));
        assignin ('base', 'z_tren', z(i));
        set_param('model_ruke','SimulationCommand','update');
        pause(0.005);
    end
   
% u slučaju da je k=0 ova funkcija će dati kuteve koji će se vratiti kao
% trenutni kutevi
   kut=kutevi(x_kon,y_kon,l1,l2);
% vrati nove kuteve
   f=[kut(1) kut(2) z_kon];
return