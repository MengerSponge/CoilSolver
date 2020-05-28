function indexpairs = splitContour(edgedistance, threshold, debug)
% function indexpairs = splitcontour(edgedistance)
% Takes a vector of distance products for each point on contour line. If
% contour touches an edge, want to discard all edge points after the first
% (or last), and start a new path if that contour departs from the edge
% again.
%
% Note that this function uses the "edgedistance" vector which is a product
% of the nearest distances from the given point to *each edge*! If you have
% a high order polygon that's pretty small, interior points could also fail
% this test. Make the threshold value smaller.
%
% ARR 2020.03.07

if ~exist('threshold','var') || isempty(threshold)
  threshold = 1e-14;
end

if ~exist('debug','var') || isempty(debug)
  debug = false;
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