function loadScalarPotential(model, Vm, N_probe)
% function loadScalarPotential(model, Vm, N_probe)
%
% Applies scalar potential string Vm to faces and probe domains of model.
% ARR 2020.07.18
%

model.component('comp1').physics('mfnc').feature('msp1').set('Vm0', Vm);
for i = 1:N_probe
    model.component('comp1').probe(['bnd' num2str(i)]).set('expr', Vm);
end

end
