function newfacedata = splitResampleContours(facedata, holedata, spacing, mode)
% function newfacedata = resampleContours(facedata, holedata, spacing, mode)

assert(length(facedata)==length(holedata), "Different number of faces in contour data and hole data.")

assert(length(spacing)==2, "Need coarse and fine spacing parameters")

newfacedata = facedata;

for i=1:length(facedata)
    if i==5
        disp('check me')
    end
    % Split hole data for face i
    n_holes = length(holedata{i});
    hole_coord = zeros(2,n_holes);
    if n_holes==0
        hole_r = [];
    else
        hole_r = holedata{i}(:,4);
    end
    
    curvemiss = true;
    % If contour doesn't pass through any hole distortions, interpolate it
    % as normal and continue. If it does, split it at the holes, and
    % resample it more finely there. This means we need to prepare for an
    % increase in curves at each level.
    
    for j=1:n_holes
        % Transform hole to local 2d plane: facedata{i}{4} = M, the affine
        % transformation matrix.
        hole_pt = newfacedata{i}{4}*[holedata{i}(j, 1:3) 1]';
        hole_coord(:,j) = hole_pt(1:2);
    end
    newcontours = cell(length(facedata{i}{5}),1);
    for j =1:length(facedata{i}{5})
        
        for k = 1:length(facedata{i}{5}{j})
            contour = facedata{i}{5}{j}{k};
            if ~isempty(contour)
                for l=1:length(hole_r)
                    r = contour-hole_coord(:,l);
                    r2 = sum(r.*r,1);
                    if any(r2<hole_r(l)^2)
                        curvemiss=false;
                    end
                end
                if curvemiss
                    recontour = resample(contour, spacing(1), mode);
                    newcontours = buildContour(newcontours, recontour, j);
                else
                    supercontour = resample(contour, spacing(2), mode);
                    MN = size(supercontour);
                    wiretracker = zeros(1,MN(2));
                    for l=1:length(hole_r)
                        r = supercontour-hole_coord(:,l);
                        r2 = sum(r.*r,1);
                        % Now some Matlab shenanigans: (r2<hole_r(l)^2) is
                        % a boolean vector, equal to 1 whenever a point is
                        % within the radius given by hole_r(l). Add all of
                        % them up, and the nonzero values are the parts
                        % that need to stay at the finer resolution. The
                        % zero values can be relaxed.
                        wiretracker = wiretracker+(r2<hole_r(l)^2);
                    end
                    if max(wiretracker)==0
                        % Just missed penetration, I guess.
                        recontour = resample(contour, spacing(1), mode);
                        newcontours = buildContour(newcontours, recontour, j);
                    else
                        assert(max(wiretracker)<=1, "Circles should not ever overlap!")
                        steps = find(diff(wiretracker)~=0);
                        Nwire = length(steps)+1;
                        split = cell(Nwire,1);
                        split{1} = resample(supercontour(:,1:steps(1)),spacing(1),mode);
                        for l=1:(Nwire-2)
                            if supercontour(steps(l+1))==1
                                split{l+1}=supercontour(:,(steps(l)+1):steps(l+1));
                            else
                                split{l+1}=resample(supercontour(:,(steps(l)+1):steps(l+1)),spacing(1),mode);
                            end
                        end
                        split{Nwire} = resample(supercontour(:,(steps(end)+1):end),spacing(1),mode);
                        for l=1:Nwire
                            newcontours = buildContour(newcontours, split{l}, j);
                        end
                    end
                end
            end
        end
        
    end
    newfacedata{i}{5} = newcontours;
end

end

function appended = buildContour(contours, curve, j)
appended = contours;
if isempty(appended{j})
    appended{j}={curve};
else
    appended{j}=[appended{j}(:)' {curve}];
end
end

function newcontour = resample(contour, spacing, mode)
x = contour(1,:);
y = contour(2,:);

% Eliminate points that are within 1e-5 of each other.
dx = [diff(x) 1];
dy = [diff(y) 1];

dr = dx.^2+dy.^2;
x(dr<1e-10)=[];
y(dr<1e-10)=[];

% first try
n = 15;

if length(x)<3
    greenflag=false;
    newcontour = [x;y];
else
    
    pt = interparc(n,x,y,mode);
    dpt = diff(pt);
    ell = sqrt(mean(sum(dpt.^2,2)));
    err = ell/spacing;
    
    itercount = 5;
    refining = true;
    while refining
        itercount = itercount - 1;
        if itercount>0
            n = round(n*err);
            pt = interparc(n,x,y,mode);
            dpt = diff(pt);
            ell = sqrt(mean(sum(dpt.^2,2)));
            err = abs(spacing-ell)/spacing;
        else
            refining = false;
        end
        if err<0.1
            refining = false;
        end
    end
    newcontour = pt';
end
end
