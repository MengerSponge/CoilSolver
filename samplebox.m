function out = samplebox
%
% samplebox.m for planeContour coilsolver.
%
% Model exported on May 28 2020, 14:29 by COMSOL 5.5.0.359.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\ausreid\Documents\GitHub\CoilSolver');

model.label('sample-single-box.mph');

model.param.set('shield_w', '1[m]');
model.param.set('shield_d', '1.1[m]');
model.param.set('shield_h', '1.2[m]');
model.param.set('coil_gap', '2[cm]');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);

model.result.table.create('evl3', 'Table');

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').selection.create('csel1', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel1').label('shield');
model.component('comp1').geom('geom1').selection.create('csel2', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('csel2').label('transition');
model.component('comp1').geom('geom1').selection.create('windings', 'CumulativeSelection');
model.component('comp1').geom('geom1').selection('windings').label('wires');
model.component('comp1').geom('geom1').create('blk1', 'Block');
model.component('comp1').geom('geom1').feature('blk1').label('World');
model.component('comp1').geom('geom1').feature('blk1').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk1').set('size', [3 3 3]);
model.component('comp1').geom('geom1').feature('blk1').set('layername', {'Layer 1'});
model.component('comp1').geom('geom1').feature('blk1').setIndex('layer', '.5', 0);
model.component('comp1').geom('geom1').feature('blk1').set('layerleft', true);
model.component('comp1').geom('geom1').feature('blk1').set('layerright', true);
model.component('comp1').geom('geom1').feature('blk1').set('layerfront', true);
model.component('comp1').geom('geom1').feature('blk1').set('layerback', true);
model.component('comp1').geom('geom1').feature('blk1').set('layertop', true);
model.component('comp1').geom('geom1').create('blk2', 'Block');
model.component('comp1').geom('geom1').feature('blk2').label('Shield');
model.component('comp1').geom('geom1').feature('blk2').set('contributeto', 'csel1');
model.component('comp1').geom('geom1').feature('blk2').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk2').set('size', {'shield_w' 'shield_d' 'shield_h'});
model.component('comp1').geom('geom1').create('blk3', 'Block');
model.component('comp1').geom('geom1').feature('blk3').set('contributeto', 'csel2');
model.component('comp1').geom('geom1').feature('blk3').set('base', 'center');
model.component('comp1').geom('geom1').feature('blk3').set('size', {'shield_w-2*coil_gap' 'shield_d-2*coil_gap' 'shield_h-2*coil_gap'});
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').create('wp1', 'WorkPlane');
model.component('comp1').geom('geom1').feature('wp1').set('planetype', 'faceparallel');
model.component('comp1').geom('geom1').feature('wp1').set('unite', true);
model.component('comp1').geom('geom1').feature('wp1').selection('face').set('blk2(1)', 6);
model.component('comp1').geom('geom1').feature('wp1').geom.create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('pos', {'-.10' '0'});
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('base', 'center');
model.component('comp1').geom('geom1').feature('wp1').geom.feature('r1').set('size', {'.2' '.3'});
model.component('comp1').geom('geom1').run;

model.component('comp1').selection.create('sel1', 'Explicit');
model.component('comp1').selection('sel1').geom('geom1', 2);
model.component('comp1').selection('sel1').set([72]);
model.component('comp1').selection.create('sel2', 'Explicit');
model.component('comp1').selection('sel2').geom('geom1', 2);
model.component('comp1').selection('sel2').set([74]);
model.component('comp1').selection.create('sel3', 'Explicit');
model.component('comp1').selection('sel3').geom('geom1', 2);
model.component('comp1').selection('sel3').set([73]);
model.component('comp1').selection.create('sel4', 'Explicit');
model.component('comp1').selection('sel4').geom('geom1', 2);
model.component('comp1').selection('sel4').set([76]);
model.component('comp1').selection.create('sel5', 'Explicit');
model.component('comp1').selection('sel5').geom('geom1', 2);
model.component('comp1').selection('sel5').set([75]);
model.component('comp1').selection.create('sel6', 'Explicit');
model.component('comp1').selection('sel6').geom('geom1', 2);
model.component('comp1').selection('sel6').set([78]);
model.component('comp1').selection('sel1').label('Face1');
model.component('comp1').selection('sel2').label('Face2');
model.component('comp1').selection('sel3').label('Face3');
model.component('comp1').selection('sel4').label('Face4');
model.component('comp1').selection('sel5').label('Face5');
model.component('comp1').selection('sel6').label('Face6');

model.view.create('view3', 3);
model.view.create('view4', 2);

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
model.component('comp1').material('mat2').selection.geom('geom1', 2);
model.component('comp1').material('mat2').selection.set([67 68 69 70 71 79]);
model.component('comp1').material('mat2').propertyGroup.create('BHCurve', 'B-H Curve');
model.component('comp1').material('mat2').propertyGroup('BHCurve').func.create('BH', 'Interpolation');

model.component('comp1').coordSystem.create('ie1', 'InfiniteElement');
model.component('comp1').coordSystem('ie1').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 21 22 23 24 25 26 27 28 29]);

