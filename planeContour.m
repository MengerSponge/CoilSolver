function facedata = planeContour(model, selection,facecount, inside, nlevels,verbose,showy,debug,evalfunc)
% facedata = planeContour(model, selection,facecount, inside, nlevels,verbose,showy,debug)
% 
% Many of these parameters are optional. This method takes a model with specified planar faces,
% evaluates a prescribed function on those faces, then solves for the contours on those faces.
% Contours are returned alongside the facedata in a nicely structured cell array.
% 
% ARR 2020.03.10

if ~exist('facecount','var') || isempty(facecount)
  facecount=1:6;
end

if ~exist('nlevels','var') || isempty(nlevels)
  nlevels=20;
end

if ~exist('verbose','var') || isempty(verbose)
  verbose=false;
end

if ~exist('showy','var') || isempty(showy)
  showy=false;
end

if ~exist('debug','var') || isempty(debug)
  debug=false;
end

if ~exist('evalfunc','var') || isempty(evalfunc)
  evalfunc='Vm';
end

%{
Extract each planar face (with selection set)
for each level:
make tricontour
break each curve into its own object.
Tricontour algorithm can draw spurious paths along the edges of each planar
face. Split the curve when it touches an edge, and discard repeated edge
points. If for some pathological reason the current is *supposed* to run
along an edge, this won't work.
step along curve, check perp to steps to ensure correct gradient.
if gradient is backwards, flip curve
%}

%Get scalar potentials from all surfaces

if verbose, disp('Extracting scalar potentials'), end

data = extractScalarPotentials(model, selection,facecount);


%Calculate global range of scalar potential on all imported surfaces
Vmin = 1.1e10;
Vmax = -1.1e10;
for i = 1:length(data)
    localmax = max(data{i}(:,4));
    localmin = min(data{i}(:,4));
    if Vmax<localmax
        Vmax = localmax;
    end
    if Vmin>localmin
        Vmin = localmin;
    end
end

%Generate vector of equipotential values
tempLevels = linspace(Vmin,Vmax,nlevels+2);
levels = tempLevels(2:nlevels+1);

% Close all figures--we're going to make new ones and we want to know their
% indices when they're created.
if ~showy, close all, end

facedata = {};

for i = 1:length(data)
	if verbose, disp(['Working on face ' num2str(i) ' of ' num2str(length(data))]),end
    if iscell(inside)
        local_inside = inside{i};
    else
        local_inside = inside;
    end
    % Transform plane into nice x-y coordinates.
    [x,y,Vm,M,hullpts] = affineTransform(data{i},local_inside,debug);

    hullcycle = [hullpts; hullpts(1)];
    tri = delaunay(x,y);

    fighandle = figure('visible','off');
    hold on
    scatter(x,y,1,Vm);
    contours = cell(length(levels),1);
    for j = 1:length(levels)
        level = levels(j);
        % Only try to draw curve if that contour exists on the face.
        if (min(Vm)<level) && (level<max(Vm))
            temp = figure;
            [c,~]=tricontour(tri,x,y,Vm,[level,level]);
            close(temp);
            chunks = find(c(1,:)==level);
            % Now we need to clean up the levels returned from tricontour.
            for n = chunks
                contourlength = c(2,n);
                pts = c(:,n+1:n+contourlength-1);
                tracker = zeros(length(pts),length(hullpts));
                % Calculate the distance from a particular point to each
                % edge as defined by the convex hull.
                for hull=1:length(hullpts)
                    Ai = hullcycle(hull); Bi = hullcycle(hull+1);
                    A = [x(Ai) y(Ai)]; B = [x(Bi) y(Bi)];
                    AB = (B-A); ABhat = AB/norm(AB);
                    for pt=1:length(pts)
                        AC = [pts(1,pt)-A(1), pts(2,pt)-A(2)];
                        P = ABhat*dot(ABhat,AC);
                        tracker(pt,hull) = dot(P,P);
                    end
                end
                % Take the product of all those distances, and use that to
                % decide which points are "running along an edge".
                tracker = prod(tracker,2);
                subpaths = splitContour(tracker,[],[]);
                [~,pathpairs] = size(subpaths);
                % split the contours when they hit an edge.
                for splitindex=1:pathpairs
                    temppath = pts(:,subpaths(1,splitindex):subpaths(2,splitindex));
                    reverse = checkDirection(x, y, Vm, temppath, level, 0.5);
                    if reverse
                        temppath = fliplr(temppath);
                    end
                    if isempty(contours{j})
                        contours{j}={temppath};
                    else
                        contours{j}=[contours{j}(:)' {temppath}];

                    end
                end
            end
        end
        for k = 1:length(contours{j})
            exx = contours{j}{k}(1,:);
            eye = contours{j}{k}(2,:);
            plot(exx,eye,'-k')
        end
    end
    if showy
        set(fighandle,'Visible','on');
    else
        clf(fighandle);
    end
    facedata{i} = {x,y,Vm,M,contours};
% end
end