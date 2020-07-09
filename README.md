# CoilSolver
Scalar potential based magnetic coil solver, in COMSOL and Matlab

## Solve for Scalar Potential Couplings
```matlab
couplings = pureSigmaSolve('ScalarBasis-Simplified.mph',3,50,[],'/(0.7[m])^')
```

## Extract winding information from a model
Because COMSOL MPH files are large binaries, I've included a far more compact Matlab function to generate and solve a new model.
If you call it with the optional parameter set to `true`, it will simply build the model.
The default behavior is to build and then solve the model, yielding an object that is useful for the other commands.

```matlab
model = samplebox();
facedata = planeContour(model,'sel',6,[0,0,0],30,true);
```

`facedata` is a structure with n entries, where n is the number of planar faces solved for by planeContour (6 in the sample code).
Each entry is structured like so:

```matlab
facedata{i} = {x,y,Vm,M,contours};
```

`x,y,Vm` are 1d vectors for the planar mesh and the corresponding Vm values at each mesh point.
`M` is the 4x4 affine transformation matrix that transformed the plane in model space to the 2d representation used here.
contours is a nested cell array containing a 1d vector of x,y ordered pairs for each contour line. disconnected contour lines at the same potential on a surface are represented as separate elements in the cell array.
