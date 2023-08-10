function varargout = standard_GUI(varargin)
% STANDARD_GUI MATLAB code for standard_GUI.fig
%      STANDARD_GUI, by itself, creates a new STANDARD_GUI or raises the existing
%      singleton*.
%
%      H = STANDARD_GUI returns the handle to a new STANDARD_GUI or the handle to
%      the existing singleton*.
%
%      STANDARD_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STANDARD_GUI.M with the given input arguments.
%
%      STANDARD_GUI('Property','Value',...) creates a new STANDARD_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before standard_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to standard_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% edit_dispvalthird the above text to modify the response to help standard_GUI

% Last Modified by GUIDE v2.5 04-Aug-2015 11:42:26

% Begin initialization code - DO NOT EDIT_DISPVALTHIRD
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @standard_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @standard_GUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT_DISPVALTHIRD


% --- Executes just before standard_GUI is made visible.
function standard_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to standard_GUI (see VARARGIN)

% Choose default command line output for standard_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes standard_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = standard_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_opendata.
function pushbutton_opendata_Callback(hObject, eventdata, handles)   %打开按钮
% hObject    handle to pushbutton_opendata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[F,folder,FilterIndex] = uigetfile({'*.bmp','OCT Raw Files(*.bmp)'}, 'Select your File ');
filepathstring = strcat(folder,F); 
% global aaa='filepathstring';
set(hObject,'String',filepathstring);
%cd(folder);
        
  
    

% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles) %处理按钮
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
aa=subfunction_preprocessing('filepathstring');

    


% --- Executes on slider movement.
function slider_dispValfirst_Callback(hObject, eventdata, handles) %一阶色散滑块
% hObject    handle to slider_dispValfirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.slider_dispValfirst,'Value');
%puts the slider value into the edit_dispValThird text component
set(handles.edit_dispValFirst,'String', num2str(sliderValue));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_dispValfirst_CreateFcn(hObject, eventdata, handles) 
% hObject    handle to slider_dispValfirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_dispValThird_Callback(hObject, eventdata, handles)  %三阶色散滑块
% hObject    handle to slider_dispValThird (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue2 = get(handles.slider_dispValThird,'Value');
%puts the slider value into the edit_dispValThird text component
set(handles.edit_dispValThird,'String', num2str(sliderValue2));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_dispValThird_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_dispValThird (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_dispValFirst_Callback(hObject, eventdata, handles) %一阶色散参数显示
% hObject    handle to edit_dispValFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue = get(handles.edit_dispValFirst,'String');
%puts the slider value into the edit_dispValThird text component
set(handles.slider_dispValfirst,'Value', str2num(sliderValue));
%convert from string to number if possible, otherwise returns empty

% Hints: get(hObject,'String') returns contents of edit_dispValFirst as text
%        str2double(get(hObject,'String')) returns contents of edit_dispValFirst as a double


% --- Executes during object creation, after setting all properties.
function edit_dispValFirst_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dispValFirst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit_dispValThird controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dispValThird_Callback(hObject, eventdata, handles)  %三阶色散参数显示
% hObject    handle to edit_dispValThird (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sliderValue2 = get(handles.edit_dispValThird,'String');
%puts the slider value into the edit_dispValThird text component
set(handles.slider_dispValThird,'Value', str2num(sliderValue2));
% Hints: get(hObject,'String') returns contents of edit_dispValThird as text
%        str2double(get(hObject,'String')) returns contents of edit_dispValThird as a double


% --- Executes during object creation, after setting all properties.
function edit_dispValThird_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dispValThird (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit_dispValThird controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_parallelopen.
function pushbutton_parallelopen_Callback(hObject, eventdata, handles)   %开启多线程
% hObject    handle to pushbutton_parallelopen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matlabpool open;
set(handles.edit_linenumber,'String', num2str(4));
msgbox('多线程处理：开启','成功','信息对话框图标')

% --- Executes on button press in pushbutton_parallelclose.
function pushbutton_parallelclose_Callback(hObject, eventdata, handles)    %关闭多线程
% hObject    handle to pushbutton_parallelclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matlabpool close;
set(handles.edit_linenumber,'String', num2str(1));
msgbox('多线程处理：关闭','成功','信息对话框图标')


function edit_linenumber_Callback(hObject, eventdata, handles)      %线程数量显示
% hObject    handle to edit_linenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_linenumber as text
%        str2double(get(hObject,'String')) returns contents of edit_linenumber as a double


% --- Executes during object creation, after setting all properties.
function edit_linenumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_linenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%子程序%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%图像预处理
function y=subfunction_preprocessing(x)
aad=double(imread(x));
add=aad(:,:,1); 

add(1,:)=[];%删除第一行无用数据

n=size(add);
Bscan=n(1,1);
for i=1:1:Bscan
aa(i,:)=fliplr(add(i,:));
end
y=aa;
end
