function varargout = insertWire(model, contourdata, icN, newsel, linetype, whichsel)
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

if ~exist('linetype','var') || isempty(linetype)
  linetype='ic';
end

if ~exist('whichsel','var') || isempty(whichsel)
  whichsel='csel1';
end

% First identify wires in model and find an adjacent index.
geonode = model.component('comp1').geom('geom1');

if searching
    objectlabels = char(geonode.feature.tags);
end

wireN = icN;
varargout{1} = icN;

while searching
   if any(ismember(objectlabels,[linetype num2str(wireN)],'rows'))
       wireN = wireN + 1;
   else
       searching = false;
   end
end

% Now add new wire
% check to see if selection group exists yet

if strcmp(linetype,'ic')
    geonode.feature.create(['ic' num2str(wireN)], 'InterpolationCurve').set('source', 'table').set('table', contourdata').set('rtol', 0).set('type', 'open');
else
    geonode.feature.create(['pol' num2str(wireN)], 'Polygon').set('source', 'table').set('table', contourdata');
end
    
if newsel
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

if strcmp(linetype,'ic')
    geonode.feature(['ic' num2str(wireN)]).set('contributeto', whichsel);
else
    geonode.feature(['pol' num2str(wireN)]).set('contributeto', whichsel);
end
end
