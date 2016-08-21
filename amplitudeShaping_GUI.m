

function amplitudeShaping_GUI

close( figure(1000) );

addpath('../spectrometer2');
initSpectro;

global currentSpectro;
currentSpectro = 1;


integrationTime_ini=10; %ms
setSpectroIntegrationTime(integrationTime_ini, currentSpectro);

makeTodaysDirectory();
todaysDate=datestr(now,'yyyymmdd');

theFigure = figure(1000);
set( theFigure,'units','normalized',...
    'toolbar','figure',...
    'position',[0.01 0.01 0.98 0.90],...
    'color',[1 1 1],...
    'name','Operation Desert Eagle: Spectral Amplitude Control',...
    'CloseRequestFcn' , @closeInterface);

C = 3e5;
theFontSize = 14;
lambda= getSpectroWavelengths(currentSpectro); %in nm
spectrum=[];

backgroundSpectrum = 0;

reference = load('./data/lastLaserSpectrum.mat');
OriginalSp_ = reference.laserSpectrum;
OriginalLambda = reference.lambda;
OriginalSp = OriginalSp_/max(OriginalSp_);
[maxVal indx] = max(OriginalSp);

wsp = zeros(length(OriginalSp));
eta_ =[];
importedSpectrum = [];

axes_1 = axes('position',[0.3 0.07 0.66 0.48]);
set(axes_1,'NextPlot','add','FontSize',theFontSize,'units','normalized');
xlabel('\lambda (nm)')
ylabel('Spectrum (counts)');
grid on

axes_2 = axes('position',[0.55 0.65 0.4 0.36]);
set(axes_2,'NextPlot','add','FontSize',theFontSize,'units','normalized');
xlabel('\lambda (nm)');
ylabel('Target Spectrum (red)');
xlim([680 920]);
ylim([0 1.1]);
grid on

acquireCheckbox = uicontrol('style','checkbox',...
    'units','normalized',...
    'position',[0.01 0.96 0.42 0.04],...
    'string','acquire     Integration Time (ms):',...
    'callback',@acquireCallBack,...
    'Value',1,...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);


integrationTime_edit  = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.3 0.96 0.10 0.03],...
    'callback',@integrationTimeCallback,...
    'String',num2str(integrationTime_ini),...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

saveSpectrum_button  = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.51 0.2 0.03],...
    'callback',@saveSpectrumCallback,...
    'String','Save spectrum',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

loadLastSpectrum_button  = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.48 0.2 0.03],...
    'callback',@loadLastSpectrumCallback,...
    'String','Load last spectrum',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

saveBgd_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.45 0.2 0.03],...
    'callback',@backgroundCallback,...
    'String','Save background',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

setMask_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.42 0.2 0.03],...
    'callback',@setMaskCallback,...
    'String','Set Mask!',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

resetMask_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.39 0.2 0.03],...
    'callback',@resetMaskCallback,...
    'String','Reset Mask!',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);



lambdaCalib_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.54 0.2 0.03],...
    'callback',@lambdaCalibCallback,...
    'String','Lambda Calibration',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

shapeChoice_popup = uicontrol('style','popup',...
    'units','normalized',...
    'String','Homothetic|Gaussian|Triangle|March|SecH|sine|LOB|Import...',...
    'position',[0.01 0.90 0.25 0.04],...
    'BackgroundColor',[1 1 1],...
    'FontSize',theFontSize,...
    'Callback',@chooseShapeFunction);

center_slider = uicontrol('style','slider',...
    'units','normalized',...
    'position',[0.01 0.80 0.4 0.03],...
    'BackgroundColor',[1 1 1],...
    'String','center wavelength');
set( center_slider,'Min',700,'Max',900,'Value',800,'String','0');
centerSlider_listener = addlistener(center_slider,'Action',@chooseShapeFunction);

centerAlign_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.84 0.14 0.04],...
    'callback',@centerAlignCallback,...
    'String','Align Centers',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

annotation('textbox',[0.2 0.84 0.08 0.04],...
    'String','lambda0:','fontsize',theFontSize);

