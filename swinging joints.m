
function f=zakret_po_zglobovima(kut1_tren, kut2_tren, kut_prvi, kut_drugi,z_tren,z_kon,prvi_ili_drugi ,brzina)
% prebacivanje sklopke u simulatoru na elemente kojima se zadaju kutevi
% direktno
    set_param('model_ruke/sw1', 'sw', '1');
    set_param('model_ruke/sw2', 'sw', '1');
    
    global linija1 linija2 tren_koor duljina_prsta;
% zadane duljine ruku u zadatku
    l1=10;
    l2=10;
    
% određivanje početnih i konačnih koordinata, iz njih se računa duljina
% prijeđenog puta, te služi za određivanje broja diskretnih položaja
    x1=l1*cos(kut1_tren)+l2*cos(kut2_tren);
    y1=l1*sin(kut1_tren)+l2*sin(kut2_tren);
    x2=l1*cos(kut1_tren+kut_prvi)+l2*cos(kut2_tren+kut_drugi);
    y2=l1*sin(kut1_tren+kut_prvi)+l2*sin(kut2_tren+kut_drugi);
    
    if z_kon~=0
        k=odredi_k(0,0,0,0,z_tren,z_tren+z_kon,2,brzina);
    else
        if prvi_ili_drugi==0
            radijus=sqrt(x2^2+y2^2);
            k=odredi_k(-abs(kut_prvi), 0, 0,radijus,0,0,1,brzina);
        else
            radijus=l2;
            k=odredi_k(kut_drugi, 0, 0,radijus,0,0,1,brzina);
        end
    end
    

% odreživanje točaka u koje će se pozicionirati ruka
    kut1=linspace(0,kut_prvi,k);
    kut2=linspace(0,kut_drugi,k);
    z=linspace(z_tren,z_tren+z_kon,k);
%ispisivanje zadanih točaka 
    set_param('model_ruke','SimulationCommand','continue'); 
    
    if prvi_ili_drugi==0
        radijus=sqrt(x2^2+y2^2);
        for i=1:k
        x1=l1*cos(kut1(i)+kut1_tren);
        x2=l1*cos(kut1(i)+kut1_tren)+l2*cos(kut2_tren+kut1(i));
        y1=l1*sin(kut1(i)+kut1_tren);
        y2=l1*sin(kut1(i)+kut1_tren)+l2*sin(kut2_tren+kut1(i));
        set(linija1,'xData',[0 x1],'yData',[0 y1]);
        set(linija2,'xData',[x1 x2],'yData',[y1 y2]);
        plot(x2,y2);
        drawnow;
        set(tren_koor,'String',['x=',num2str(x2,'% .1f'), '   y=',num2str(y2,'% .1f'), '   z=',num2str(z(i)-duljina_prsta,'% .1f')]);
       
        assignin ('base', 'fi1', kut1_tren+kut1(i));  
        assignin ('base', 'fi2', kut2_tren+kut2(i)+kut1(i)); 
        assignin ('base', 'z_tren', z(i));
        set_param('model_ruke','SimulationCommand','update');
        pause(0.005);
    end 
    else
        for i=1:k
        x1=l1*cos(kut1_tren);
        x2=l1*cos(kut1_tren)+l2*cos(kut2(i)+kut2_tren);
        y1=l1*sin(kut1_tren);
        y2=l1*sin(kut1_tren)+l2*sin(kut2(i)+kut2_tren);
        set(linija1,'xData',[0 x1],'yData',[0 y1]);
        set(linija2,'xData',[x1 x2],'yData',[y1 y2]);
        plot(x2,y2);
        drawnow;
        set(tren_koor,'String',['x=',num2str(x2,'% .1f'), '   y=',num2str(y2,'% .1f'), '   z=',num2str(z(i)-duljina_prsta,'% .1f')]);
        assignin ('base', 'fi1', kut1_tren+kut1(i));  
        assignin ('base', 'fi2', kut2_tren+kut2(i)+kut1(i)); 
        assignin ('base', 'z_tren', z(i));
        set_param('model_ruke','SimulationCommand','update');
        pause(0.005);
        end 
    end
    
  
    
    set_param('model_ruke','SimulationCommand','pause');
% vrati nove kuteve

f=[(kut1_tren+kut_prvi) (kut2_tren+kut_drugi+kut_prvi) (z_tren+z_kon)];
return

