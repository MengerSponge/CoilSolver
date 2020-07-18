function newmodel = ScalarBasis
%
% ScalarBasis.m
%
% Model exported on Jul 16 2020, 15:51 by COMSOL 5.5.0.359.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath(pwd);

model.label('ScalarBasis.mph');

model.param.set('annulus_r', '.325');
model.param.set('annulus_small_r','0.5');
model.param.set('coil_shell', '2.4', 'Mumetal is 2.5, so this is *inside*');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('tbl1', 'Table');
model.result.table.create('tbl2', 'Table');

model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh.create('mesh2');

model.component('comp1').geom('geom1').geomRep('comsol');
model.component('comp1').geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel1').label('windings');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('size', [2.5 2.5 2.5]);
model.component('comp1').geom('geom1').create('sph1', 'Sphere');
model.component('comp1').geom('geom1').feature('sph1').set('r', '.7');
model.component('comp1').geom('geom1').create('sph2', 'Sphere');
model.component('comp1').geom('geom1').feature('sph2').label('World');
model.component('comp1').geom('geom1').feature('sph2').set('r', 4);
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', {'coil_shell' 'coil_shell' 'coil_shell'});
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.component('comp1').geom('geom1').feature('wp1').set('rot', -90);
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').feature('wp1').selection('face').set('blk2(1)', 3);
model.component('comp1').geom('geom1').feature('wp1').geom.create('c1', 'Circle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c1').set('pos', {'.3' '.3'});
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c1').set('r', '.1');
model.component('comp1').geom('geom1').feature('wp1').geom.create('c2', 'Circle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c2').set('pos', {'.3' '.3'});
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c2').set('r', '.1*(1+annulus_r)');
model.component('comp1').geom('geom1').feature('wp1').geom.create('rot1', 'Rotate');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('rot1').set('keep', true);
model.component('comp1').geom('geom1').feature('wp1').geom.feature('rot1').setIndex('rot', '180', 0);
model.component('comp1').geom('geom1').feature('wp1').geom.feature('rot1').selection('input').set({'c1' 'c2'});
model.component('comp1').geom('geom1').feature('wp1').geom.create('c3', 'Circle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c3').set('pos', [1.05 1.05]);
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c3').set('r', '.05');
model.component('comp1').geom('geom1').feature('wp1').geom.create('c4', 'Circle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c4').set('pos', [1.05 1.05]);
model.component('comp1').geom('geom1').feature('wp1').geom.feature('c4').set('r', '.05*(1+annulus_small_r)');
model.component('comp1').geom('geom1').feature('wp1').geom.create('rot2', 'Rotate');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('rot2').set('rot', 'range(0,90,359)');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('rot2').selection('input').set({'c3' 'c4'});
model.component('comp1').geom('geom1').create('mir1', 'Mirror');
model.component('comp1').geom('geom1').feature('mir1').set('keep', true);
model.component('comp1').geom('geom1').feature('mir1').set('axis', [0 1 0]);
model.component('comp1').geom('geom1').feature('mir1').selection('input').set({'wp1'});
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').create('wp2', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp2').set('planetype', 'faceparallel');
model.component('comp1').geom('geom1').feature('wp2').set('rot', -90);
model.component('comp1').geom('geom1').feature('wp2').set('unite', true);
model.component('comp1').geom('geom1').feature('wp2').selection('face').set('blk1(1)', 3);
model.component('comp1').geom('geom1').feature('wp2').geom.create('c1', 'Circle');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('c1').set('pos', {'.3' '.3'});
model.component('comp1').geom('geom1').feature('wp2').geom.feature('c1').set('r', '.1');
model.component('comp1').geom('geom1').feature('wp2').geom.create('rot1', 'Rotate');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('rot1').set('keep', true);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('rot1').setIndex('rot', '180', 0);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('rot1').selection('input').set({'c1'});
model.component('comp1').geom('geom1').feature('wp2').geom.create('c3', 'Circle');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('c3').set('pos', [1.05 1.05]);
model.component('comp1').geom('geom1').feature('wp2').geom.feature('c3').set('r', '.05');
model.component('comp1').geom('geom1').feature('wp2').geom.create('rot2', 'Rotate');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('rot2').set('rot', 'range(0,90,359)');
model.component('comp1').geom('geom1').feature('wp2').geom.feature('rot2').selection('input').set({'c3'});
model.component('comp1').geom('geom1').create('mir2', 'Mirror');
model.component('comp1').geom('geom1').feature('mir2').set('keep', true);
model.component('comp1').geom('geom1').feature('mir2').set('axis', [0 1 0]);
model.component('comp1').geom('geom1').feature('mir2').selection('input').set({'wp2'});
model.component('comp1').geom('geom1').create('pyr1', 'Pyramid');
model.component('comp1').geom('geom1').feature('pyr1').set('pos', [0 0 -1.25]);
model.component('comp1').geom('geom1').feature('pyr1').set('a', 2.5);
model.component('comp1').geom('geom1').feature('pyr1').set('b', 2.5);
model.component('comp1').geom('geom1').feature('pyr1').set('h', 1.25);
model.component('comp1').geom('geom1').feature('pyr1').set('rat', 0);
model.component('comp1').geom('geom1').create('pyr2', 'Pyramid');
model.component('comp1').geom('geom1').feature('pyr2').set('pos', [0 0 1.25]);
model.component('comp1').geom('geom1').feature('pyr2').set('rot', 180);
model.component('comp1').geom('geom1').feature('pyr2').set('axis', [0 0 -1]);
model.component('comp1').geom('geom1').feature('pyr2').set('a', 2.5);
model.component('comp1').geom('geom1').feature('pyr2').set('b', 2.5);
model.component('comp1').geom('geom1').feature('pyr2').set('h', 1.25);
model.component('comp1').geom('geom1').feature('pyr2').set('rat', 0);
model.component('comp1').geom('geom1').create('pyr3', 'Pyramid');
model.component('comp1').geom('geom1').feature('pyr3').set('pos', [-1.25 0 0]);
model.component('comp1').geom('geom1').feature('pyr3').set('axis', [1 0 0]);
model.component('comp1').geom('geom1').feature('pyr3').set('a', 2.5);
model.component('comp1').geom('geom1').feature('pyr3').set('b', 2.5);
model.component('comp1').geom('geom1').feature('pyr3').set('h', 1.25);
model.component('comp1').geom('geom1').feature('pyr3').set('rat', 0);
model.component('comp1').geom('geom1').create('pyr4', 'Pyramid');
model.component('comp1').geom('geom1').feature('pyr4').set('pos', [1.25 0 0]);
model.component('comp1').geom('geom1').feature('pyr4').set('axis', [-1 0 0]);
model.component('comp1').geom('geom1').feature('pyr4').set('a', 2.5);
model.component('comp1').geom('geom1').feature('pyr4').set('b', 2.5);
model.component('comp1').geom('geom1').feature('pyr4').set('h', 1.25);
model.component('comp1').geom('geom1').feature('pyr4').set('rat', 0);
model.component('comp1').geom('geom1').create('cmd1', 'CompositeDomains');
model.component('comp1').geom('geom1').feature('cmd1').set('ignoreadj', false);
model.component('comp1').geom('geom1').feature('cmd1').selection('input').set('fin(1)', [12 13 14 15 16 17]);
model.component('comp1').geom('geom1').create('cmd2', 'CompositeDomains');
model.component('comp1').geom('geom1').feature('cmd2').set('ignoreadj', false);
model.component('comp1').geom('geom1').feature('cmd2').selection('input').set('cmd1(1)', [7 8 9 10 11 13]);
model.component('comp1').geom('geom1').create('ige1', 'IgnoreEdges');
model.component('comp1').geom('geom1').feature('ige1').set('ignorevtx', false);
model.component('comp1').geom('geom1').feature('ige1').selection('input').set('cmd2(1)', [19 22 25 27 98 100 101 103 139 140 141 142 179 182 185 188]);
model.component('comp1').geom('geom1').run;

