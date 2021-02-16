function [phi,shape,k] = orientMesh(meshdata)
% [phi,shape,k] = orientMesh(meshdata)
% 
% Takes 2d meshed data, figures out what order polygon it represents,
% then figures out how to rotate it so that one edge is parallel to 
% the X axis. affineTransform uses this method to figure out the rotation
% it applies.
% 
% ARR 2020.02.29

[r,c] = size(meshdata);

if r>c
    meshdata = meshdata';
end

k = convhull(meshdata(1,:),meshdata(2,:));
kpoints = length(k)-1;
% hullpoints = meshdata(k,1:2);

ktheta = zeros(kpoints,1);

ktheta(1) = anglecalc(subindex(meshdata,k,kpoints),subindex(meshdata,k,1),subindex(meshdata,k,2));

for i =2:kpoints
    ktheta(i) = anglecalc(subindex(meshdata,k,i-1),subindex(meshdata,k,i),subindex(meshdata,k,i+1));
end

k(end)=[];
k(ktheta>179.8)=[];

shape = length(k);

if abs(sum(ktheta(ktheta<179.9)) - (shape-2)*180)<10*eps
    disp("Didn't get correct polygon order... whoops!")
end

phis = zeros(length(k),1);

phis(1) = atan2(meshdata(2,k(1))-meshdata(2,k(end)),meshdata(1,k(1))-meshdata(1,k(end)));

for i=2:length(phis)
    phis(i) = atan2(meshdata(2,k(i))-meshdata(2,k(i-1)),meshdata(1,k(i))-meshdata(1,k(i-1)));
end

phi = -phis(abs(phis)==(min(abs(phis))));

if length(phi)>1
    phi = phi(1);
end
% anchor = meshdata(1:2,find(meshdata(1,:)==min(meshdata(1,k))));
% 
% swivel1 = meshdata(1:2,k(1));
% anchor = meshdata(1:2,k(2));
% swivel2 = meshdata(1:2,k(3));
% 
% phi1 = pi-atan2(swivel1(2)-anchor(2),swivel1(1)-anchor(1));
% phi2 = atan2(swivel2(2)-anchor(2),swivel2(1)-anchor(1));
% 
% phi = min(abs([phi1 phi2]));

end

function A = subindex(data,hull,index)
A = data(1:2,hull(index));
end

function theta = anglecalc(A,B,C)
BA = A-B;
BC = C-B;
theta = real(acosd(dot(BA/norm(BA),BC/norm(BC))));
end

% 
% Tcoords = shift*Tcoords;
% 
% base = Tcoords(:,Tcoords(1,:)==min(Tcoords(1,:)));
% pivot = Tcoords(:,Tcoords(2,:)==min(Tcoords(2,:)));
% 
% phi = -atan2(pivot(2)-base(2),pivot(1)-base(1));