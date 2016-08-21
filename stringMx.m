classdef stringMx
    properties
        content=['';''];
    end
    methods
        function initArray = stringMx(word)
            initArray.content = ['';word];
        end
        function array = append(word)
            if strcmp(array.content[1],'')
                array.content[1] = word;
            elseif strcmp(array.content[end],'')
                array.content[end] = word;
            else
                tab = array.content;
                array.content = [tab;word];
            end
        end
    end
end