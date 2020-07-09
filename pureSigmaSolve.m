function couplings = pureSigmaSolve(model_path, maxl, resolution, basisfunctions, bubble)
% couplings = pureSigmaSolve(model, order, basis)
%{
Generates coils for each element of basis up to "order", calculates
strength of interaction of resulting field on central region. Returns
square matrix of couplings for each Sigma.
%}
tic
%One time setup:
model = mphload(model_path);
sourcecell = loadMagneticBasis(model,'Vm2', maxl, basisfunctions, bubble);

couplings = zeros(length(sourcecell));
t = toc;
disp(['Setup took: ' num2str(round(t)) 's'])

for sigmai = 1:length(sourcecell)
    t=toc;
    % remove all the edge currents and their associated MF interface, add new
    % wires and (same) MF interface.

    disp(['Working on Vm_' num2str(sigmai) ' = ' sourcecell{sigmai}])  

    cleanupWires(model)
    model.param.set('coil_shell', '2.4', 'Mumetal is 2.5, so this is *inside*');
    model.component('comp1').geom('geom1').run;

    % assign source Vm and constant patches
    model.component('comp1').physics('mfnc').feature('msp1').set('Vm0', sourcecell{sigmai});
    for i = 1:12
        model.component('comp1').probe(['bnd' num2str(i)]).set('expr', sourcecell{sigmai});
    end

    %
    model.sol('sol1').runAll;

    disp(['Working on Vm_' num2str(sigmai) ' = ' sourcecell{sigmai} ' wires'])
    facedata = planeContour(model,'sel',2:7,[0,0,0],resolution,false,false,false,'Vm');

    % Add new wires and (same) MF interface.
    insertContours(model,facedata)
    energizeContours(model,'csel1',1,1)

    model.sol('sol2').runAll;

    % Extract tabular response data

    intersection = mphtable(model,'tbl2');
    couplings(sigmai,:)=intersection.data;
    save('sigmalmIntersection.mat',couplings);
    disp(['Finished a loop in ' num2str(toc-t)])
    end

    disp(['Full Basis took ' num2str(round(toc)) 'seconds'])
end