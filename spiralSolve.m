function couplings = spiralSolve(Vms,faceassign, resolution, basisfunctions, bubble, maxl)
% couplings = spiralSolve(Vms,faceassign, resolution, basisfunctions, bubble, maxl)
%{
Given a pair of scalar potentials (in Vms) and an assignment array of which Vms
should be used for each resulting face (faceassign), generate coils for a single
constant spiral, calculates strength of interaction of resulting field on
central region. Returns vector of couplings for eachSigma.

Vms = {'z+0.1*atan2(x,y)/(2*pi)','z+0.1*atan2(y,-x)/(2*pi)-0.025'};
faceassign = {[3,4,5],[2]};

Austin Reid 2021.02.13
%}

import com.comsol.model.*
import com.comsol.model.util.*

if ~exist('maxl','var') || isempty(maxl)
  maxl=10;
end

tic
%One time setup:
ModelUtil.clear;
model = ScalarBasis;
sourcecell = loadMagneticBasis(model,'Vm2', maxl, basisfunctions, bubble);

ModelUtil.showProgress(true);

cleanupWires(model,'pol')
cleanupWires(model,'ic')

holedata = holeStructure;

t = toc;
disp(['Setup took ' num2str(round(t)) ' s'])

% remove all the edge currents and their associated MF interface, add new
% wires and (same) MF interface.

nfaces = length(faceassign{1})+length(faceassign{2});
facedata = cell(nfaces,1);
newfacedata = cell(nfaces,1);
facecount = [0,length(faceassign{1})];

for Vmi = 1:2
    targetfaces = faceassign{Vmi};
    Vm = Vms{Vmi};
    disp(['Working on Vm = ' Vm])

    cleanupWires(model,'ic')

    shiftCoilShell(model, '2.4')
    loadScalarPotential(model, Vm, 12);

    meshThenSolve(model, 1)

    disp(['Working on Vm = ' Vm ' wires'])
    tempface = planeContour(model,targetfaces,[0,0,0],resolution,false,false,false,'Vm');
    
    for i=1:length(targetfaces)
        facedata{i+facecount(Vmi)} = tempface{i};
    end
end

% Resample facedata
disp('Resampling wires')
newfacedata = splitResampleContours(facedata, holedata, [0.012,0.001], 'spline');

% Add new wires and (same) MF interface.
disp('Adding wires to model')
insertContours(model,newfacedata)
shiftCoilShell(model, '2.3')

energizeContours(model,'csel1',1,1)

meshThenSolve(model, 2)

% Extract tabular response data
model.result.numerical('int1').set('table','tbl2');
model.result.numerical('int1').setResult;
intersection = mphtable(model,'tbl2');
intdata = intersection.data;
if length(intdata)~=length(sourcecell)
    warning('about to have a bad time.')
end
couplings = intersection.data;
save('sigmalmIntersection','couplings');
sigmafile = 'ScalarBasisVmDirect.mph';
mphsave(model,sigmafile)

disp([Vm ' took ' num2str(round(toc)) 'seconds'])
end

function shiftCoilShell(model, ell)
model.param.set('coil_shell', ell, 'Mumetal is 2.5, so this is *inside*');
model.component('comp1').geom('geom1').run('fin');
end

function meshThenSolve(model, index)
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