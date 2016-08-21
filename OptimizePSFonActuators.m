function OptimizePSFonActuators(hObj,hand)

global hObject;
global handles;

hObject = hObj;
handles = hand;
AberrationControlHandles = handles.ControlHandles;

TickHandles=handles.TickHandles;
NumModes = length(TickHandles);
CentralAmplitudes = zeros(1,length(handles.amplitudes));

for i=1:NumModes
    ModesToOptimize(i)=get(TickHandles(i),'Value');
    InitialAmplitudes(i)=get(AberrationControlHandles(i),'Value');
end
if strcmp(handles.OptimizeTag,'RadialSymmetry')
    OptimizationMethod = 2;
elseif strcmp(handles.OptimizeTag,'Sharpness')
    OptimizationMethod = 3;
elseif strcmp(handles.OptimizeTag,'ExperimentalPSF')
    OptimizationMethod = 4;
else
    OptimizationMethod = 1;
end


InitialPopulation = (rand(100,64));

options = gaoptimset('Display','iter','PopulationSize',100,'InitialPopulation',InitialPopulation,'TolFun',1e-3,'StallGenLimit',5);
%options = gaoptimset('Display','iter','InitialPopulation',InitialPopulation);

f = @(A)PSFFitnessOnActuators(A,OptimizationMethod);
nvars = 64;
%ga(f,nvars,[],[],[],[],-150*ones(1,nvars),150*ones(1,nvars),[],options)
[Res,fval,exitflag,output]=ga(f,nvars,[],[],[],[],0.0*ones(1,nvars),0.6*ones(1,nvars),[],options);
save('GAdata.mat','Res','fval','exitflag','output');


setMirrorChannels(Res);

