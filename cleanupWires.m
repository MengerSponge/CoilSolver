function cleanupWires(model,linetype)
% function cleanupWires(model, linetype)
%
% Look for a wire labeled #1. Remove it. Increment counter, and look for the
% next wire. Continue process until the next sequentially numbered wire doesn't
% exist. As long as the wires were inserted programatically, this will find all
% of the inserted wires.
% 
% ARR 2020.07.17

if ~exist('linetype','var') || isempty(linetype)
    linetype = 'ic';
end

searching=true;
wireN = 1;
geonode = model.component('comp1').geom('geom1');
objectlabels = char(geonode.feature.tags);

while searching
   if any(ismember(objectlabels,[linetype num2str(wireN)],'rows'))
       geonode.feature.remove([linetype num2str(wireN)]);
       wireN = wireN + 1;
   else
       searching = false;
   end
end

end
