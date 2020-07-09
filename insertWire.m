function varargout = insertWire(model, contourdata, icN, newsel)
% function insertWires(model, wiredata, tag)
% 
% Adds wires contained in wiredata to model, identified with 'tag'. If user
% doesn't specify an index for the interpolation curve 'icN', function
% searches for next available index and assigns that to wire.
% ARR 2020.06.16

if ~exist('newsel','var') || isempty(newsel)
  newsel=true;
end


if ~exist('selname','var') || isempty(selname)
  selname='windings';
end

if ~exist('icN','var') || isempty(icN)
  icN=1;
  searching=true;
else
  searching=false;
end

% First identify wires in model and find an adjacent index.
geonode = model.component('comp1').geom('geom1');

if searching
    objectlabels = char(geonode.feature.tags);
end

wireN = icN;
varargout{1} = icN;

while searching
   if any(ismember(objectlabels,['ic' num2str(wireN)],'rows'))
       wireN = wireN + 1;
   else
       searching = false;
   end
end

% Now add new wire
% check to see if selection group exists yet

geonode.feature.create(['ic' num2str(wireN)], 'InterpolationCurve').set('source', 'table').set('table', contourdata').set('rtol', 0.001).set('type', 'open');

if icN==1
try
    geonode.selection.create('csel1', 'CumulativeSelection');
    varargout{2}='csel1';
catch
    warning("Couldn't create cumulative selection 1.")
end
end
try
    model.component('comp1').geom('geom1').selection('csel1').label(selname);
    varargout{3} = selname;
catch
    warning(['csel naming failed: ', selname])
end
% else
%     varargout{2} = [];
%     varargout{3} = [];
% end

geonode.feature(['ic' num2str(wireN)]).set('contributeto', 'csel1');
end