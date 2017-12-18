

function varargout = drugi_gui(varargin)

% DRUGI_GUI MATLAB code for drugi_gui.fig
%      DRUGI_GUI, by itself, creates a new DRUGI_GUI or raises the existing
%      singleton*.
%
%      H = DRUGI_GUI returns the handle to a new DRUGI_GUI or the handle to
%      the existing singleton*.
%
%      DRUGI_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRUGI_GUI.M with the given input arguments.
%
%      DRUGI_GUI('Property','Value',...) creates a new DRUGI_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drugi_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drugi_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drugi_gui

% Last Modified by GUIDE v2.5 14-May-2014 11:56:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drugi_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @drugi_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



% End initialization code - DO NOT EDIT


% --- Executes just before drugi_gui is made visible.
function drugi_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drugi_gui (see VARARGIN)

global kut1 kut2 z_tren trenutne_koordinate slider;

trenutne_koordinate=handles.koordinate;
slider=0;
handles.graf;
hold on;
axis([-12 12 0 20]);
line([-10 10],[6 6]);
line([10 10],[6 16]);    
line([-10 10],[16 16]);
line([-10 -10],[16 6]);
hold on;


%postavljanje pozicije kamere na poziciju najbolje 

robot = vrworld('jednostavni_robot');
open(robot);
c1 = vr.canvas(robot, gcf, [5.667 70 310.167 425.571]);
set(c1,'Units','normalized');
c1.Viewpoint='najbolje';

set(handles.koordinate,'String',['x=',num2str(0,'% .1f'), '   y=',num2str(20,'% .1f'), '   z=',num2str(7,'% .1f')]);

l1=10;
l2=10;
assignin('base', 'l1',l1);
assignin('base', 'l2',l2);
assignin('base', 'fi1',0);
assignin('base', 'fi2',0);



handles.x1=0.0;
handles.y1=0.0;
handles.z1=0.0;
handles.x2=0.0;
handles.y2=0.0;
handles.z2=0.0;
handles.pravacOK=0
handles.kruznicaOK=0
handles.pozicionirajOK=0
handles.rotacija1OK=0
handles.rotacija2OK=0
handles.visinaOK=0
kut1=pi/2;
kut2=pi/2;
z_tren=10;
x_tren=0;  
assignin ('base', 'x_tren', x_tren);
y_tren=20;
assignin ('base', 'y_tren',y_tren);
assignin ('base', 'z_tren',z_tren);


load_system('model_ruke');
set_param('model_ruke','SimulationCommand','update');
set_param('model_ruke','SimulationCommand','start');
pause(0.1)
set_param('model_ruke','SimulationCommand','pause');

set_param('model_ruke/sw1', 'sw', '0');
set_param('model_ruke/sw2', 'sw', '0');
z_tren=7;



% Choose default command line output for drugi_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drugi_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);




function f=reset_graf()
    
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);



% --- Outputs from this function are returned to the command line.
function varargout = drugi_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

    

