function cleanupWires(model)

searching=true;
wireN = 1;
geonode = model.component('comp1').geom('geom1');
objectlabels = char(geonode.feature.tags);

while searching
   if any(ismember(objectlabels,['ic' num2str(wireN)],'rows'))
       geonode.feature.remove(['ic' num2str(wireN)]);
       wireN = wireN + 1;
   else
       searching = false;
   end
end
model.component('comp1').geom('geom1').run;
try
model.component('comp1').physics('mf').feature.remove('edc1');
end
end