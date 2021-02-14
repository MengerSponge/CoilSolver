function sourcecell = loadMagneticBasis(model,Vm, maxl, basisfunctions, bubble)
% sourcecell = loadMagneticBasis(model,Vm, maxl, basisfunctions, bubble)
%
% Loads magnetic basis functions from doi:10.1103/PhysRevA.99.042112 to a table
% to project a calculated Vm into components.
%
% ARR 2020-07-20

if ~exist('Vm','var') || isempty(Vm)
  Vm='Vm';
end

if ~exist('maxl','var') || isempty(maxl)
  maxl=10;
end

if ~exist('basisfunctions','var') || isempty(basisfunctions)
  basisfunctions = 'MagneticBasis.txt';
end

if ~exist('bubble','var') || isempty(bubble)
  bubble = '/(0.5[m])^';
end


fid=fopen(basisfunctions);
tline = fgetl(fid);
basisl = cell(0,1);
while ischar(tline)
    basisl{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

source = cell(0,1);
basis = cell(0,1);
emm = cell(0,1);
for l = 1:maxl
    % wrap each harmonic in parens and multiply it by scalar potential
    % divide by r^l
    basis{l,1} = strcat(strcat('(',split(basisl{l}(2:end-1),', ')),[')*' Vm bubble num2str(l)]);
    source{l,1} = split(basisl{l}(2:end-1),', ');
    emstring = cell(1,2*l+1);
    for m = 1:2*l+1
        emstring{m} = ['l=' num2str(l) ' m=' num2str(m-l-1)];
    end
    emm{l,1} = emstring';
end

% Flatten basis*Vm cell array and l,m label cell array
exprcell = vertcat(basis{:});
emmcell = vertcat(emm{:});
sourcecell = vertcat(source{:});

% model.result.numerical.create('int1', 'IntSurface');
% model.result.numerical('int1').selection.named('geom1_csel1_bnd');
% model.result.numerical('int1').set('probetag', 'none');
% 
% model.result.numerical('int1').set('table', 'tbl1');
% model.result.numerical('int1').set('expr', {'Vm*x' 'Vm*y' 'Vm*z' 'Vm*(x*y)'});
% model.result.numerical('int1').set('unit', {'m^3*A' 'm^3*A' 'm^3*A' 'm^4*A'});
% model.result.numerical('int1').set('descr', {'' '' '' ''});
% model.result.numerical('int1').setResult;

% model.result.numerical.create('int1', 'IntSurface');
% model.result.numerical('int1').selection.named('geom1_csel1_bnd');
% model.result.numerical('int1').set('probetag', 'none');

% model.result.numerical('int1').set('table', 'tbl1');

model.result.numerical('int1').set('expr',exprcell');
model.result.numerical('int1').set('descr', emmcell');
model.result.numerical('int1').setResult;

end
% end
