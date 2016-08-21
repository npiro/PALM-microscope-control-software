function argtest(arg1,arg2,varargin)

varargin

for k=1:size(varargin,2)
    if isscalar(varargin{k})
        fprintf('%d is a number\n',varargin{k});
    elseif ischar(varargin{k})
        fprintf('%s is a string\n',varargin{k});
    end
end