center_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.3 0.84 0.07 0.04],...
    'callback',@centerEditCallback,...
    'String',num2str(get(center_slider,'Value')),...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);


height_slider = uicontrol('style','slider',...
    'units','normalized',...
    'position',[0.01 0.70 0.4 0.03],...
    'BackgroundColor',[1 1 1],...
    'String','maximum amplitude');
set( height_slider,'Min',0,'Max',1,'Value',1,'String','0');
heightSlider_listener = addlistener(height_slider,'Action',@chooseShapeFunction);

amplitude_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.3 0.74 0.07 0.04],...
    'callback',@amplitudeEditCallback,...
    'String',num2str(get(height_slider,'Value')),...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

annotation('textbox',[0.01 0.74 0.2 0.04],...
    'String','amplitude (normalized):','fontsize',theFontSize);

width_slider = uicontrol('style','slider',...
    'units','normalized',...
    'position',[0.01 0.60 .4 0.03],...
    'BackgroundColor',[1 1 1],...
    'String','FWHM (nm)',...
    'Min',0.01,...
    'Max',100,'Value',20);
widthSlider_listener = addlistener(width_slider,'Action',@chooseShapeFunction);

width_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.3 0.64 0.07 0.04],...
    'callback',@widthEditCallback,...
    'String',num2str(get(width_slider,'Value')),...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

annotation('textbox',[0.01 0.64 0.2 0.04],...
    'String','pulse FWHM (nm):','fontsize',theFontSize);

annotation('textbox',[0.01 0.3 0.07 0.04],...
    'String','parameter:','fontsize',12);
parameterChoice_popup = uicontrol('style','popup',...
    'units','normalized',...
    'String','phi2 (fs²)|phi3 (fs^3)|phi4 (fs^4)|Amplitude',...
    'position',[0.08 0.3 0.09 0.04],...
    'BackgroundColor',[1 1 1],...
    'FontSize',theFontSize);
inOut_popup = uicontrol('style','popup',...
    'units','normalized',...
    'String','IN|OUT',...
    'position',[0.17 0.3 0.06 0.04],...
    'BackgroundColor',[1 1 1],...
    'FontSize',theFontSize);

annotation('textbox',[0.01 0.25 0.15 0.04],...
    'String','min value:','fontsize',12);
paramMin_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.16 0.25 0.07 0.04],...
    'String',0,...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

annotation('textbox',[0.01 0.2 0.15 0.04],...
    'String','max value:','fontsize',12);
paramMax_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.16 0.2 0.07 0.04],...
    'String',0,...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

annotation('textbox',[0.01 0.15 0.15 0.04],...
    'String','nb of points:','fontsize',12);
nPts_edit = uicontrol('style','edit',...
    'units','normalized',...
    'position',[0.16 0.15 0.07 0.04],...
    'String',40,...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

seriesOfMeasure_button = uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.01 0.06 0.25 0.07],...
    'callback',@seriesOfMeasureCallback,...
    'String','Launch a series of Measures',...
    'BackgroundColor',[1 1 1],...
    'ForegroundColor',[0 0 0],...
    'FontSize',theFontSize);

% period = integrationTime_ini*1E-3;
interfaceTimer=timer('TimerFcn',@timerFunction, 'Period', 0.001,'ExecutionMode','fixedSpacing','busymode','drop');

