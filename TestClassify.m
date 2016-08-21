profile on;
trials = 100;
for i=1:trials
    ClassifyNoImages('PSF.bmp');
    %waitbar(i/trials,[num2str(100*i/trials),'%']); 
end
profile viewer
p = profile('info');
profsave(p,'profile_results')