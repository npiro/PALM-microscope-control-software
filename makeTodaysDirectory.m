function makeTodaysDirectory()

todaysDate = datestr(now,'yyyy-mm-dd');
folder = strcat('Z:\LEB\shared\NicolasPiro\mesures\',todaysDate);

if ~isdir(folder)
    mkdir(folder);
end

end