%% crtanje linije
% ulazi x1 y1 z1 -početne koordinate linije
% x2 y2 z2 - konačne koordinate linije
% brzina - brzina iscrtavanja točaka, zadaje se u glavnom programu drugi_gui


function f=crtanje_linije_proba(x1,y1,z1,x2,y2,z2,kut1, kut2,z_tren,brzina)
% prebacivanje sklopke u simulatoru na izlaze iz bloka za transformaciju
% (x,y) (fi1,fi2)

    set_param('model_ruke/sw1', 'sw', '0');
    set_param('model_ruke/sw2', 'sw', '0');
    
% odreživanje točaka u koje će se pozicionirati ruka
    k=odredi_k(x2,y2,z2,x1,y1,z1,2,brzina);
    x=linspace(x1,x2,k);
    y=linspace(y1,y2,k);
    z=linspace(z1,z2,k);
    
% zadane duljine ruku u zadatku
    l1=10;
    l2=10;
    
    
    global linija1 linija2 tren_koor duljina_prsta;
      
    set_param('model_ruke','SimulationCommand','continue');

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

%slanje točaka u simulaciju
        assignin ('base', 'x_tren', x(i));
        assignin ('base', 'y_tren', y(i));
        assignin ('base', 'z_tren', z(i));
        set_param('model_ruke','SimulationCommand','update');
        pause(0.005);
    end 
    

    set_param('model_ruke','SimulationCommand','pause');
    set_param('model_ruke','SimulationCommand','update');
    kut(1)
    kut(2)

% vrati nove kuteve   
f=[kut(1) kut(2) z2];
return