model.component('comp1').physics.create('mfnc', 'MagnetostaticsNoCurrents', 'geom1');
model.component('comp1').physics('mfnc').selection.set([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 21 22 23 24 25 26 27 28 29]);
model.component('comp1').physics('mfnc').create('mflx1', 'MagneticFluxDensity', 2);
model.component('comp1').physics('mfnc').feature('mflx1').selection.named('geom1_csel2_bnd');
model.component('comp1').physics('mfnc').create('ms1', 'MagneticShielding', 2);
model.component('comp1').physics('mfnc').feature('ms1').selection.set([67 68 69 70 71 79]);
model.component('comp1').physics.create('mfnc2', 'MagnetostaticsNoCurrents', 'geom1');
model.component('comp1').physics('mfnc2').selection.named('geom1_csel2_dom');
model.component('comp1').physics('mfnc2').create('mflx1', 'MagneticFluxDensity', 2);
model.component('comp1').physics('mfnc2').feature('mflx1').selection.named('geom1_csel2_bnd');
model.component('comp1').physics('mfnc2').create('zsp1', 'ZeroMagneticScalarPotential', 0);
model.component('comp1').physics('mfnc2').feature('zsp1').selection.set([43]);

model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').create('ftet1', 'FreeTet');
model.component('comp1').mesh('mesh1').create('swe1', 'Sweep');
model.component('comp1').mesh('mesh1').feature('ftri1').selection.named('geom1_csel2_bnd');
model.component('comp1').mesh('mesh1').feature('ftri1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').feature('ftet1').selection.geom('geom1', 3);
model.component('comp1').mesh('mesh1').feature('ftet1').selection.set([14 19 20]);

model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').comments('Interactive 3D values');

model.component('comp1').view('view1').set('renderwireframe', true);
model.component('comp1').view('view1').set('scenelight', false);
model.component('comp1').view('view1').set('transparency', true);
model.component('comp1').view('view2').axis.set('xmin', -1.649999976158142);
model.component('comp1').view('view2').axis.set('xmax', 1.649999976158142);
model.component('comp1').view('view2').axis.set('ymin', -1.9197115898132324);
model.component('comp1').view('view2').axis.set('ymax', 1.9197115898132324);
model.view('view4').axis.set('xmin', -0.5829999446868896);
model.view('view4').axis.set('xmax', 0.5829999446868896);
model.view('view4').axis.set('ymin', -0.9929958581924438);
model.view('view4').axis.set('ymax', 0.9929958581924438);

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

model.component('comp1').physics('mfnc').feature('mflx1').set('Bn', '(1e-6*z-3e-7*x)*1[T]/1[m]');
model.component('comp1').physics('mfnc').feature('mflx1').set('B0', {'-1e-6[T]*x/(1[m])'; '0'; '-1e-6[T]*z/(1[m])'});
model.component('comp1').physics('mfnc').feature('ms1').set('murbnd_mat', 'userdef');
model.component('comp1').physics('mfnc').feature('ms1').set('murbnd', '1.5e4');
model.component('comp1').physics('mfnc2').prop('BackgroundField').set('Hb', {'0'; '0'; '-4*pi/10'});
model.component('comp1').physics('mfnc2').feature('mflx1').set('Bn', '-(1e-6*z-3e-7*x)*1[T]/1[m]');
model.component('comp1').physics('mfnc2').feature('mflx1').set('B0', {'-1e-6[T]*x/(1[m])'; '0'; '-1e-6[T]*z/(1[m])'});

model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hauto', 1);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hmax', 0.01);
model.component('comp1').mesh('mesh1').feature('ftri1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').create('stat1', 'Stationary');
model.study('std1').feature('stat').set('activate', {'mfnc' 'on' 'mfnc2' 'off' 'frame:spatial1' 'on' 'frame:material1' 'on'});
model.study('std1').feature('stat1').set('activate', {'mfnc' 'off' 'mfnc2' 'on' 'frame:spatial1' 'on' 'frame:material1' 'on'});
model.study('std1').feature('stat').label('outer_Vm');
model.study('std1').feature('stat1').label('inner_Vm2');

out = model;
