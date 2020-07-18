function couplings = pureSigmaSolve(model_path, maxl, resolution, basisfunctions, bubble)
% couplings = pureSigmaSolve(model, order, basis)
%{
Generates coils for each element of basis up to "order", calculates
strength of interaction of resulting field on central region. Returns
square matrix of couplings for each Sigma.
%}

import com.comsol.model.*
import com.comsol.model.util.*


tic
%One time setup:
ModelUtil.clear;
model = mphload(model_path);
sourcecell = loadMagneticBasis(model,'Vm2', maxl, basisfunctions, bubble);

ModelUtil.showProgress(true);

couplings = zeros(length(sourcecell));
cleanupWires(model,'pol')
cleanupWires(model,'ic')

holedata = holeStructure;

t = toc;
disp(['Setup took ' num2str(round(t)) ' s'])

for sigmai = 1:length(sourcecell)
    t=toc;
    % remove all the edge currents and their associated MF interface, add new
    % wires and (same) MF interface.
    
    disp(['Working on Vm_' num2str(sigmai) ' = ' sourcecell{sigmai}])
    
    cleanupWires(model,'ic')
    
    shiftCoilShell('2.4')
    loadScalarPotential(model, sourcecell{sigmai}, 12);
    
    meshThenSolve(1)
    
    disp(['Working on Vm_' num2str(sigmai) ' = ' sourcecell{sigmai} ' wires'])
    facedata = planeContour(model,2:7,[0,0,0],resolution,false,false,false,'Vm');
    
    % Resample facedata
    disp('Resampling wires')
    newfacedata = splitResampleContours(facedata, holedata, [0.012,0.001], 'spline');
    %     newfacedata = resampleContours(facedata,0.009,'spline');
    % Add new wires and (same) MF interface.
    disp('Adding wires to model')
    insertContours(model,newfacedata)
    energizeContours(model,'csel1',1,1)
    
    shiftCoilShell('2.3')
    meshThenSolve(2)
    
    % Extract tabular response data
    model.result.numerical('int1').set('table','tbl2');
    model.result.numerical('int1').setResult;
    intersection = mphtable(model,'tbl2');
    intdata = intersection.data;
    if length(intdata)~=length(sourcecell)
        warning('about to have a bad time.')
    end
    couplings(sigmai,:)=intersection.data;
    save('sigmalmIntersection','couplings');
    disp(['Finished a loop in ' num2str(toc-t)])
    sigmafile = [model_path(1:end-4) num2str(sigmai) '.mph'];
    mphsave(model,sigmafile)
end
disp(['Full Basis took ' num2str(round(toc)) 'seconds'])
end

function shiftCoilShell(ell)
model.param.set('coil_shell', ell, 'Mumetal is 2.5, so this is *inside*');
model.component('comp1').geom('geom1').run('fin');
end

function meshThenSolve(index)
if index==1
    physics = 'MFNC';
else
    physics = 'MF';
end

try
    disp(['Meshing ' physics ' model'])
    model.component('comp1').mesh(['mesh' num2str(index)]).run;
catch
    disp([physics ' meshing failed. Try to fix before continuing!'])
    mphlaunch
    disp('Continuing...')
end

try
    disp(['Solving ' physics ' model'])
    model.sol(['sol' num2str(index)]).runAll;
catch
    disp([physics ' solve failed. Try to fix before continuing!'])
    mphlaunch
    disp('Continuing...')
end
end