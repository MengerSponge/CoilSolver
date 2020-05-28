function [x,y,Vm,M,k] = affineTransform(Vdata,inside,debug)
% [x,y,Vm,M,k] = affineTransform(Vdata,inside,debug)
% 
% Takes 3D planar data with an unknown orientation, projects it to 2D
% then centers its points about the origin before rotating them so that a flat
% edge is along the bottom. All these transformations are saved as an
% affine transformation matrix M.
% 
% Note that this plane needs to be directed, so you have to specify a point
% that is *behind* the outer facing normal. If all the planes form a closed
% convex box you should specify a single point *inside* the box.
% ARR 2020.02.27

if ~exist('debug','var') || isempty(debug)
  debug=false;
end

% X = Vdata(:,1);
% Y = Vdata(:,2);
% Z = Vdata(:,3);

Vm = Vdata(:,4);

D = [[0 1 0 0];[0 0 1 0];[0 0 0 1];[1 1 1 1]];

A = Vdata(1,1:3);
B = Vdata(2,1:3);
C = Vdata(2,1:3);

AB = B-A;
AC = C-A;

i = 2;
normN = 0;
while normN==0
    i = i+1;
    C = Vdata(i,1:3);
    AC = C-A;
    N = cross(AB,AC);
    normN = norm(N);
end

Nhat = N/normN;

if dot(Nhat,(A-inside))<0
    Nhat = -1*Nhat;
end

uhat = AB/norm(AB);
vhat = cross(uhat,Nhat);

U = A+uhat;
V = A+vhat;

S = ones(4);
S(1:3,1) = A;
S(1:3,2) = U;
S(1:3,3) = V;
S(1:3,4) = N;

M = D*inv(S);

Tcoords = M*[Vdata(:,1:3) ones(length(Vm),1)]';

anchor = mean(Tcoords,2);
shift = [1 0 0 -anchor(1); 0 1 0 -anchor(2); 0 0 1 0; 0 0 0 1];
Tcoords = shift*Tcoords;

if debug
    debugfig = figure;
    subplot(2,1,1);
    axis equal
    hold on
    scatter(Tcoords(1,:),Tcoords(2,:),1,'k')
end

[phi,shape,k] = orientMesh(Tcoords);


% Note that this zeros the z-value, which should be <epsilon anyway.
realign =[cos(phi) -sin(phi) 0 0; sin(phi) cos(phi) 0 0; 0 0 1 0; 0 0 0 1];

Tcoords = realign*Tcoords;

if debug
    subplot(2,1,2);
    axis equal
    hold on
    scatter(Tcoords(1,:),Tcoords(2,:),1,'k')
%     x = [base(1),pivot(1)];
%     y = [base(2),pivot(2)];
%     annotation('textarrow',x,y,'String',['phi= ' num2str(phi)])
    close(debugfig)
end

M = realign*shift*M;

x = Tcoords(1,:);
y = Tcoords(2,:);

end