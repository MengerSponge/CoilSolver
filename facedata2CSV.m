function facedata2CSV(facedata,targetfile)
%FACEDATATOCSV success = facedataToCSV(facedata,targetfile)
%   Takes facedata and generates a csv file. This file might be large, but
%   it will be reasonably easy to handle in Python.
%   File format:
% face_index, vm_level, vm_index, (x1 y1 z1), (x2 y2 z2), ...
%
% ARR 2021.03.28

faces = length(facedata);

wirefile = fopen(targetfile,'w');

for i = 1:faces
    disp(['Working on face ' num2str(i)])
    face_index = num2str(i);
    M = facedata{i}{4};
    levels = length(facedata{i}{5});
    for j = 1:levels
        vm_level = num2str(j);
        isowires = length(facedata{i}{5}{j});
        for k = 1:isowires
            vm_index = num2str(k);
            contourdata = affineRestore(facedata{i}{5}{j}{k}(1,:),facedata{i}{5}{j}{k}(2,:),M);
            logwire(wirefile, face_index, vm_level, vm_index, contourdata);
        end
    end
end
fclose(wirefile);

end

function logwire(wirefile, face_index, vm_level, vm_index, contourdata)
[~,n] = size(contourdata);
if n>1
    fprintf(wirefile,[face_index ',' vm_level ',' vm_index '\n']);
    for i=1:(n-1)
        fprintf(wirefile,'(%f %f %f),',contourdata(:,i));
    end
    fprintf(wirefile,'(%f %f %f)\n',contourdata(:,n));
end
end
