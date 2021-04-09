function indexpairs = splitContourPlus(hullpoints, tric, threshold, debug)
% function indexpairs = splitContourPlus(edgedistance, points, hull, threshold, debug)
%
% ARR 2021.03.24

if ~exist('threshold','var') || isempty(threshold)
  threshold = 1e-8;
end

if ~exist('debug','var') || isempty(debug)
  debug = false;
end

hullcycle = [hullpoints; hullpoints(1)];



contourlength = tric(2,n);
pts = tric(:,n+1:n+contourlength-1);
tracker = zeros(length(pts),length(hulln));
% Calculate the distance from a particular point to each
% edge as defined by the convex hull.
for hull=1:length(hullpoints)
    A = hullcycle(hull); 
    B = hullcycle(hull+1);
    AB = (B-A); 
    ABhat = AB/norm(AB);
    for pt=1:length(pts)
        AC = [pts(1,pt)-A(1), pts(2,pt)-A(2)];
        D = abs(ABhat(1)*AC(2)-ABhat(2)*AC(1));
        tracker(pt,hull) = D;
    end
end

% Select the shortest of those distances, and use that to tell 
% which points are "running along an edge".
closest = min(tracker,[],2);
% find which points are actually closest to the edge.
[~,locb] = ismember(closest,tracker);
nelements = length(locb);
% find the column that minimum belongs to (this is the edge number).
edgenum = (locb-[1:nelements]')/nelements+1;

% Now look for points that are within some threshold distance to the same
% edge.

for i=1:nelements
    
end



subpaths = splitContour(tracker,[],[]);
[~,pathpairs] = size(subpaths);
% split the contours when they hit an edge.
for splitindex=1:pathpairs
    temppath = pts(:,subpaths(1,splitindex):subpaths(2,splitindex));
    [reverse, votes] = checkDirection(x, y, Vm, temppath, level, 0.2,verbose,[]);
    if reverse
        temppath = fliplr(temppath);
    end
    if debug
        if abs(mean(votes))<0.5
            debugcell{i}{j} = votes;
        end
    end
    if isempty(contours{j})
        contours{j}={temppath};
    else
        contours{j}=[contours{j}(:)' {temppath}];
    end
end

startpts = [];
stoppts = [];
Npts = length(edgedistance);

if edgedistance(1)>threshold
    startpts=[1];
end
for i=2:Npts
    if edgedistance(i-1)<=threshold && edgedistance(i)>threshold
        startpts = [startpts i-1];
    end
end
if isempty(startpts)
    %this shouldn't actually happen...
    error('Found all edge path? Empty startpoint list? Weird.');
    startpts = [1];
end

if edgedistance(end)>threshold
    stoppts = [Npts];
end
for i=1:Npts-1
    if edgedistance(end-i)>threshold && edgedistance(end-i+1)<=threshold
        stoppts = [stoppts Npts-i+1];
    end
end

if isempty(stoppts)
    %this shouldn't actually happen either...
    error('Found all edge path? Empty stoppoint list? Weird.');
    stoppts = [Npts];
end

stoppts = flip(stoppts);

if length(startpts) ~= length(stoppts)
    error('Unpaired start/stop points.');
    indexpairs = [];
else
    indexpairs = [startpts; stoppts];
end

% If debug flag is true, just return the full string.
if debug
    indexpairs = [1; Npts];
end

end