% --- Executes on button press in kreni.
function kreni_Callback(hObject, eventdata, handles)
% hObject    handle to kreni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.kreni=get(hObject,'Value');
assignin ('base', 'kreni', handles.kreni);
handles.pom=0;
if (handles.pravacOK==1) | (handles.kruznicaOK==1) | (handles.pozicionirajOK==1)| (handles.rotacija1OK==1) | (handles.rotacija2OK==1) | (handles.visinaOK==1)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.

    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
    hold on;
    
 
    
    
    global kut1 kut2 linija1 linija2 z_tren tren_koor duljina_prsta slider;
    tren_koor=handles.koordinate;
    
    handles.pom=1;
    assignin ('base', 'pom', handles.pom);
    brzina=slider*0.6+0.1;
    assignin ('base', 'brzina',brzina);
    guidata(hObject, handles);
    l1=10;
    l2=10;
    duljina_prsta=3;
    x1=l1*cos(kut1);
    x2=l1*cos(kut1)+l2*cos(kut2);
    y1=l1*sin(kut1);
    y2=l1*sin(kut1)+l2*sin(kut2);
   
    linija1=line('xData',[0 x1],'yData',[0 y1]);
    linija2=line('xData',[x1 x2],'yData',[y1 y2]);
    
    handles.graf;
  
    if handles.pravacOK==1
        set_param('model_ruke','SimulationCommand','continue') ;
        if z_tren==0 & [l1*cos(kut1)+l2*cos(kut2) l1*sin(kut1)+l2*sin(kut2)]~=[handles.x1 handles.y1]
        kuti=pozicioniraj_se(l1*cos(kut1)+l2*cos(kut2),l1*sin(kut1)+l2*sin(kut2),handles.z1+duljina_prsta+5,z_tren+duljina_prsta,kut1,kut2, brzina);
        kut1=kuti(1);
        kut2=kuti(2);
        z_tren=kuti(3)-duljina_prsta;
        end
        
        kuti=pozicioniraj_se(handles.x1,handles.y1,handles.z1+duljina_prsta,z_tren+duljina_prsta,kut1,kut2, brzina);
        kut1=kuti(1);
        kut2=kuti(2); 
        z_tren=kuti(3)-duljina_prsta;
       
        kuti=crtanje_linije(handles.x1, handles.y1,handles.z1+duljina_prsta, handles.x2, handles.y2,handles.z2+duljina_prsta, kut1, kut2,z_tren+duljina_prsta, brzina);
        kut1=kuti(1);
        kut2=kuti(2);
        z_tren=kuti(3)-duljina_prsta;
        set_param('model_ruke','SimulationCommand','pause'); 
    end
    if handles.kruznicaOK==1
        set_param('model_ruke','SimulationCommand','continue');
        
        if z_tren==0 & [l1*cos(kut1)+l2*cos(kut2) l1*sin(kut1)+l2*sin(kut2)]~=[handles.x1 handles.y1]
        kuti=pozicioniraj_se(l1*cos(kut1)+l2*cos(kut2),l1*sin(kut1)+l2*sin(kut2),z_tren+duljina_prsta+7,z_tren+duljina_prsta,kut1,kut2, brzina);
        kut1=kuti(1);
        kut2=kuti(2);
        z_tren=kuti(3)-duljina_prsta;
        end
        
        kuti=pozicioniraj_se(handles.xsred+handles.radius,handles.ysred,z_tren+duljina_prsta,z_tren+duljina_prsta,kut1,kut2, brzina);
        kut1=kuti(1);
        kut2=kuti(2); 
        z_tren=kuti(3)-duljina_prsta;
        kuti=crtanje_kruznice(handles.radius, handles.xsred, handles.ysred,z_tren+duljina_prsta, kut1, kut2, brzina);
        kut1=kuti(1);
        kut2=kuti(2); 
        z_tren=kuti(3)-duljina_prsta;
        
        set_param('model_ruke','SimulationCommand','pause');
    end
    if handles.pozicionirajOK==1
       set_param('model_ruke','SimulationCommand','continue');
       kuti=pozicioniraj_se(handles.pozx, handles.pozy,handles.pozz+duljina_prsta,z_tren+duljina_prsta,kut1,kut2, brzina);
       kut1=kuti(1);
       kut2=kuti(2);
       z_tren=kuti(3)-duljina_prsta;
       set_param('model_ruke','SimulationCommand','pause');
    end
 
    if handles.rotacija1OK==1
       kuti=zakret_po_zglobovima(kut1, kut2,handles.kut1, 0,z_tren+duljina_prsta,0,0, brzina);
       kut1=kuti(1);
       kut2=kuti(2); 
       z_tren=kuti(3)-duljina_prsta;
    end
    
    if handles.rotacija2OK==1
       kuti=zakret_po_zglobovima(kut1, kut2,0,handles.kut2,z_tren+duljina_prsta,0,1, brzina);
       kut1=kuti(1);
       kut2=kuti(2); 
       z_tren=kuti(3)-duljina_prsta;
    end
    
    if handles.visinaOK==1
       kuti=zakret_po_zglobovima(kut1, kut2,0,0,z_tren+duljina_prsta,handles.visina,0, brzina);
       kut1=kuti(1);
       kut2=kuti(2); 
       z_tren=kuti(3)-duljina_prsta;
    end

    
end 
assignin ('base', 'pom', handles.pom);

guidata(hObject, handles);


% --- Executes on button press in crtaj_pravac.
function crtaj_pravac_Callback(hObject, eventdata, handles)
% hObject    handle to crtaj_pravac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of crtaj_pravac
handles.pravacOK=get(hObject,'Value');
assignin ('base', 'pravacOK', handles.pravacOK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0)& (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);

   
% --- Executes on button press in crtaj_kruznicu.
function crtaj_kruznicu_Callback(hObject, eventdata, handles)
handles.kruznicaOK=get(hObject,'Value');
assignin ('base', 'kruznicaOK', handles.kruznicaOK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0)& (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);


% --- Executes on button press in pozicioniraj_na_koordinate.
function pozicioniraj_na_koordinate_Callback(hObject, eventdata, handles)
handles.pozicionirajOK=get(hObject,'Value');
assignin ('base', 'pozicionirajOK', handles.pozicionirajOK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0)& (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);
   
  




function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double
    handles.x1=str2double(get(hObject,'String'));
    assignin ('base', 'x1', handles.x1);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y1_Callback(hObject, eventdata, handles)
    handles.y1=str2double(get(hObject,'String'));
    assignin ('base', 'y1', handles.y1);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function z1_Callback(hObject, eventdata, handles)
    handles.z1=str2double(get(hObject,'String'));
    assignin ('base', 'z1', handles.z1);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function z1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function x2_Callback(hObject, eventdata, handles)
    handles.x2=str2double(get(hObject,'String'));
    assignin ('base', 'x2', handles.x2);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y2_Callback(hObject, eventdata, handles)
    handles.y2=str2double(get(hObject,'String'));
    assignin ('base', 'y2', handles.y2);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function z2_Callback(hObject, eventdata, handles)
    handles.z2=str2double(get(hObject,'String'));
    assignin ('base', 'z2', handles.z2);
    guidata(hObject, handles);
    
