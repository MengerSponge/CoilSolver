function varargout = affineRestore(x,y,M)
% varargout = affineRestore(x,y,M)
% 
% Inverts a 3D -> 2D affine transformation M for points given by X Y.
% ARR 2020.02.27

[xi, xj] = size(x);
[yi, yj] = size(y);

if xi~=yi && xj~=yj
    X = 0; Y = 0; Z = 0;
    error('x and y vectors are not aligned, or are not the same length.');
else
    if xi>1 % x,y are column vectors
        allpoints = [x'; y'; zeros(1,xi); ones(1,xi)];
    else
        allpoints = [x; y; zeros(1,xj); ones(1,xj)];
    end
    restorePoints = inv(M)*allpoints;
    X = restorePoints(1,:);
    Y = restorePoints(2,:);
    Z = restorePoints(3,:);
end

if nargout==0 || nargout==1
    varargout{1} = [X; Y; Z];
elseif nargout==3
    varargout{1} = X;
    varargout{2} = Y;
    varargout{3} = Z;
end

end