function insertContours(model,facedata,selname, selflag, linetype)
% function insertContours(model,facedata)
% 
% Takes contours contained in 'facedata' and inserts them with insertWire()
% to 'model', grouping them by 'selname'
% ARR 2020.06.16

if ~exist('facedata','var') || isempty(facedata)
    disp('No contour data supplied. Calculating contours with default settings')
    facedata = plane_contour(model, 'sel',[],[0,0,0],10,true);
end

if ~exist('selname','var') || isempty(selname)
%     disp('No selection set specified. Assigning wires to "windings"')
    selname = 'windings';
end

if ~exist('selflag','var') || isempty(selflag)
    selflag = false;
end

if ~exist('linetype','var') || isempty(linetype)
  linetype='ic';
end

model.param.set('coil_shell', '2.3', 'Wires go at 2.4');

geonode = model.component('comp1').geom('geom1');


% First identify wires in model and find an adjacent index.
geonode = model.component('comp1').geom('geom1');

objectlabels = char(geonode.feature.tags);
searching=true;
wireN = 1;

while searching
   if any(ismember(objectlabels,[linetype num2str(wireN)],'rows'))
       wireN = wireN + 1;
   else
       searching = false;
   end
end

faces = length(facedata);

for i=1:faces
    M = facedata{i}{4};
    levels = length(facedata{i}{5});
    for j = 1:levels
        isowires = length(facedata{i}{5}{j});
        for k = 1:isowires
           contourdata = affineRestore(facedata{i}{5}{j}{k}(1,:),facedata{i}{5}{j}{k}(2,:),M);
           selfN = insertWire(model, contourdata, wireN, selflag, linetype);
           selflag = false;
           if selfN ~= wireN
               warning("Winding numbers disagree")
           end
           wireN = wireN + 1;
        end
    end
end

% disp('Importing Windings');
% selName = 'windings';
% icname = 'autogenWire';
% 
% labels = geonode.feature.tags;
% 
% alreadysetup = false;
% for i=1:length(labels)
%     if strcmp(char(labels(i)),icname)
%         alreadysetup=true;
%     end
% end
% 
% if ~alreadysetup
%     disp('First time through. Will generate selection.')
%     geonode.selection.create(selName, 'CumulativeSelection');
%     geonode.selection(selName).label('wires');
% 
%     geonode.create(icname, 'InterpolationCurve');
%     geonode.feature(icname).set('contributeto', selName);
%     geonode.feature(icname).set('source', 'file');
%     geonode.feature(icname).set('filename', pathtosectionwise);
%     geonode.feature(icname).set('struct', 'sectionwise');
%     geonode.feature(icname).set('rtol', 0.001);    
% else
%     disp('Reusing selection. Modifying sectionwise file path and rebuilding.')
%     geonode.feature(icname).set('filename',pathtosectionwise);
% end

geonode.run;
geonode.run('fin');

end

% for i=1:length(facedata)
% %     facedata{i} = {x,y,Vm,M,contours};
%     M = facedata{i}{4};
%     contours = facedata{i}{5};
%     for j = 1:length(contours)
%         for k=1:length(contours{j})
%         twocurve = contours{j}{k};
%         threecurve = affineRestore(twocurve(1,:),twocurve(2,:),M);
%         model.geom('geom1').feature.create(['ic' num2str(i) 'n' num2str(j) 'n' num2str(k)], 'InterpolationCurve').set('source', 'table').set('table', threecurve').set('rtol', 0.0001).set('contributeto', selName).set('type', 'open');
%         end
%     end
% end
% end
% 