model.component('comp1').selection.create('sel1', 'Explicit');
model.component('comp1').selection('sel1').geom('geom1', 2);
model.component('comp1').selection('sel1').set([5 7 9 12 15 92]);
model.component('comp1').selection.create('sel2', 'Explicit');
model.component('comp1').selection('sel2').geom('geom1', 2);
model.component('comp1').selection('sel2').set([18]);
model.component('comp1').selection.create('sel3', 'Explicit');
model.component('comp1').selection('sel3').geom('geom1', 2);
model.component('comp1').selection('sel3').set([19 23 24 29 30 47 50 65 68 75 76 81 82]);
model.component('comp1').selection.create('sel4', 'Explicit');
model.component('comp1').selection('sel4').geom('geom1', 2);
model.component('comp1').selection('sel4').set([20]);
model.component('comp1').selection.create('sel5', 'Explicit');
model.component('comp1').selection('sel5').geom('geom1', 2);
model.component('comp1').selection('sel5').set([87]);
model.component('comp1').selection.create('sel6', 'Explicit');
model.component('comp1').selection('sel6').geom('geom1', 2);
model.component('comp1').selection('sel6').set([21]);
model.component('comp1').selection.create('sel7', 'Explicit');
model.component('comp1').selection('sel7').geom('geom1', 2);
model.component('comp1').selection('sel7').set([22 25 26 31 32 48 51 66 69 77 78 83 84]);
model.component('comp1').selection('sel1').label('MuMetal');
model.component('comp1').selection('sel2').label('Coil1');
model.component('comp1').selection('sel3').label('Coil2');
model.component('comp1').selection('sel3').set('groupcontang', true);
model.component('comp1').selection('sel4').label('Coil3');
model.component('comp1').selection('sel5').label('Coil4');
model.component('comp1').selection('sel6').label('Coil5');
model.component('comp1').selection('sel7').label('Coil6');
model.component('comp1').selection('sel7').set('groupcontang', true);

model.component('comp1').view.create('view4', 'geom1');

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').propertyGroup('def').func.create('eta', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('Cp', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('rho', 'Analytic');
model.component('comp1').material('mat1').propertyGroup('def').func.create('k', 'Piecewise');
model.component('comp1').material('mat1').propertyGroup('def').func.create('cs', 'Analytic');
model.component('comp1').material('mat1').propertyGroup('def').func.create('an1', 'Analytic');
model.component('comp1').material('mat1').propertyGroup('def').func.create('an2', 'Analytic');
model.component('comp1').material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.component('comp1').material('mat1').propertyGroup.create('NonlinearModel', 'Nonlinear model');
model.component('comp1').material('mat2').selection.named('sel1');
model.component('comp1').material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');

model.component('comp1').coordSystem.create('ie1', 'InfiniteElement');

