%% Spiral Tester
couplings = spiralSolve({[2,5,7],[3]},.1, [], [], 3);

%%
% Get the models currently open on server:
open_models = ModelUtil.tags();

% re-connect model on server to Matlab command prompt
model = ModelUtil.model('Model');

%% Evaluate along grid
x0 = 0;
y0 = -0.24:0.02:0.24;
z0 = -0.16:0.02:0.16;

[x,y,z] = meshgrid(x0, y0, z0);
[py,pz] = meshgrid(y0,z0);

xx = [x(:),y(:),z(:)]';
pp = [py(:),pz(:)]';

bX = mphinterp(model,'mf.Bx','coord',xx,'dataset','dset3');
bY = mphinterp(model,'mf.By','coord',xx,'dataset','dset3');
bZ = mphinterp(model,'mf.Bz','coord',xx,'dataset','dset3');

rect_bZ = reshape(bZ,[length(z0),length(y0)]);
