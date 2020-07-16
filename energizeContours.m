function energizeContours(model,selname,current,coilindex)

if ~exist('selname','var') || isempty(selname)
  selname = 'csel1';
end

if ~exist('current','var') || isempty(current)
  current = 1;
end

if ~exist('coilindex','var') || isempty(coilindex)
  coilindex = 1;
end

coilname = ['edc' num2str(coilindex)];

mfmodel = model.component('comp1').physics('mf');

nodes = mfmodel.feature.tags;

alreadysetup = false;
for i=1:length(nodes)
    if strcmp(char(nodes(i)),coilname)
        alreadysetup=true;
    end
end

if ~alreadysetup
    disp('Energizing edge currents in model')
    mfmodel.create(coilname, 'EdgeCurrent', 1);
else
    disp('Updating edge currents in model')
end

mfmodel.feature(coilname).selection.named(['geom1_' selname '_edg']);
mfmodel.feature(coilname).set('Ie', current);

end
