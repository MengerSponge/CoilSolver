function holes = holeStructure(faces)
% holes = holeStructure
%
% Quick method to generate cell array with hole locations and radii on each
% planar face of "ScalarBasis". It should be possible to extract this data
% automagically, but that's tedious and dangerous.
%
% Each hole is given by a list of (x,y,z,r), with coordinates in model-space
% 
% ARR 2020-07-17

if ~exist('faces','var') || isempty(faces)
  faces=1:6;
end

assert(max(faces)<=6,'Use Matlab face indexing for hole structure generation')

holes = cell(length(faces),1);

for i=1:length(faces)
    holes{i} = holemaker(faces(i));
end

end

function pattern = holemaker(matlabindex)
% function holemaker(matlabindex)
%
%{
Unfortunately, the first selection group in my standard model is the
mumetal layer itself, so the Comsol planar face selection grouping is off
by one from the 1-ordered Matlab list. Take the matlab index, and return
the specified hole pattern when appropriate.

-x face: Comsol-2, Matlab-1
-y face: Comsol-3, Matlab-2
-z face: Comsol-4, Matlab-3
+x face: Comsol-5, Matlab-4
+y face: Comsol-6, Matlab-5
+z face: Comsol-7, Matlab-6

%}
pattern = [];
if matlabindex == 2
    pattern = [ 0.3  -1.2  0.3  0.1325;...
               -0.3  -1.2 -0.3  0.1325;...
                1.05 -1.2  1.05 0.0663;...
               -1.05 -1.2  1.05 0.0663;...
               -1.05 -1.2 -1.05 0.0663;...
                1.05 -1.2 -1.05 0.0663];
elseif matlabindex == 6
    pattern = [ 0.3  1.2  0.3  0.1325;...
               -0.3  1.2 -0.3  0.1325;...
                1.05 1.2  1.05 0.0663;...
               -1.05 1.2  1.05 0.0663;...
               -1.05 1.2 -1.05 0.0663;...
                1.05 1.2 -1.05 0.0663];
end
end