model.component('comp1').physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.component('comp1').physics('mfnc').selection.set([7 8]);
model.component('comp1').physics('mfnc').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.component('comp1').physics('mfnc').feature('zsp1').selection.set([97]);
model.component('comp1').physics('mfnc').create('msp1', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp1').selection.set([18 19 20 21 22 87]);
model.component('comp1').physics('mfnc').create('msp14', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp14').selection.set([30]);
model.component('comp1').physics('mfnc').create('msp15', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp15').selection.set([82]);
model.component('comp1').physics('mfnc').create('msp16', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp16').selection.set([29]);
model.component('comp1').physics('mfnc').create('msp17', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp17').selection.set([81]);
model.component('comp1').physics('mfnc').create('msp18', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp18').selection.set([47 50]);
model.component('comp1').physics('mfnc').create('msp19', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp19').selection.set([65 68]);
model.component('comp1').physics('mfnc').create('msp20', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp20').selection.set([32]);
model.component('comp1').physics('mfnc').create('msp21', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp21').selection.set([84]);
model.component('comp1').physics('mfnc').create('msp22', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp22').selection.set([31]);
model.component('comp1').physics('mfnc').create('msp23', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp23').selection.set([83]);
model.component('comp1').physics('mfnc').create('msp24', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp24').selection.set([48 51]);
model.component('comp1').physics('mfnc').create('msp25', 'MagneticScalarPotential', 2);
model.component('comp1').physics('mfnc').feature('msp25').selection.set([66 69]);
model.component('comp1').physics('mfnc').create('mflx2', 'MagneticFluxDensity', 2);
model.component('comp1').physics('mfnc').feature('mflx2').selection.set([23 24 25 26 47 48 65 66 75 76 77 78]);
model.component('comp1').physics.create('mf', 'InductionCurrents', 'geom1');
model.component('comp1').physics('mf').create('ms1', 'MagneticShielding', 2);
model.component('comp1').physics('mf').feature('ms1').selection.named('sel1');
model.component('comp1').physics('mf').create('edc1', 'EdgeCurrent', 1);
model.component('comp1').physics('mf').feature('edc1').selection.named('geom1_csel1_edg');
model.component('comp1').physics.create('mfnc2', 'MagnetostaticsNoCurrents', 'geom1');
model.component('comp1').physics('mfnc2').selection.set([8]);

model.component('comp1').mesh('mesh1').create('edg1', 'Edge');
model.component('comp1').mesh('mesh1').create('fq1', 'FreeQuad');
model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').create('ftri2', 'FreeTri');
model.component('comp1').mesh('mesh1').create('ftet4', 'FreeTet');
model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').create('fq2', 'FreeQuad');
model.component('comp1').mesh('mesh1').create('ftet5', 'FreeTet');
model.component('comp1').mesh('mesh1').create('ftet3', 'FreeTet');
model.component('comp1').mesh('mesh1').create('ftet2', 'FreeTet');
model.component('comp1').mesh('mesh1').create('swe1', 'Sweep');
model.component('comp1').mesh('mesh1').feature('edg1').selection.set([37 38 39 40 41 42 43 44 54 55 58 59 62 63 66 67 99 100 101 102 108 109 112 113 147 148 149 150 156 157 160 161 189 190 191 192 193 194 195 196 206 207 210 211 214 215 218 219]);
model.component('comp1').mesh('mesh1').feature('edg1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('edg1').create('dis1', 'Distribution');
model.component('comp1').mesh('mesh1').feature('fq1').selection.set([18 19 20 21 22 23 24 25 26 47 48 65 66 75 76 77 78 87]);
model.component('comp1').mesh('mesh1').feature('fq1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftri1').selection.set([18 19 20 21 22 23 24 25 26 47 48 65 66 75 76 77 78 87]);
model.component('comp1').mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftri2').selection.set([35 36 37 38 39 40 41 42 43 44 45 46 55 56 57 58 60 61 63 64 71 72 73 74]);
model.component('comp1').mesh('mesh1').feature('ftri2').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet4').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet4').selection.set([8]);
model.component('comp1').mesh('mesh1').feature('ftet4').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet1').selection.set([7 8]);
model.component('comp1').mesh('mesh1').feature('ftet1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('fq2').selection.set([18 19 20 21 22 23 24 25 26 47 48 65 66 75 76 77 78 87]);
model.component('comp1').mesh('mesh1').feature('fq2').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet5').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet5').selection.set([2 3 4 5 6 7 9]);
model.component('comp1').mesh('mesh1').feature('ftet5').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet3').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet2').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet2').selection.set([1]);
model.component('comp1').mesh('mesh1').feature('ftet2').create('size1', 'Size');
model.component('comp1').mesh('mesh2').create('edg1', 'Edge');
model.component('comp1').mesh('mesh2').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh2').create('edg2', 'Edge');
model.component('comp1').mesh('mesh2').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh2').create('ftet2', 'FreeTet');
model.component('comp1').mesh('mesh2').create('ftet3', 'FreeTet');
model.component('comp1').mesh('mesh2').create('swe1', 'Sweep');
model.component('comp1').mesh('mesh2').feature('edg1').selection.named('geom1_csel1_edg');
model.component('comp1').mesh('mesh2').feature('edg1').create('size1', 'Size');
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').selection.named('geom1_csel1_edg');
model.component('comp1').mesh('mesh2').feature('ftri1').selection.set([35 36 37 38 39 40 41 42 43 44 45 46 55 56 57 58 60 61 63 64 71 72 73 74]);
model.component('comp1').mesh('mesh2').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh2').feature('edg2').selection.set([33 34 35 36 45 46 47 48 49 50 51 52 69 70 71 72 97 98 103 104 105 106 115 116 145 146 151 152 153 154 163 164 185 186 187 188 197 198 199 200 201 202 203 204 221 222 223 224]);
model.component('comp1').mesh('mesh2').feature('edg2').create('size1', 'Size');
model.component('comp1').mesh('mesh2').feature('ftet1').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh2').feature('ftet1').selection.set([2 3 4 5 6 9]);
model.component('comp1').mesh('mesh2').feature('ftet1').create('size1', 'Size');
model.component('comp1').mesh('mesh2').feature('ftet2').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh2').feature('ftet2').selection.set([7 8]);
model.component('comp1').mesh('mesh2').feature('ftet2').create('size1', 'Size');
model.component('comp1').mesh('mesh2').feature('ftet3').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh2').feature('ftet3').selection.set([1]);
model.component('comp1').mesh('mesh2').feature('ftet3').create('size1', 'Size');

model.component('comp1').probe.create('bnd1', 'Boundary');
model.component('comp1').probe.create('bnd2', 'Boundary');
model.component('comp1').probe.create('bnd3', 'Boundary');
model.component('comp1').probe.create('bnd4', 'Boundary');
model.component('comp1').probe.create('bnd5', 'Boundary');
model.component('comp1').probe.create('bnd6', 'Boundary');
model.component('comp1').probe.create('bnd7', 'Boundary');
model.component('comp1').probe.create('bnd8', 'Boundary');
model.component('comp1').probe.create('bnd9', 'Boundary');
model.component('comp1').probe.create('bnd10', 'Boundary');
model.component('comp1').probe.create('bnd11', 'Boundary');
model.component('comp1').probe.create('bnd12', 'Boundary');
model.component('comp1').probe('bnd1').selection.set([24]);
model.component('comp1').probe('bnd2').selection.set([76]);
model.component('comp1').probe('bnd3').selection.set([23]);
model.component('comp1').probe('bnd4').selection.set([75]);
model.component('comp1').probe('bnd5').selection.set([47]);
model.component('comp1').probe('bnd6').selection.set([65]);
model.component('comp1').probe('bnd7').selection.set([26]);
model.component('comp1').probe('bnd8').selection.set([78]);
model.component('comp1').probe('bnd9').selection.set([25]);
model.component('comp1').probe('bnd10').selection.set([77]);
model.component('comp1').probe('bnd11').selection.set([48]);
model.component('comp1').probe('bnd12').selection.set([66]);

model.result.table('tbl1').label('Probe Table 1');
model.result.table('tbl2').label('SigmaIntersection');

model.component('comp1').view('view1').set('renderwireframe', true);
model.component('comp1').view('view2').axis.set('xmin', -2.3472466468811035);
model.component('comp1').view('view2').axis.set('xmax', 2.1745872497558594);
model.component('comp1').view('view2').axis.set('ymin', -1.8262956142425537);
model.component('comp1').view('view2').axis.set('ymax', 1.4860119819641113);
model.component('comp1').view('view3').axis.set('xmin', -1.3670934438705444);
model.component('comp1').view('view3').axis.set('xmax', 5.277346134185791);
model.component('comp1').view('view3').axis.set('ymin', -3.493144989013672);
model.component('comp1').view('view3').axis.set('ymax', 1.374001383781433);
model.component('comp1').view('view4').set('transparency', true);

model.component('comp1').material('mat1').label('Air');
model.component('comp1').material('mat1').set('family', 'air');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('pieces', {'200.0' '1600.0' '-8.38278E-7+8.35717342E-8*T^1-7.69429583E-11*T^2+4.6437266E-14*T^3-1.06585607E-17*T^4'});
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('eta').set('fununit', 'Pa*s');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('pieces', {'200.0' '1600.0' '1047.63657-0.372589265*T^1+9.45304214E-4*T^2-6.02409443E-7*T^3+1.2858961E-10*T^4'});
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('Cp').set('fununit', 'J/(kg*K)');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('expr', 'pA*0.02897/R_const[K*mol/J]/T');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('args', {'pA' 'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('dermethod', 'manual');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('argders', {'pA' 'd(pA*0.02897/R_const/T,pA)'; 'T' 'd(pA*0.02897/R_const/T,T)'});
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('argunit', 'Pa,K');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('fununit', 'kg/m^3');
model.component('comp1').material('mat1').propertyGroup('def').func('rho').set('plotargs', {'pA' '0' '1'; 'T' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('arg', 'T');
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('pieces', {'200.0' '1600.0' '-0.00227583562+1.15480022E-4*T^1-7.90252856E-8*T^2+4.11702505E-11*T^3-7.43864331E-15*T^4'});
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('k').set('fununit', 'W/(m*K)');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('expr', 'sqrt(1.4*R_const[K*mol/J]/0.02897*T)');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('args', {'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('dermethod', 'manual');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('fununit', 'm/s');
model.component('comp1').material('mat1').propertyGroup('def').func('cs').set('plotargs', {'T' '273.15' '373.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('funcname', 'alpha_p');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('expr', '-1/rho(pA,T)*d(rho(pA,T),T)');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('args', {'pA' 'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('argunit', 'Pa,K');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('fununit', '1/K');
model.component('comp1').material('mat1').propertyGroup('def').func('an1').set('plotargs', {'pA' '101325' '101325'; 'T' '273.15' '373.15'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('funcname', 'muB');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('expr', '0.6*eta(T)');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('args', {'T'});
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('argunit', 'K');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('fununit', 'Pa*s');
model.component('comp1').material('mat1').propertyGroup('def').func('an2').set('plotargs', {'T' '200' '1600'});
model.component('comp1').material('mat1').propertyGroup('def').set('thermalexpansioncoefficient', {'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)' '0' '0' '0' 'alpha_p(pA,T)'});
model.component('comp1').material('mat1').propertyGroup('def').set('molarmass', '0.02897[kg/mol]');
model.component('comp1').material('mat1').propertyGroup('def').set('bulkviscosity', 'muB(T)');
model.component('comp1').material('mat1').propertyGroup('def').descr('thermalexpansioncoefficient_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').descr('molarmass_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').descr('bulkviscosity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').descr('relpermeability_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').descr('relpermittivity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('dynamicviscosity', 'eta(T)');
model.component('comp1').material('mat1').propertyGroup('def').descr('dynamicviscosity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('ratioofspecificheat', '1.4');
model.component('comp1').material('mat1').propertyGroup('def').descr('ratioofspecificheat_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'0[S/m]' '0' '0' '0' '0[S/m]' '0' '0' '0' '0[S/m]'});
model.component('comp1').material('mat1').propertyGroup('def').descr('electricconductivity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', 'Cp(T)');
model.component('comp1').material('mat1').propertyGroup('def').descr('heatcapacity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('density', 'rho(pA,T)');
model.component('comp1').material('mat1').propertyGroup('def').descr('density_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'k(T)' '0' '0' '0' 'k(T)' '0' '0' '0' 'k(T)'});
model.component('comp1').material('mat1').propertyGroup('def').descr('thermalconductivity_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').set('soundspeed', 'cs(T)');
model.component('comp1').material('mat1').propertyGroup('def').descr('soundspeed_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('def').addInput('temperature');
model.component('comp1').material('mat1').propertyGroup('def').addInput('pressure');
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').set('n', '');
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').set('ki', '');
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').set('n', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').descr('n_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('RefractiveIndex').descr('ki_symmetry', '');
model.component('comp1').material('mat1').propertyGroup('NonlinearModel').set('BA', '(def.gamma+1)/2');
model.component('comp1').material('mat1').propertyGroup('NonlinearModel').descr('BA_symmetry', '');
model.component('comp1').material('mat2').label('Nickel Steel Mumetal 77% Ni');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'1.74[MS/m]' '0' '0' '0' '1.74[MS/m]' '0' '0' '0' '1.74[MS/m]'});
model.component('comp1').material('mat2').propertyGroup('def').descr('electricconductivity_symmetry', '');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'1[1]' '0' '0' '0' '1[1]' '0' '0' '0' '1[1]'});
model.component('comp1').material('mat2').propertyGroup('def').descr('relpermittivity_symmetry', '');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability', {'1.5e4' '0' '0' '0' '1.5e4' '0' '0' '0' '1.5e4'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('BHCurve').label('B-H Curve');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').label('Interpolation 1');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('table', {'0' '0';  ...
'0.212833333333333' '0.0197942708333333';  ...
'0.412366666666667' '0.0383541666666667';  ...
'0.5853' '0.0544453125';  ...
'0.718333333333333' '0.0668333333333333';  ...
'0.802850260416667' '0.0747239583333333';  ...
'0.84896875' '0.0790833333333333';  ...
'0.871490364583333' '0.0813177083333333';  ...
'0.885216666666667' '0.0828333333333333';  ...
'0.901984895833333' '0.0847450520833333';  ...
'0.921775' '0.0870020833333333';  ...
'0.941602604166667' '0.0892622395833333';  ...
'0.958483333333333' '0.0911833333333333';  ...
'0.970344010416667' '0.09252578125';  ...
'0.97875625' '0.0934604166666667';  ...
'0.986202864583333' '0.0942606770833333';  ...
'0.995166666666667' '0.0952';  ...
'1.00772239583333' '0.0965052083333333';  ...
'1.0243125' '0.0982166666666667';  ...
'1.04497135416667' '0.100328125';  ...
'1.06973333333333' '0.102833333333333';  ...
'1.10109453125' '0.105953385416667';  ...
'1.15139791666667' '0.11081875';  ...
'1.23544817708333' '0.118787239583333';  ...
'1.36805' '0.131216666666667';  ...
'1.55635625' '0.14875859375';  ...
'1.7769125' '0.169239583333333';  ...
'1.9986125' '0.189779947916667';  ...
'2.19035' '0.2075';  ...
'2.33531067708333' '0.220595833333333';  ...
'2.47384791666667' '0.231566666666667';  ...
'2.66060703125' '0.2439875';  ...
'2.95023333333333' '0.261433333333333';  ...
'3.38863177083333' '0.286354166666667';  ...
'3.98674583333333' '0.3167';  ...
'4.74677864583333' '0.349295833333333';  ...
'5.67093333333333' '0.380966666666667';  ...
'6.79632786458333' '0.4092078125';  ...
'8.29973958333333' '0.434195833333333';  ...
'10.3928606770833' '0.456777604166667';  ...
'13.2873833333333' '0.4778';  ...
'17.0705033854167' '0.497813020833333';  ...
'21.33143125' '0.516179166666667';  ...
'25.5348809895833' '0.5319640625';  ...
'29.1455666666667' '0.544233333333333';  ...
'31.7581942708333' '0.552383854166667';  ...
'33.4874375' '0.5571375';  ...
'34.5779619791667' '0.559547395833333';  ...
'35.2744333333333' '0.560666666666667';  ...
'35.85786015625' '0.56145234375';  ...
'36.7546229166667' '0.562477083333333';  ...
'38.4274450520833' '0.564217447916667';  ...
'41.33905' '0.56715';  ...
'45.7528307291667' '0.571543489583333';  ...
'51.1348583333333' '0.576835416666667';  ...
'56.7518734375' '0.58225546875';  ...
'61.8706166666667' '0.587033333333333';  ...
'65.96323828125' '0.590601302083333';  ...
'69.3235270833333' '0.593202083333333';  ...
'72.4506815104167' '0.595280989583333';  ...
'75.8439' '0.597283333333333';  ...
'79.9757723958333' '0.59957578125';  ...
'85.2124541666667' '0.602210416666667';  ...
'91.8934921875' '0.605160677083333';  ...
'100.358433333333' '0.6084';  ...
'110.806870052083' '0.611872916666667';  ...
'122.878577083333' '0.615408333333333';  ...
'136.073374739583' '0.61880625';  ...
'149.891083333333' '0.621866666666667';  ...
'163.8331453125' '0.624434375';  ...
'177.407491666667' '0.626533333333333';  ...
'190.123675520833' '0.628232291666667';  ...
'201.49125' '0.6296';  ...
'211.669510677083' '0.63072734375';  ...
'223.416722916667' '0.63179375';  ...
'240.14089453125' '0.63300078125';  ...
'265.250033333333' '0.63455';  ...
'309.963025' '0.636607291666667';  ...
'416.742266666667' '0.639195833333333';  ...
'635.861033333333' '0.642303125';  ...
'1017.5926' '0.645916666666667';  ...
'1619.88238671875' '0.65';  ...
'2531.36439375' '0.654420833333333';  ...
'3848.34476640625' '0.659022916666667';  ...
'5667.12965' '0.66365';  ...
'8009.16803723958' '0.668133072916667';  ...
'10596.4803104167' '0.672252083333333';  ...
'13076.2296992188' '0.67577421875';  ...
'15095.5794333333' '0.678466666666667';  ...
'16522.068425' '0.680348958333333';  ...
'18104.7383166667' '0.68245';  ...
'20813.0064333333' '0.686051041666667';  ...
'25616.2901' '0.692433333333333';  ...
'33404.5455299479' '0.702751302083333';  ...
'44749.8844895833' '0.717652083333333';  ...
'60144.9576335937' '0.737655989583333';  ...
'80082.4156166667' '0.763283333333333';  ...
'104755.770108333' '0.794702083333333';  ...
'133161.9768375' '0.830670833333333';  ...
'163998.852547917' '0.869595833333333';  ...
'195964.213983333' '0.909883333333333';  ...
'227733.659909115' '0.949904276447503';  ...
'257893.917177083' '0.987888378246689';  ...
'285009.494660677' '1.02203004741591';  ...
'307644.901233333' '1.05052369264018';  ...
'326366.411457813' '1.0740803228479';  ...
'349747.362654167' '1.10347734794098';  ...
'388362.857831771' '1.15200877806471';  ...
'452788' '1.23296862336437';  ...
'550319.34375' '1.35553012457266';  ...
'675139.25' '1.51238344477188';  ...
'818151.53125' '1.69209797763171';  ...
'970260' '1.88324311682185'});
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('extrap', 'linear');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('argunit', 'A/m');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('fununit', 'T');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('defineinv', true);
model.component('comp1').material('mat2').propertyGroup('BHCurve').func('BH').set('defineprimfun', true);
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('normB', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('normH', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('Wpm', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('normB', 'BH(normHin)');
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('normH', 'BH_inv(normBin)');
model.component('comp1').material('mat2').propertyGroup('BHCurve').set('Wpm', 'BH_prim(normHin)');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normB_symmetry', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normH_symmetry', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('Wpm_symmetry', '');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normHin', 'Magnetic field norm');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normHin_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normBin', 'Magnetic flux density norm');
model.component('comp1').material('mat2').propertyGroup('BHCurve').descr('normBin_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('BHCurve').addInput('magneticfield');
model.component('comp1').material('mat2').propertyGroup('BHCurve').addInput('magneticfluxdensity');

model.component('comp1').coordSystem('ie1').active(false);
model.component('comp1').coordSystem('ie1').set('ScalingType', 'Spherical');

model.component('comp1').physics('mfnc').feature('mfc1').set('normB', 'mu0_const*mfnc2.normH');
model.component('comp1').physics('mfnc').feature('mfc1').set('Wpm_BHC', '(0.5*mfnc2.normB)*mfnc2.normH');
model.component('comp1').physics('mfnc').feature('mfc1').set('normHs', 'mfnc2.normB/mu0_const');
model.component('comp1').physics('mfnc').feature('mfc1').set('normBpm', 'mu0_const*mfnc2.normHs');
model.component('comp1').physics('mfnc').feature('mfc1').set('Wpm_NPM', '(0.5*mfnc2.normB)*mfnc2.normHs');
model.component('comp1').physics('mfnc').feature('msp1').set('Vm0', 'y');
model.component('comp1').physics('mfnc').feature('msp14').set('Vm0', 'bnd1');
model.component('comp1').physics('mfnc').feature('msp15').set('Vm0', 'bnd2');
model.component('comp1').physics('mfnc').feature('msp16').set('Vm0', 'bnd3');
model.component('comp1').physics('mfnc').feature('msp17').set('Vm0', 'bnd4');
model.component('comp1').physics('mfnc').feature('msp18').set('Vm0', 'bnd5');
model.component('comp1').physics('mfnc').feature('msp19').set('Vm0', 'bnd6');
model.component('comp1').physics('mfnc').feature('msp20').set('Vm0', 'bnd7');
model.component('comp1').physics('mfnc').feature('msp21').set('Vm0', 'bnd8');
model.component('comp1').physics('mfnc').feature('msp22').set('Vm0', 'bnd9');
model.component('comp1').physics('mfnc').feature('msp23').set('Vm0', 'bnd10');
model.component('comp1').physics('mfnc').feature('msp24').set('Vm0', 'bnd11');
model.component('comp1').physics('mfnc').feature('msp25').set('Vm0', 'bnd12');
model.component('comp1').physics('mfnc').feature('mflx2').set('nB_type', 'B0');
model.component('comp1').physics('mf').feature('edc1').set('Ie', 1);
model.component('comp1').physics('mfnc2').prop('BackgroundField').set('SolveFor', 'ReducedField');
model.component('comp1').physics('mfnc2').prop('BackgroundField').set('Hb', {'mf.Hx'; 'mf.Hy'; 'mf.Hz'});
model.component('comp1').physics('mfnc2').feature('mfc1').set('normB', 'mu0_const*mfnc3.normH');
model.component('comp1').physics('mfnc2').feature('mfc1').set('Wpm_BHC', '(0.5*mfnc3.normB)*mfnc3.normH');
model.component('comp1').physics('mfnc2').feature('mfc1').set('normHs', 'mfnc3.normB/mu0_const');
model.component('comp1').physics('mfnc2').feature('mfc1').set('normBpm', 'mu0_const*mfnc3.normHs');
model.component('comp1').physics('mfnc2').feature('mfc1').set('Wpm_NPM', '(0.5*mfnc3.normB)*mfnc3.normHs');

model.component('comp1').mesh('mesh1').feature('edg1').feature('size1').active(false);
model.component('comp1').mesh('mesh1').feature('edg1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('edg1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('edg1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('edg1').feature('dis1').set('numelem', 60);
model.component('comp1').mesh('mesh1').feature('fq1').active(false);
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('hmax', 0.04);
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('hgrad', 1.2);
model.component('comp1').mesh('mesh1').feature('fq1').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.04);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('ftri2').active(false);
model.component('comp1').mesh('mesh1').feature('ftri2').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('ftri2').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftri2').feature('size1').set('hmax', 0.02);
model.component('comp1').mesh('mesh1').feature('ftri2').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('ftet4').active(false);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hauto', 3);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hgrad', 1.45);
model.component('comp1').mesh('mesh1').feature('ftet1').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').feature('fq2').active(false);
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('hmax', 0.04);
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('hgrad', 1.2);
model.component('comp1').mesh('mesh1').feature('fq2').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').feature('ftet5').active(false);
model.component('comp1').mesh('mesh1').feature('ftet3').active(false);
model.component('comp1').mesh('mesh1').feature('ftet3').feature('size1').set('hauto', 9);
model.component('comp1').mesh('mesh1').feature('ftet2').active(false);
model.component('comp1').mesh('mesh1').feature('ftet2').feature('size1').set('hauto', 7);
model.component('comp1').mesh('mesh1').feature('ftet2').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftet2').feature('size1').set('hgrad', 2);
model.component('comp1').mesh('mesh1').feature('ftet2').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').feature('swe1').active(false);
model.component('comp1').mesh('mesh1').run;
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('hmax', 0.05);
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('hmin', '0.0005');
model.component('comp1').mesh('mesh2').feature('edg1').feature('size1').set('hminactive', true);
model.component('comp1').mesh('mesh2').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh2').feature('ftri1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh2').feature('ftri1').feature('size1').set('hmax', 0.04);
model.component('comp1').mesh('mesh2').feature('ftri1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('hmax', 0.01);
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('hmin', 0.003);
model.component('comp1').mesh('mesh2').feature('edg2').feature('size1').set('hminactive', true);
model.component('comp1').mesh('mesh2').feature('ftet1').feature('size1').set('hauto', 2);
model.component('comp1').mesh('mesh2').feature('ftet2').feature('size1').set('hauto', 6);
model.component('comp1').mesh('mesh2').feature('ftet3').feature('size1').set('hauto', 6);
model.component('comp1').mesh('mesh2').feature('swe1').active(false);
model.component('comp1').mesh('mesh2').run;

model.component('comp1').probe('bnd1').set('expr', 'y');
model.component('comp1').probe('bnd1').set('unit', 'm');
model.component('comp1').probe('bnd1').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd1').set('table', 'tbl1');
model.component('comp1').probe('bnd1').set('window', 'window1');
model.component('comp1').probe('bnd2').set('expr', 'y');
model.component('comp1').probe('bnd2').set('unit', 'm');
model.component('comp1').probe('bnd2').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd2').set('table', 'tbl1');
model.component('comp1').probe('bnd2').set('window', 'window1');
model.component('comp1').probe('bnd3').set('expr', 'y');
model.component('comp1').probe('bnd3').set('unit', 'm');
model.component('comp1').probe('bnd3').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd3').set('table', 'tbl1');
model.component('comp1').probe('bnd3').set('window', 'window1');
model.component('comp1').probe('bnd4').set('expr', 'y');
model.component('comp1').probe('bnd4').set('unit', 'm');
model.component('comp1').probe('bnd4').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd4').set('table', 'tbl1');
model.component('comp1').probe('bnd4').set('window', 'window1');
model.component('comp1').probe('bnd5').set('expr', 'y');
model.component('comp1').probe('bnd5').set('unit', 'm');
model.component('comp1').probe('bnd5').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd5').set('table', 'tbl1');
model.component('comp1').probe('bnd5').set('window', 'window1');
model.component('comp1').probe('bnd6').set('expr', 'y');
model.component('comp1').probe('bnd6').set('unit', 'm');
model.component('comp1').probe('bnd6').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd6').set('table', 'tbl1');
model.component('comp1').probe('bnd6').set('window', 'window1');
model.component('comp1').probe('bnd7').set('expr', 'y');
model.component('comp1').probe('bnd7').set('unit', 'm');
model.component('comp1').probe('bnd7').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd7').set('table', 'tbl1');
model.component('comp1').probe('bnd7').set('window', 'window1');
model.component('comp1').probe('bnd8').set('expr', 'y');
model.component('comp1').probe('bnd8').set('unit', 'm');
model.component('comp1').probe('bnd8').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd8').set('table', 'tbl1');
model.component('comp1').probe('bnd8').set('window', 'window1');
model.component('comp1').probe('bnd9').set('expr', 'y');
model.component('comp1').probe('bnd9').set('unit', 'm');
model.component('comp1').probe('bnd9').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd9').set('table', 'tbl1');
model.component('comp1').probe('bnd9').set('window', 'window1');
model.component('comp1').probe('bnd10').set('expr', 'y');
model.component('comp1').probe('bnd10').set('unit', 'm');
model.component('comp1').probe('bnd10').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd10').set('table', 'tbl1');
model.component('comp1').probe('bnd10').set('window', 'window1');
model.component('comp1').probe('bnd11').set('expr', 'y');
model.component('comp1').probe('bnd11').set('unit', 'm');
model.component('comp1').probe('bnd11').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd11').set('table', 'tbl1');
model.component('comp1').probe('bnd11').set('window', 'window1');
model.component('comp1').probe('bnd12').set('expr', 'y');
model.component('comp1').probe('bnd12').set('unit', 'm');
model.component('comp1').probe('bnd12').set('descr', 'y-coordinate');
model.component('comp1').probe('bnd12').set('table', 'tbl1');
model.component('comp1').probe('bnd12').set('window', 'window1');

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'mfnc' 'on' 'mf' 'off' 'mfnc2' 'off' 'frame:spatial1' 'on' 'frame:material1' 'on'});
model.study.create('std2');
model.study('std2').create('stat', 'Stationary');
model.study('std2').feature('stat').set('activate', {'mfnc' 'off' 'mf' 'on' 'mfnc2' 'on' 'frame:spatial1' 'on' 'frame:material1' 'on'});

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('i1', 'Iterative');
model.sol('sol1').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol1').feature('s1').feature.remove('fcDef');
model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('s1', 'Stationary');
model.sol('sol2').feature('s1').create('se1', 'Segregated');
model.sol('sol2').feature('s1').create('i1', 'Iterative');
model.sol('sol2').feature('s1').create('i2', 'Iterative');
model.sol('sol2').feature('s1').feature('se1').create('ss1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').create('ss2', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').create('mfnc1', 'SegregatedStep');
model.sol('sol2').feature('s1').feature('se1').feature.remove('ssDef');
model.sol('sol2').feature('s1').feature('i1').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('pr').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('po').create('so1', 'SOR');
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').create('ams1', 'AMS');
model.sol('sol2').feature('s1').feature('i2').create('mg1', 'Multigrid');
model.sol('sol2').feature('s1').feature.remove('fcDef');

model.result.dataset.create('avh13', 'Average');
model.result.dataset.create('avh14', 'Average');
model.result.dataset.create('avh15', 'Average');
model.result.dataset.create('avh16', 'Average');
model.result.dataset.create('avh17', 'Average');
model.result.dataset.create('avh18', 'Average');
model.result.dataset.create('avh19', 'Average');
model.result.dataset.create('avh20', 'Average');
model.result.dataset.create('avh21', 'Average');
model.result.dataset.create('avh22', 'Average');
model.result.dataset.create('avh23', 'Average');
model.result.dataset.create('avh24', 'Average');
model.result.dataset.create('dset3', 'Solution');
model.result.dataset.create('mesh2', 'Mesh');
model.result.dataset('dset2').set('probetag', 'bnd12');
model.result.dataset('avh13').set('probetag', 'bnd1');
model.result.dataset('avh13').set('data', 'dset2');
model.result.dataset('avh13').selection.geom('geom1', 2);
model.result.dataset('avh13').selection.set([24]);
model.result.dataset('avh14').set('probetag', 'bnd2');
model.result.dataset('avh14').set('data', 'dset2');
model.result.dataset('avh14').selection.geom('geom1', 2);
model.result.dataset('avh14').selection.set([76]);
model.result.dataset('avh15').set('probetag', 'bnd3');
model.result.dataset('avh15').set('data', 'dset2');
model.result.dataset('avh15').selection.geom('geom1', 2);
model.result.dataset('avh15').selection.set([23]);
model.result.dataset('avh16').set('probetag', 'bnd4');
model.result.dataset('avh16').set('data', 'dset2');
model.result.dataset('avh16').selection.geom('geom1', 2);
model.result.dataset('avh16').selection.set([75]);
model.result.dataset('avh17').set('probetag', 'bnd5');
model.result.dataset('avh17').set('data', 'dset2');
model.result.dataset('avh17').selection.geom('geom1', 2);
model.result.dataset('avh17').selection.set([47]);
model.result.dataset('avh18').set('probetag', 'bnd6');
model.result.dataset('avh18').set('data', 'dset2');
model.result.dataset('avh18').selection.geom('geom1', 2);
model.result.dataset('avh18').selection.set([65]);
model.result.dataset('avh19').set('probetag', 'bnd7');
model.result.dataset('avh19').set('data', 'dset2');
model.result.dataset('avh19').selection.geom('geom1', 2);
model.result.dataset('avh19').selection.set([26]);
model.result.dataset('avh20').set('probetag', 'bnd8');
model.result.dataset('avh20').set('data', 'dset2');
model.result.dataset('avh20').selection.geom('geom1', 2);
model.result.dataset('avh20').selection.set([78]);
model.result.dataset('avh21').set('probetag', 'bnd9');
model.result.dataset('avh21').set('data', 'dset2');
model.result.dataset('avh21').selection.geom('geom1', 2);
model.result.dataset('avh21').selection.set([25]);
model.result.dataset('avh22').set('probetag', 'bnd10');
model.result.dataset('avh22').set('data', 'dset2');
model.result.dataset('avh22').selection.geom('geom1', 2);
model.result.dataset('avh22').selection.set([77]);
model.result.dataset('avh23').set('probetag', 'bnd11');
model.result.dataset('avh23').set('data', 'dset2');
model.result.dataset('avh23').selection.geom('geom1', 2);
model.result.dataset('avh23').selection.set([48]);
model.result.dataset('avh24').set('probetag', 'bnd12');
model.result.dataset('avh24').set('data', 'dset2');
model.result.dataset('avh24').selection.geom('geom1', 2);
model.result.dataset('avh24').selection.set([66]);
model.result.dataset('dset3').set('solution', 'sol2');
model.result.dataset('mesh2').set('mesh', 'mesh2');
model.result.numerical.create('pev13', 'EvalPoint');
model.result.numerical.create('pev14', 'EvalPoint');
model.result.numerical.create('pev15', 'EvalPoint');
model.result.numerical.create('pev16', 'EvalPoint');
model.result.numerical.create('pev17', 'EvalPoint');
model.result.numerical.create('pev18', 'EvalPoint');
model.result.numerical.create('pev19', 'EvalPoint');
model.result.numerical.create('pev20', 'EvalPoint');
model.result.numerical.create('pev21', 'EvalPoint');
model.result.numerical.create('pev22', 'EvalPoint');
model.result.numerical.create('pev23', 'EvalPoint');
model.result.numerical.create('pev24', 'EvalPoint');
model.result.numerical.create('int1', 'IntSurface');
model.result.numerical('pev13').set('probetag', 'bnd1');
model.result.numerical('pev14').set('probetag', 'bnd2');
model.result.numerical('pev15').set('probetag', 'bnd3');
model.result.numerical('pev16').set('probetag', 'bnd4');
model.result.numerical('pev17').set('probetag', 'bnd5');
model.result.numerical('pev18').set('probetag', 'bnd6');
model.result.numerical('pev19').set('probetag', 'bnd7');
model.result.numerical('pev20').set('probetag', 'bnd8');
model.result.numerical('pev21').set('probetag', 'bnd9');
model.result.numerical('pev22').set('probetag', 'bnd10');
model.result.numerical('pev23').set('probetag', 'bnd11');
model.result.numerical('pev24').set('probetag', 'bnd12');
model.result.numerical('int1').set('data', 'dset3');
model.result.numerical('int1').selection.set([35 36 37 38 39 40 41 42 43 44 45 46 55 56 57 58 60 61 63 64 71 72 73 74]);
model.result.numerical('int1').set('probetag', 'none');
model.result.create('pg3', 'PlotGroup1D');
model.result.create('pg4', 'PlotGroup3D');
model.result.create('pg5', 'PlotGroup3D');
model.result.create('pg6', 'PlotGroup3D');
model.result.create('pg7', 'PlotGroup3D');
model.result('pg3').set('probetag', 'window1_default');
model.result('pg3').create('tblp1', 'Table');
model.result('pg3').feature('tblp1').set('probetag', 'bnd1,bnd2,bnd3,bnd4,bnd5,bnd6,bnd7,bnd8,bnd9,bnd10,bnd11,bnd12,bnd1,bnd2,bnd3,bnd4,bnd5,bnd6,bnd7,bnd8,bnd9,bnd10,bnd11,bnd12');
model.result('pg4').create('con1', 'Contour');
model.result('pg4').feature('con1').create('filt1', 'Filter');
model.result('pg4').feature('con1').feature('filt1').set('expr', '(x^2+y^2+z^2)>(0.75[m])^2');
model.result('pg5').set('data', 'dset3');
model.result('pg5').create('arwv1', 'ArrowVolume');
model.result('pg5').create('con1', 'Contour');
model.result('pg5').feature('con1').set('expr', 'Vm2');
model.result('pg6').set('data', 'mesh2');
model.result('pg6').create('mesh2', 'Mesh');
model.result('pg6').create('mesh3', 'Mesh');
model.result('pg6').feature('mesh2').set('meshdomain', 'volume');
model.result('pg6').feature('mesh3').create('sel1', 'MeshSelection');
model.result('pg6').feature('mesh3').feature('sel1').selection.set([35 36 37 38 39 40 41 42 43 44 45 46 55 56 57 58 60 61 63 64 71 72 73 74]);
model.result('pg7').create('arwv1', 'ArrowVolume');

model.component('comp1').probe('bnd1').genResult([]);
model.component('comp1').probe('bnd2').genResult([]);
model.component('comp1').probe('bnd3').genResult([]);
model.component('comp1').probe('bnd4').genResult([]);
model.component('comp1').probe('bnd5').genResult([]);
model.component('comp1').probe('bnd6').genResult([]);
model.component('comp1').probe('bnd7').genResult([]);
model.component('comp1').probe('bnd8').genResult([]);
model.component('comp1').probe('bnd9').genResult([]);
model.component('comp1').probe('bnd10').genResult([]);
model.component('comp1').probe('bnd11').genResult([]);
model.component('comp1').probe('bnd12').genResult([]);

model.study('std1').feature('stat').set('mesh', {'geom1' 'mesh1'});

model.sol('sol1').attach('std1');
model.sol('sol1').feature('s1').feature('i1').set('linsolver', 'cg');
model.sol('sol1').feature('s1').feature('i1').feature('mg1').set('prefun', 'amg');
% model.sol('sol1').runAll;
model.sol('sol2').attach('std2');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').label('Magnetic Fields');
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('segvar', {'comp1_A'});
model.sol('sol2').feature('s1').feature('se1').feature('ss1').set('linsolver', 'i1');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').label('Magnetic Fields, No Currents 3');
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('segvar', {'comp1_Vm2'});
model.sol('sol2').feature('s1').feature('se1').feature('ss2').set('linsolver', 'i2');
model.sol('sol2').feature('s1').feature('se1').feature('mfnc1').label('Segregated Step 1');
model.sol('sol2').feature('s1').feature('se1').feature('mfnc1').set('segvar', {'comp1_Vm'});
model.sol('sol2').feature('s1').feature('se1').feature('mfnc1').set('linsolver', 'i2');
model.sol('sol2').feature('s1').feature('i1').set('linsolver', 'fgmres');
model.sol('sol2').feature('s1').feature('i1').set('nlinnormuse', true);
model.sol('sol2').feature('s1').feature('i1').feature('mg1').feature('cs').feature('ams1').set('sorvecdof', {'comp1_A'});
model.sol('sol2').feature('s1').feature('i2').set('linsolver', 'cg');
model.sol('sol2').feature('s1').feature('i2').feature('mg1').set('prefun', 'amg');
% model.sol('sol2').runAll;

model.result.dataset('dset2').label('Probe Solution 2');
model.result.numerical('pev13').set('expr', {'x'});
model.result.numerical('pev13').set('descr', {'x-coordinate'});
model.result.numerical('pev14').set('expr', {'x'});
model.result.numerical('pev14').set('descr', {'x-coordinate'});
model.result.numerical('pev15').set('expr', {'x'});
model.result.numerical('pev15').set('descr', {'x-coordinate'});
model.result.numerical('pev16').set('expr', {'x'});
model.result.numerical('pev16').set('descr', {'x-coordinate'});
model.result.numerical('pev17').set('expr', {'x'});
model.result.numerical('pev17').set('descr', {'x-coordinate'});
model.result.numerical('pev18').set('expr', {'x'});
model.result.numerical('pev18').set('descr', {'x-coordinate'});
model.result.numerical('pev19').set('expr', {'x'});
model.result.numerical('pev19').set('descr', {'x-coordinate'});
model.result.numerical('pev20').set('expr', {'x'});
model.result.numerical('pev20').set('descr', {'x-coordinate'});
model.result.numerical('pev21').set('expr', {'x'});
model.result.numerical('pev21').set('descr', {'x-coordinate'});
model.result.numerical('pev22').set('expr', {'x'});
model.result.numerical('pev22').set('descr', {'x-coordinate'});
model.result.numerical('pev23').set('expr', {'x'});
model.result.numerical('pev23').set('descr', {'x-coordinate'});
model.result.numerical('pev24').set('expr', {'x'});
model.result.numerical('pev24').set('descr', {'x-coordinate'});
model.result.numerical('int1').set('table', 'tbl2');
model.result.numerical('int1').set('expr', {'(y)*Vm2/(0.7[m])^1' '(z)*Vm2/(0.7[m])^1' '(x)*Vm2/(0.7[m])^1' '(x*y)*Vm2/(0.7[m])^2' '(y*z)*Vm2/(0.7[m])^2' '((-x^2 - y^2 + 2*z^2)/4)*Vm2/(0.7[m])^2' '(x*z)*Vm2/(0.7[m])^2' '(((x - y)*(x + y))/2)*Vm2/(0.7[m])^2'});
model.result.numerical('int1').set('unit', {'m^2*A' 'm^2*A' 'm^2*A' 'm^2*A' 'm^2*A' 'm^2*A' 'm^2*A' 'm^2*A'});
model.result.numerical('int1').set('descr', {'l=1 m=-1' 'l=1 m=0' 'l=1 m=1' 'l=2 m=-2' 'l=2 m=-1' 'l=2 m=0' 'l=2 m=1' 'l=2 m=2'});
model.result.numerical('int1').setResult;
model.result('pg3').label('Probe Plot Group 3');
model.result('pg3').set('xlabel', 'x-coordinate (m), Boundary Probe 1');
model.result('pg3').set('windowtitle', 'Probe Plot 1');
model.result('pg3').set('xlabelactive', false);
model.result('pg3').feature('tblp1').label('Probe Table Graph 1');
model.result('pg3').feature('tblp1').set('legend', true);
model.result('pg4').feature('con1').set('number', 30);
model.result('pg4').feature('con1').set('coloring', 'uniform');
model.result('pg4').feature('con1').set('resolution', 'normal');
model.result('pg5').feature('arwv1').set('expr', {'mf.Bx' 'mf.By' 'mf.Bz'});
model.result('pg5').feature('arwv1').set('arrowxmethod', 'coord');
model.result('pg5').feature('arwv1').set('xcoord', 'range(-0.5,0.25,0.5)');
model.result('pg5').feature('arwv1').set('arrowymethod', 'coord');
model.result('pg5').feature('arwv1').set('ycoord', 'range(-0.5,0.25,0.5)');
model.result('pg5').feature('arwv1').set('arrowzmethod', 'coord');
model.result('pg5').feature('arwv1').set('zcoord', 'range(-0.5,0.25,0.5)');
model.result('pg5').feature('arwv1').set('arrowlength', 'normalized');
model.result('pg5').feature('con1').set('resolution', 'normal');
model.result('pg6').set('inherithide', true);
model.result('pg6').feature('mesh2').set('filteractive', true);
model.result('pg6').feature('mesh2').set('elemfilter', 'quality');
model.result('pg6').feature('mesh2').set('tetkeep', '.01');
model.result('pg6').feature('mesh3').set('colorlegend', false);
model.result('pg7').feature('arwv1').set('arrowxmethod', 'coord');
model.result('pg7').feature('arwv1').set('xcoord', 'range(-0.5,0.5,0.5)');
model.result('pg7').feature('arwv1').set('arrowymethod', 'coord');
model.result('pg7').feature('arwv1').set('ycoord', 'range(-0.5,0.5,0.5)');
model.result('pg7').feature('arwv1').set('arrowzmethod', 'coord');
model.result('pg7').feature('arwv1').set('zcoord', 'range(-0.5,0.5,0.5)');
model.result('pg7').feature('arwv1').set('scale', 378981.0904881261);
model.result('pg7').feature('arwv1').set('scaleactive', false);

newmodel = model;

end