% --- Executes during object creation, after setting all properties.
function z2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function xsred_Callback(hObject, eventdata, handles)
    handles.xsred=str2double(get(hObject,'String'));
    assignin ('base', 'xsred', handles.xsred);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xsred_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ysred_Callback(hObject, eventdata, handles)
    handles.ysred=str2double(get(hObject,'String'));
    assignin ('base', 'ysred', handles.ysred);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ysred_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radius_Callback(hObject, eventdata, handles)
    handles.radius=str2double(get(hObject,'String'));
    assignin ('base', 'radius', handles.radius);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pozx_Callback(hObject, eventdata, handles)
    handles.pozx=str2double(get(hObject,'String'));
    assignin ('base', 'pozx', handles.pozx);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pozx_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pozy_Callback(hObject, eventdata, handles)
    handles.pozy=str2double(get(hObject,'String'));
    assignin ('base', 'pozy', handles.pozy);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pozy_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pozz_Callback(hObject, eventdata, handles)
    handles.pozz=str2double(get(hObject,'String'));
    assignin ('base', 'pozz', handles.pozz);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pozz_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function graf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate graf




% --- Executes on button press in rotacija1.
function rotacija1_Callback(hObject, eventdata, handles)
handles.rotacija1OK=get(hObject,'Value');
assignin ('base', 'rotacija1OK', handles.rotacija1OK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0) & (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);


% --- Executes on button press in rotacija2.
function rotacija2_Callback(hObject, eventdata, handles)
handles.rotacija2OK=get(hObject,'Value');
assignin ('base', 'rotacija2OK', handles.rotacija2OK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0) & (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);

% --- Executes on button press in visina.
function visina_Callback(hObject, eventdata, handles)
handles.visinaOK=get(hObject,'Value');
assignin ('base', 'visinaOK', handles.visinaOK);
if (handles.pravacOK==0) & (handles.kruznicaOK==0) & (handles.pozicionirajOK==0) & (handles.rotacija1OK==0) & (handles.rotacija2OK==0) & (handles.visinaOK==0)
    axes(handles.graf); % Make averSpec the current axes.
    cla reset; % Do a complete and total reset of the axes.
   
    axis([-12 12 0 20]);
    grid on; 
    line([-10 10],[6 6]);
    line([10 10],[6 16]);    
    line([-10 10],[16 16]);
    line([-10 -10],[16 6]);
end
guidata(hObject, handles);


function kut1_Callback(hObject, eventdata, handles)
    handles.kut1=(str2double(get(hObject,'String'))*2*pi/360.0);
    assignin ('base', 'kut1', handles.kut1);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kut1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function kut2_Callback(hObject, eventdata, handles)
    handles.kut2=str2double(get(hObject,'String'))*2*pi/360.0;
    assignin ('base', 'kut2', handles.kut2);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kut2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function visina_h_Callback(hObject, eventdata, handles)
    handles.visina=str2double(get(hObject,'String'));
    assignin ('base', 'visina', handles.visina);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function visina_h_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('model_ruke','SimulationCommand','stop');
delete(handles.figure1);
close;


% --- Executes on button press in najbolji_pogled.
function najbolji_pogled_Callback(hObject, eventdata, handles)
% hObject    handle to najbolji_pogled (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
robot = vrworld('jednostavni_robot');
open(robot);
c1 = vr.canvas(robot, gcf, [5.667 70 310.167 425.571]);
set(c1,'Units','normalized');
c1.Viewpoint='najbolje';


% --- Executes on button press in desni_bok.
function desni_bok_Callback(hObject, eventdata, handles)
% hObject    handle to desni_bok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
robot = vrworld('jednostavni_robot');
open(robot);
c1 = vr.canvas(robot, gcf, [5.667 70 310.167 425.571]);
set(c1,'Units','normalized');
c1.Viewpoint='desni_bok';


% --- Executes on button press in odozgo.
function odozgo_Callback(hObject, eventdata, handles)
% hObject    handle to odozgo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
robot = vrworld('jednostavni_robot');
open(robot);
c1 = vr.canvas(robot, gcf, [5.667 70 310.167 425.571]);
set(c1,'Units','normalized');
c1.Viewpoint='odozgo';

% --- Executes on button press in odozada.
function odozada_Callback(hObject, eventdata, handles)
% hObject    handle to odozada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
robot = vrworld('jednostavni_robot');
open(robot);
c1 = vr.canvas(robot, gcf, [5.667 70 310.167 425.571]);
set(c1,'Units','normalized');
c1.Viewpoint='odozada';

% --- Executes on slider movement.
function brzinomjer_Callback(hObject, eventdata, handles)
global slider
% hObject    handle to brzinomjer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider=vpa(get(hObject,'Value'));


% --- Executes during object creation, after setting all properties.
function brzinomjer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brzinomjer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function koordinate_Callback(hObject, eventdata, handles)
% hObject    handle to koordinate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of koordinate as text
%        str2double(get(hObject,'String')) returns contents of koordinate as a double
