function reverse = checkDirection(x, y, Vm, wirepath, wireVm, gradVmThreshold, verbose, debugme)
% function reverse = checkDirection(model, wirepath, M)
% Takes wirepaths directly from splitcontour (ie still in transformed
% coordinates), and checks Vm to left and right of path, and ensures that
% the local gradient is oriented correctly.
% 
% ARR 2020.04.10


if ~exist('gradVmThreshold','var') || isempty(gradVmThreshold)
  gradVmThreshold = .8;
end

if ~exist('verbose','var') || isempty(verbose)
  verbose=false;
end

if ~exist('debugme','var') || isempty(debugme)
  debugme = false;
end 

[ci, ~] = size(wirepath);
if ci>2
    wirepath = wirepath';
%     cj = ci;
end

xpts = wirepath(1,:);
ypts = wirepath(2,:);

votes = zeros(1,length(xpts)-1);

for n=1:(length(xpts)-1)
    % for each pair of points along path, find the closest mesh point.
    % Determine if which side of points it lies on, and find the Vm sign.
    % If more than half have the wrong sign, reverse current path direction
    i = nearestmesh(wirepath(:,n),wirepath(:,n+1),x,y,1e-9);
    if length(i)>1
        if verbose disp('Multiple hits! Cool?'), end
        i(2:end)=[];
    end
    AB = [xpts(n+1)-xpts(n), ypts(n+1)-ypts(n)];
    APi= [x(i)-xpts(n), y(i)-ypts(n)];
    
    % if AB x APi > 0, Pi is to the left.
    direction = sign(AB(1)*APi(2)-AB(2)*APi(1));
    
    % currents can flow in either direction, so long as they're consistent
    % from wire to wire. Calculate the difference in Vm between points
    Vmgrad = sign(Vm(i)-wireVm);
    
    votes(n) = direction*Vmgrad;
end

directioncode = mean(votes);

if directioncode<-gradVmThreshold
    if verbose disp('Kept direction'), end
    reverse = true;
elseif directioncode>gradVmThreshold
    if verbose disp('Reversed direction!'), end
    reverse = false;
else
    reverse = false;
    error('Vm directionality not clear. Need to improve stencil resolution?')
end

end


function i = nearestmesh(A,B,x,y,d_min)
% [xi,yi,Vmi] = nearestmesh(A,B,x,y,Vm)
% finds closest point in x,y that is at least d_min away from line through
% A-B.

if ~exist('d_min','var') || isempty(d_min)
  d_min = 1e-9;
end 

sumdsquared = (A(1)-x).^2+(A(2)-y).^2+(B(1)-x).^2+(B(2)-y).^2;

abhat = (B-A)/norm(B-A);
Pperpd = (x-A(1))*abhat(2)-(y-A(2))*abhat(1);

mindee = min(sumdsquared(Pperpd>d_min));

i = find(sumdsquared==mindee);

end


function out = debug(A,B,x,y,d_min)

i = nearestmesh(A,B,x,y,d_min);
if length(i)>1
    i(2:end)=[];
end

out.h1 = plot(A(1),A(2),'xr');
out.h2 = plot(B(1),B(2),'xg');
out.h3 = plot([A(1),x(i)],[A(2),y(i)],'-m');

end