start(interfaceTimer);

    function chooseShapeFunction(obj,event)
        
        set(center_edit,'String',num2str(get(center_slider,'Value')));
        set(amplitude_edit,'String',num2str(get(height_slider,'Value')));
        set(width_edit,'String',num2str(get(width_slider,'Value')));
        
        lambda0 = str2double(get(center_edit,'String'));
        maxAmp = str2double(get(amplitude_edit,'String'));
        width = str2double(get(width_edit,'String'));
        
        choice = get(shapeChoice_popup,'Value');
        
        omega = 2*pi*C./OriginalLambda;
        omega0 = 2*pi*C/lambda0;
        sigma_w = (2*pi*C/sqr(lambda0))*width;
        
        switch choice
            case 1
                wsp = maxAmp.*OriginalSp;
                event
            case 2
                wsp = maxAmp*exp(-0.5*((omega-omega0)/(sigma_w/sqrt(8*log(2)))).^2);
            case 3
                [minVal minIndx] = min( abs( lambda-lambda0));
                slope1 = maxAmp*(lambda-lambda0)/width+maxAmp;
                slope2 = -maxAmp*(lambda-lambda0)/width+maxAmp;
                wsp = slope2;
                wsp(1:minIndx)=slope1(1:minIndx);
                wsp(wsp<0)=0;
            case 4
                wsp = maxAmp*ones(size(omega));
                wsp(omega<omega0-sigma_w/2 | omega>omega0+sigma_w/2)=0;
            case 5
                wsp = maxAmp.*sech((omega-omega0).*2.633/sigma_w);
            case 6
                mean = smooth(OriginalSp);
                wsp = maxAmp*mean.*(1+cos((omega-omega0)*2*pi/sigma_w*2))/2;
                %                 tau=.05;
                %                 ww = 2*pi*3e5./pixel2lambda(1:1024);
                %                 R=abs( cos(ww*tau/2));
                %                 R = interp1( pixel2lambda(1:1024), R, OriginalLambda,'spline',0);
                %
                %                 wsp = OriginalSp.*R;
                
            case 7
                data2 = load('./data/lob.mat');
                wsp = 2.5*maxAmp*interp1(data2.lambda, .55*data2.lob, (lambda-lambda0)/width*50 + 800,'linear',0);
            case 8
                if isempty(importedSpectrum)
                    [importedFileName, importPath, filterIndex] = uigetfile('*.mat', 'Import target spectrum');
                    importedSpectrum = load([importPath importedFileName]);
                end
                wsp = interp1(importedSpectrum.lambda, importedSpectrum.laserSpectrum, OriginalLambda,'linear',0);
                wsp =maxAmp*wsp/max(wsp);
                
                
                
        end
        
        if choice ~= 8
            importedSpectrum=[];
        end
        
        cla( axes_2 )
        plot(axes_2,OriginalLambda,OriginalSp,'b')
        plot(axes_2,OriginalLambda,wsp,'r');
        
    end

    function centerAlignCallback(obj,event)
        [maxVal indx] = max(OriginalSp);
        set(center_slider,'Value',lambda(indx));
        chooseShapeFunction(obj,event);
    end

    function centerEditCallback(obj,event)
        set(center_slider,'Value',str2double(get(center_edit,'String')));
        chooseShapeFunction(obj,event)
    end

    function amplitudeEditCallback(obj,event)
        set(height_slider,'Value',str2double(get(amplitude_edit,'String')));
        chooseShapeFunction(obj,event)
    end

    function widthEditCallback(obj,event)
        set(width_slider,'Value',str2double(get(width_edit,'String')));
        chooseShapeFunction(obj,event)
    end

    function lambdaCalibCallback(obj,event)
        
        stop(interfaceTimer);
        shaperCalib();
        start(interfaceTimer);
        
    end

    function eta = setMaskCallback(obj,event,phiArray)
        
        if nargin==2
            phiArray = [0 0 0];
        end
        
        isAlreadyStopped = strcmp(get(interfaceTimer,'Running'),'off');
        
        if ~isAlreadyStopped
            stop(interfaceTimer);
        end
        
        etas = [];
        OriginalLambda = lambda;
        M = max(OriginalSp_);
        wsp_ = wsp*M;
        nIter = 6;
        
        for k = 1:nIter
            
            if k==1
                etas_ = (wsp./OriginalSp).';
                etas = [etas; etas_];
            else
                
                spectrum_ = getSpectroSpectrum(currentSpectro) - backgroundSpectrum;
                a=wsp*max(OriginalSp_);
                b=  sum(wsp*max(OriginalSp_));
                
                etas_ = (wsp_./spectrum_).';
                etas = [etas; etas_];
                
                if ~isAlreadyStopped
                    cla( axes_1 )
                    plot(axes_1,lambda,spectrum_,'b','linewidth',2);
                    drawnow();
                    plot(axes_1,lambda,wsp*max(OriginalSp_),'Color','r','LineWidth',1);
                    drawnow();
                end
            end
            
            eta = prod(etas,1);
            amplitude = etaToAmplitude(eta);
            
            desertEagle_data.phi2 = phiArray(1);
            desertEagle_data.phi3 = phiArray(2);
            desertEagle_data.phi4 = phiArray(3);
            desertEagle_data.lambda = OriginalLambda;
            desertEagle_data.amplitude = amplitude;
            
            setShaperMask('desertEagle',desertEagle_data);
            
        end
        
        
        save('./data/lastAmplitudeMask','eta','amplitude','lambda');
        
        if ~isAlreadyStopped
            start(interfaceTimer);
        end
    end

    function resetMaskCallback(obj,event)
        
        amplitude = ones (size(OriginalSp));
        desertEagle_data.phi2 = 0;
        desertEagle_data.phi3 = 0;
        desertEagle_data.phi4 = 0;
        desertEagle_data.lambda = lambda;
        desertEagle_data.amplitude = amplitude;
        setShaperMask('desertEagle',desertEagle_data);
        
    end

    function amp = etaToAmplitude(eta)
        
        %         eta = wsp./OriginalSp;
        
        % experimental approach
        %         amp =efficiencyToAmplitude(OriginalLambda, eta);
        
        %analytical approach
        eta( eta >1) = 1;
        eta(eta<0)=0;
        p=[9189.88587472041,-51340.2183713262,124823.639707435,-173242.529734840,151328.697077311,-86520.7399530146,32648.9194674696,-8016.10308545053,1236.76487864184,-114.220338971385,6.86529283001660,0.0255219306070911;];
        amp = polyval(p,eta);
    end

    function choice = val2string_inPopup(popupName,val)
        
        if strcmp(popupName,'shapeChoice_popup')
            switch val
                case 1
                    choice = 'homothetic';
                case 2
                    choice = 'gaussian';
                case 3
                    choice = 'triangle';
                case 4
                    choice = 'march';
                case 5
                    choice = 'secH';
                case 6
                    choice = 'sine';
                case 7
                    choice = 'LOB';
            end
        elseif strcmp(popupName,'parameterChoice_popup')
            switch val
                case 1
                    choice = 'phi2var';
                case 2
                    choice = 'phi3var';
                case 3
                    choice = 'phi4var';
                case 4
                    choice = 'AmaxVar';
            end
        end
    end

    function seriesOfMeasureCallback(obj,event)
        
        if strcmp(get(paramMin_edit,'String'),'0')&&strcmp(get(paramMax_edit,'String'),'0')
            input('error: your parameter space is empty. Press enter to continue ');
            figure(1000)
        else
            
            %             cla( axes_2 )
            %             set(axes_1,'nextPlot','replaceChildren');
            %             set(axes_2,'nextPlot','add');
            
            stop(interfaceTimer);
            
            lambda0 = str2double(get(center_edit,'String'));
            maxAmp = str2double(get(amplitude_edit,'String'));
            width = str2double(get(width_edit,'String'));
            
            choice = get(parameterChoice_popup,'Value');
            minVal = str2double(get(paramMin_edit,'String'));
            maxVal = str2double(get(paramMax_edit,'String'));
            nPoints = str2double(get(nPts_edit,'String'));
            parameterArray = linspace(minVal,maxVal,nPoints)
            
            %%%%%%% Recording the background spectrum %%%%%%%%%%%%%
            input('block the beam then press enter key');
            lambda = getSpectroWavelengths(currentSpectro);
            spBackGd = getSpectroSpectrum(currentSpectro);
            input('now you can release the beam, jackass');
            
            figure(1000);
            
            spectra = zeros(nPoints,length(lambda));
            spectra_ref = zeros(nPoints,length(lambda));
            wSpectra = [];
            amplitudeMatrix = zeros(nPoints,length(lambda));
            
            type = val2string_inPopup('shapeChoice_popup',get(shapeChoice_popup,'Value'));
            zde = val2string_inPopup('parameterChoice_popup',get(parameterChoice_popup,'Value'));
            if get(inOut_popup,'Value')==1
                yop = 'IN';
            else
                yop = 'OUT';
            end
            filename = [type '_' num2str(round(width)) '_' zde '_' yop];
            
            switch choice
                
                case 1   %phi2
                    
                    desertEagle_data.phi3=0;
                    desertEagle_data.phi4=0;
                    
                    if get(inOut_popup,'Value')==2
                        if get(shapeChoice_popup,'Value')>1  %if the shape chosen is not simply "homothetic"
                            dataPhi2 = load(['./data/' todaysDate '/' type '_' num2str(round(width)) '_' zde '_IN']);
                            parameterArray = dataPhi2.parameterArray;
                            amplitudeMatrix = dataPhi2.amplitudeMatrix;
                            nPoints = length(dataPhi2.parameterArray);
                            set(nPts_edit,'String', num2str(nPoints));
                            OriginalLambda= dataPhi2.lambda;
                            amplitudeMatrix = dataPhi2.amplitudeMatrix;
                            spectra_ref = dataPhi2.spectra;
                        end
                    end
                    
                    wSpectra = wsp;
                    
                    for k=1:nPoints
                        
                        if get(inOut_popup,'Value')==1  %for the "IN" measures
                            desertEagle_data.amplitude = ones (size(OriginalSp));
                            desertEagle_data.phi2 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            
                            spectra_ref(k,:) = getSpectroSpectrum(currentSpectro);
                            OriginalLambda = lambda;
                            
                            phiArray = [parameterArray(k) 0 0];
                            OriginalSp_ = spectra_ref(k,:).';
                            OriginalSp = OriginalSp_/max(OriginalSp_);
                            
                            eta = setMaskCallback(obj,event,phiArray);
                            amplitudeMatrix(k,:) = etaToAmplitude(eta);
                            
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi2= ' num2str(parameterArray(k))]);
                            drawnow();
                            
                        else            %for the "OUT" measures
                            
                            if get(shapeChoice_popup,'Value')==1  %if the shape chosen is "homothetic" (ie for full spectrum measures)
                                amplitudeMatrix(k,:) = ones(size(OriginalLambda));
                            end
                            desertEagle_data.amplitude = amplitudeMatrix(k,:);
                            desertEagle_data.phi2 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi2= ' num2str(parameterArray(k))]);
                            drawnow();
                        end
                    end
                    
                    
                case 2   %phi3
                    desertEagle_data.phi2=0;
                    desertEagle_data.phi4=0;
                    
                    if get(inOut_popup,'Value')==2
                        if get(shapeChoice_popup,'Value')>1  %if the shape chosen is not simply "homothetic"
                            dataPhi3 = load(['./data/' todaysDate '/' type '_' num2str(round(width)) '_' zde '_IN']);
                            parameterArray = dataPhi3.parameterArray;
                            amplitudeMatrix = dataPhi3.amplitudeMatrix;
                            nPoints = length(dataPhi3.parameterArray);
                            set(nPts_edit,'String', num2str(nPoints));
                            spectra_ref = dataPhi3.spectra_ref;
                            OriginalLambda= dataPhi3.lambda;
                        end
                    end
                    
                    wSpectra = wsp;
                    
                    for k=1:nPoints
                        
                        if get(inOut_popup,'Value')==1  %for the "IN" measures
                            desertEagle_data.amplitude = ones (size(OriginalSp));
                            desertEagle_data.phi3 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            
                            spectra_ref(k,:) = getSpectroSpectrum(currentSpectro);
                            OriginalLambda = lambda;
                            
                            phiArray = [parameterArray(k) 0 0];
                            OriginalSp_ = spectra_ref(k,:).';
                            OriginalSp = OriginalSp_/max(OriginalSp_);
                            
                            eta = setMaskCallback(obj,event,phiArray);
                            amplitudeMatrix(k,:) = etaToAmplitude(eta);
                            
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi3= ' num2str(parameterArray(k))]);
                            drawnow();
                            
                        else            %for the "OUT" measures
                            
                            if get(shapeChoice_popup,'Value')==1  %if the shape chosen is "homothetic" (ie for full spectrum measures)
                                amplitudeMatrix(k,:) = ones(size(OriginalLambda));
                            end
                            desertEagle_data.amplitude = amplitudeMatrix(k,:);
                            desertEagle_data.phi3 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi3= ' num2str(parameterArray(k))]);
                            drawnow();
                        end
                    end
                    
                    
                case 3   %phi4
                    
                    desertEagle_data.phi2=0;
                    desertEagle_data.phi3=0;
                    
                    if get(inOut_popup,'Value')==2
                        if get(shapeChoice_popup,'Value')>1  %if the shape chosen is not simply "homothetic"
                            dataPhi4 = load(['./data/' todaysDate '/' type '_' num2str(round(width)) '_' zde '_IN']);
                            parameterArray = dataPhi4.parameterArray;
                            amplitudeMatrix = dataPhi4.amplitudeMatrix;
                            nPoints = length(dataPhi4.parameterArray);
                            set(nPts_edit,'String', num2str(nPoints));
                            spectra_ref = dataPhi4.spectra_ref;
                            OriginalLambda= dataPhi4.lambda;
                        end
                    end
                    
                    wSpectra = wsp;
                    
                    for k=1:nPoints
                        
                        if get(inOut_popup,'Value')==1  %for the "IN" measures
                            desertEagle_data.amplitude = ones (size(OriginalSp));
                            desertEagle_data.phi4 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            
                            spectra_ref(k,:) = getSpectroSpectrum(currentSpectro);
                            OriginalLambda = lambda;
                            
                            phiArray = [parameterArray(k) 0 0];
                            OriginalSp_ = spectra_ref(k,:).';
                            OriginalSp = OriginalSp_/max(OriginalSp_);
                            
                            eta = setMaskCallback(obj,event,phiArray);
                            amplitudeMatrix(k,:) = etaToAmplitude(eta);
                            
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi4= ' num2str(parameterArray(k))]);
                            drawnow();
                            
                        else            %for the "OUT" measures
                            
                            if get(shapeChoice_popup,'Value')==1  %if the shape chosen is "homothetic" (ie for full spectrum measures)
                                amplitudeMatrix(k,:) = ones(size(OriginalLambda));
                            end
                            desertEagle_data.amplitude = amplitudeMatrix(k,:);
                            desertEagle_data.phi4 = parameterArray(k);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['phi4= ' num2str(parameterArray(k))]);
                            drawnow();
                        end
                    end
                    
                    
                case 4   %Amax
                    
                    desertEagle_data.phi2=0;
                    desertEagle_data.phi3=0;
                    desertEagle_data.phi4=0;
                    
                    if get(inOut_popup,'Value')==2
                        if get(shapeChoice_popup,'Value')>1  %if the shape chosen is not simply "homothetic"
                            dataAmp = load(['./data/' todaysDate '/' type '_' num2str(round(width)) '_' zde '_IN']);
                            parameterArray = dataAmp.parameterArray;
                            amplitudeMatrix = dataAmp.amplitudeMatrix;
                            spectra_ref = dataAmp.spectra;
                            nPoints = length(dataAmp.parameterArray);
                            set(nPts_edit,'String', num2str(nPoints));
                            spectra_ref = dataAmp.spectra_ref;
                            OriginalLambda= dataAmp.lambda;
                        end
                    end
                    
                    wSpectra = zeros(nPoints,length(lambda));
                    
                    for k=1:nPoints
                        
                        
                        if get(inOut_popup,'Value')==1  %for the "IN" measures
                            desertEagle_data.amplitude = ones (size(OriginalSp));
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            
                            chooseShapeFunction(obj,event);
                            
                            spectra_ref(k,:) = getSpectroSpectrum(currentSpectro);
                            OriginalLambda = lambda;
                            
                            phiArray = [0 0 0];
                            OriginalSp_ = spectra_ref(k,:).';
                            OriginalSp = OriginalSp_/max(OriginalSp_);
                            wsp = parameterArray(k).*wsp;
                            
                            eta = setMaskCallback(obj,event,phiArray);
                            amplitudeMatrix(k,:) = etaToAmplitude(eta);
                            
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['max Amplitude= ' num2str(parameterArray(k))]);
                            drawnow();
                            
                        else            %for the "OUT" measures
                            
                            if get(shapeChoice_popup,'Value')==1  %if the shape chosen is "homothetic" (ie for full spectrum measures)
                                amplitudeMatrix(k,:) = parameterArray(k).*ones(size(OriginalLambda));
                            end
                            desertEagle_data.amplitude = amplitudeMatrix(k,:);
                            desertEagle_data.lambda = lambda;
                            setShaperMask('desertEagle',desertEagle_data);
                            spectra(k,:) = getSpectroSpectrum(currentSpectro);
                            
                            cla(axes_1);
                            plot(axes_1,lambda,spectra(k,:),'b',OriginalLambda,spectra_ref(k,:),'r');
                            title(['max Amplitude= ' num2str(parameterArray(k))]);
                            drawnow();
                        end
                    end
                    
                    
            end
            
            save(['./data/' todaysDate '/' filename],'lambda0','maxAmp','width','parameterArray','OriginalLambda','wSpectra','lambda','spectra','spectra_ref','spBackGd','amplitudeMatrix');
            
            start(interfaceTimer);
        end
        
    end

    function timerFunction(obj,event)
        
        spectrum= getSpectroSpectrum(currentSpectro)-backgroundSpectrum;
        
        %         power = round(sum(spectrum).*1e-3);
        
        cla( axes_1 )
        plot(axes_1, lambda,spectrum,'Color',[0 0 0]/255,'LineWidth',2);
        if mean(wsp) ~=0
            plot(axes_1,lambda,wsp*max(OriginalSp_),'Color','r','LineWidth',1);
        end
        %         title(axes_1,num2str(power));
    end

    function acquireCallBack(obj,event)
        
        if get(gcbo,'Value') == 1
            start(interfaceTimer);
        else
            stop(interfaceTimer);
        end
    end

    function integrationTimeCallback(obj,event)
        integrationTime=str2double(get(integrationTime_edit,'String'));
        integrationTime = setSpectroIntegrationTime(integrationTime,currentSpectro);
        set(integrationTime_edit,'String',num2str(integrationTime));
        
        stop(interfaceTimer)
        interfaceTimer.Period = integrationTime*1E-3; %in sec
        start(interfaceTimer)
    end

    function saveSpectrumCallback(obj,event)
        
        makeTodaysDirectory;
        todayDate=datestr(now,'yyyymmdd');
        laserSpectrum=spectrum;
        
        % eval(['save ./data/10-06-2010/20nm/05mW laserSpectrum lambda']);
        % save ../data/10-06-2010/20nm/05mW laserSpectrum lambda
        
        uisave( {'laserSpectrum', 'lambda'}, ['./data/' todaysDate '/lastLaserSpectrum.mat']);
        'laserSpectrum saved !'
    end

    function loadLastSpectrumCallback(obj,event)
        
        reference = load('./data/lastLaserSpectrum.mat');
        OriginalSp_ = reference.laserSpectrum;
        OriginalSp = OriginalSp_/max(OriginalSp_);
        OriginalLambda = lambda;
        [maxVal indx] = max(OriginalSp);
        
    end

    function backgroundCallback(obj,event)
        
        if norm(backgroundSpectrum) == 0
            backgroundSpectrum = spectrum;
            set(saveBgd_button,'String','Reset background');
            
        else
            backgroundSpectrum = 0;
            set(saveBgd_button,'String','Save background')
            
        end
    end

    function closeInterface(obj,event)
        
        stop(interfaceTimer);
        closeSpectro
        delete(obj)
        clear obj
    end

end