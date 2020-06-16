function wireN = insertWire(model, contourdata, selname, icN)
% function insertWires(model, wiredata, tag)
% 
% Adds wires contained in wiredata to model, identified with 'tag'. If user
% doesn't specify an index for the interpolation curve 'icN', function
% searches for next available index and assigns that to wire.
% ARR 2020.06.16

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

while searching
   if any(ismember(objectlabels,['ic' num2str(wireN)],'rows'))
       wireN = wireN + 1;
   else
       searching = false;
   end
end

% Now add new wire

geonode.feature.create(['ic' num2str(wireN)], 'InterpolationCurve').set('source', 'table').set('table', contourdata').set('rtol', 0.001).set('contributeto', selname).set('type', 'open');


end