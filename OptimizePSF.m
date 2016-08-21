function OptimizePSF(hObj,hand)

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
else
    OptimizationMethod = 1;
end


InitialPopulation = 50*2*(rand(60,sum(ModesToOptimize))-0.5);

options = gaoptimset('Display','iter','PopulationSize',60,'InitialPopulation',InitialPopulation);
f = @(A)PSFFitness(A,ModesToOptimize,InitialAmplitudes,OptimizationMethod);
nvars = sum(ModesToOptimize);
%ga(f,nvars,[],[],[],[],-150*ones(1,nvars),150*ones(1,nvars),[],options)
%Res=ga(f,nvars,[],[],[],[],[],[],[],options);
[Res,fval,exitflag,output]=ga(f,nvars,[],[],[],[],-50*ones(1,nvars),50*ones(1,nvars),[],options);

n=0;
for i=1:length(ModesToOptimize)
    if (ModesToOptimize(i))
        n = n + 1;
        GUIAmplitudes(i) = Res(n);
    end
end

SetMirrorModes(hObject,handles,GUIAmplitudes,false);
