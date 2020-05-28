function data = extractScalarPotentials(model, selection, facecount, evalfunc)
% data = extractScalarPotentials(model, selection, facecount, evalfunc)
%
% Gets point information from model. Defaults to "Vm2-Vm", but this is
% changeable with the optional parameter evalfunc. Returns cell array
% (default 6 elements) of *only* coordinates and evaluated function on
% those coordinates.
% 
% ARR 2020.02.28

if ~exist('facecount','var') || isempty(facecount)
  facecount=6;
end

if ~exist('evalfunc','var') || isempty(evalfunc)
  evalfunc = 'Vm2-Vm';
end

data = {};
for i = 1:facecount
    rawData = mpheval(model, evalfunc, 'Selection',[selection num2str(i)]);
    data{end+1} = rawData.p;
    data{end} = [data{end}; rawData.d1]';
    data{end}(any(isnan(data{end}), 2), :) = [];
end

end