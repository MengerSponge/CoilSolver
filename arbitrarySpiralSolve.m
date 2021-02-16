function wiredata = arbitrarySpiralSolve(model,faceassign, spacing, debug)
% couplings = arbitrarySpiralSolve(model,faceassign, spacing)
% 
% Given a meshed model with a mfnc node, a spacing (in m), and an
% assignment array of  which Vms should % be used for each resulting face
% (faceassign), generate coils for a single constant spiral, calculates
% strength of interaction of resulting field on central region. Returns 
% data structure of wires, cleaned and ready to be inserted following an 
% affine restore.
% 
% Vms = {'z+0.1*atan2(x,y)/(2*pi)','z+0.1*atan2(y,-x)/(2*pi)-0.025'};
% faceassign = {[3,4,5],[2]};
% 
% Austin Reid 2021.02.15

if ~exist('debug','var') || isempty(debug)
  debug = false;
end

import com.comsol.model.*
import com.comsol.model.util.*

model.component('comp1').mesh('mesh1').run;
[~, meshdata] = mphmeshstats(model,'mesh1');

zmax = max(meshdata.vertex(3,:));
zmin = min(meshdata.vertex(3,:));

Vm = 'z';

nspacing = round((zmax-zmin)/spacing);

resolution = linspace(zmin,zmax,nspacing);
Vms = {[Vm '+' num2str(spacing) '*atan2(x,y)/(2*pi)'], ...
       [Vm '-' num2str(spacing) '*atan2(x,-y)/(2*pi)-' num2str(spacing/2)]};

tic
%One time setup:

ModelUtil.showProgress(true);

% faceassign is COMSOL indexed. Holestructure is matlab-indexed. Fix the
% off-by-one issue.
faces = (cat(2,faceassign{1},faceassign{2})-1);
holedata = cell(length(faces),1);

t = toc;
disp(['Setup took ' num2str(round(t)) ' s'])

% remove all the edge currents and their associated MF interface, add new
% wires and (same) MF interface.

nfaces = length(faceassign{1})+length(faceassign{2});
facedata = cell(nfaces,1);
facecount = [0,length(faceassign{1})];

for Vmi = 1:2
    targetfaces = faceassign{Vmi};
    Vm = Vms{Vmi};
    disp(['Working on Vm = ' Vm])

    loadScalarPotential(model, Vm, 0); %model, Vm, number of holes to patch

    meshThenSolve(model, 1)

    disp(['Working on Vm = ' Vm ' wires'])
    tempface = planeContour(model,targetfaces,[0,0,0],resolution,false,false,false,'Vm');
    
    for i=1:length(targetfaces)
        facedata{i+facecount(Vmi)} = tempface{i};
    end
end

% Resample facedata
disp('Resampling wires')
wiredata = splitResampleContours(facedata, holedata, [0.002,0.001], 'spline');

% sigmafile = 'Spiral-ScalarBasisVmDirect.mph';
mphsave(model)%,sigmafile)

% disp(['Spiral took ' num2str(round(toc)) 'seconds'])
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