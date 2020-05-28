function insertContours(model,pathtosectionwise,facedata)

if ~exist('pathtosectionwise','var') || isempty(pathtosectionwise)
    disp('No sectionwise data supplied. Generating file.')
    if ~exist('facedata','var') || isempty(facedata)
        disp('No contour data supplied. Calculating contours with default settings')
        facedata = plane_contour(model, 'sel',[],[0,0,0],10,true);
    end
    [filepath,~,~] = fileparts(char(model.getFilePath()));
    pathtosectionwise = makeSectionwise(facedata, [], filepath);
end

geonode = model.component('comp1').geom('geom1');

disp('Importing Windings');
selName = 'windings';
icname = 'autogenWire';

labels = geonode.feature.tags;

alreadysetup = false;
for i=1:length(labels)
    if strcmp(char(labels(i)),icname)
        alreadysetup=true;
    end
end

if ~alreadysetup
    disp('First time through. Will generate selection.')
    geonode.selection.create(selName, 'CumulativeSelection');
    geonode.selection(selName).label('wires');

    geonode.create(icname, 'InterpolationCurve');
    geonode.feature(icname).set('contributeto', selName);
    geonode.feature(icname).set('source', 'file');
    geonode.feature(icname).set('filename', pathtosectionwise);
    geonode.feature(icname).set('struct', 'sectionwise');
    geonode.feature(icname).set('rtol', 0.001);    
else
    disp('Reusing selection. Modifying sectionwise file path and rebuilding.')
    geonode.feature(icname).set('filename',pathtosectionwise);
end

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
