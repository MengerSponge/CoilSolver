function WindingContour = ConnectContours(facedata3,x,y,z)

% coil3D = ConnectContours(contours3d,startface,startcontour,direction)
% 
% Takes the individual 3D contour segments returned from
% affineRestoreAllFaces (contours3d), and after specifying the starting
% face (startface) and contour (startcontour), and which side of the 
% contour to start from (direction), finds the end of the other contours 
% closest (min [(x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2]) to the end of the start
% contour, and appends the next contour in the correct direction to the
% start contour, building up a full full 3D set of points in order
% following along the winding path of the coil. This big long contour is
% returned from the function.
% 
% KES 2020.11.13


Vmin=-0.64;
Vmax=0.64;
nlevels=129;
levels = linspace(Vmin,Vmax,nlevels);

WindingContour={};
firsttrigger = 0;
checklistlength = 0;
% Identify the first point

Nexti=0;
Nextj=0;
Nextk=0; 
Nextp=0;

StartToEnd=true;

%Face
for i=1:length(facedata3)
    %Level
    for j=1:length(facedata3{1,i}{1,5})
        if ~isempty(facedata3{1,i}{1,5}{j,1})
            for k=1:length(facedata3{1,i}{1,5}{j,1})
                contourchecklist{i}{j}{k}=0;
                checklistlength = checklistlength + 1;
                points=length(facedata3{1,i}{1,5}{j,1}{1,k});
                %disp(['Face = ' num2str(i) ' Level = ' num2str(j) ' Contour = ' num2str(k)])
                for p=1:points
                    startcheck{1,i}{j,1}{1,k}(1,p)=(x-facedata3{1,i}{1,5}{j,1}{1,k}(1,p))^2 + (y-facedata3{1,i}{1,5}{j,1}{1,k}(2,p))^2 + (z-facedata3{1,i}{1,5}{j,1}{1,k}(3,p))^2;
                    if (firsttrigger==0)
                        firsttrigger=1;
                        startcheckmin=startcheck{1,i}{j,1}{1,k}(1,p);
                        prevstartcheckmin=startcheckmin;
                        istart=1;
                        jstart=1;
                        kstart=1;  
                        pstart=1;
                    end
                    startcheckmin=min([startcheckmin startcheck{1,i}{j,1}{1,k}(1,p)]);
                    if (startcheckmin ~= prevstartcheckmin)
                        prevstartcheckmin=startcheckmin;
                        istart=i;
                        jstart=j;
                        kstart=k;
                        pstart=p;
                    end
                end
            end
        end
    end
end

disp(['Start: Face = ' num2str(istart) ' | Contour = ' num2str(jstart) ' | Index = ' num2str(kstart)])
disp(['     X = ' num2str(facedata3{1,istart}{1,5}{jstart,1}{1,kstart}(1,pstart)) ', Y = ' num2str(facedata3{1,istart}{1,5}{jstart,1}{1,kstart}(2,pstart)) ', Z = ' num2str(facedata3{1,istart}{1,5}{jstart,1}{1,kstart}(3,pstart))])



% Append the first contour
[WindingContour,EndX,EndY,EndZ,EndLevel]=AppendContour(WindingContour,facedata3,istart,jstart,kstart,pstart);
contourchecklist{istart}{jstart}{kstart}=1;

assignin('base','ccl',contourchecklist)
% contourchecklistsize=size(contourchecklist);
% checklistlength=0;
% for i=1:contourchecklistsize(1)
%    for j=1:contourchecklistsize(2)
%        if(contourchecklist{1,j} == 0)
%            checklistlength=checklistlength+1;
%        end
%    end
% end

disp(['End: X = ' num2str(EndX) ', Y = ' num2str(EndY) ', Z = ' num2str(EndZ)])
disp(' ')

fig=figure('Visible','on');
ax=axes(fig); 
hold on;

cmap = parula(length(levels));
view(3);

for i=1:length(facedata3)
    if ~isempty(facedata3{1,i})
        for j=1:length(facedata3{1,i}{1,5})
            if ~isempty(facedata3{1,i}{1,5}{j,1})
                for k = 1:length(facedata3{1,i}{1,5}{j,1})
                    plot3(ax,facedata3{1,i}{1,5}{j,1}{1,k}(1,:),facedata3{1,i}{1,5}{j,1}{1,k}(2,:),facedata3{1,i}{1,5}{j,1}{1,k}(3,:),'-o','color',cmap(j,:),'LineWidth',1,'MarkerSize',3,'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',cmap(j,:))
                end
            end
        end
    end
end


grid(ax,'off');
ax.Color = 'none';
axis equal
ax.Clipping = 'off';
set(ax,'XColor','none')
set(ax,'YColor','none')
set(ax,'ZColor','none')
set(ax,'DataAspectRatioMode','manual')
set(ax,'DataAspectRatio',[1 1 1])
set(ax,'PlotBoxAspectRatioMode','manual')
set(ax,'PlotBoxAspectRatio',[1 1 1])

plot3(ax,[WindingContour{1,:}],[WindingContour{2,:}],[WindingContour{3,:}])



for i=1:checklistlength

    %disp(['Remaing Contour Segments: ' num2str(checklistlength-i)]) 
    %disp(' ')
    [Nextface,Nextlevel,Nextcontour,Nextpoint]=Find_Next_Contour(facedata3,contourchecklist,EndX,EndY,EndZ,EndLevel);
    
    %disp(['Start: Face = ' num2str(Nextface) ' | Level = ' num2str(Nextlevel) ' | Contour = ' num2str(Nextpoint)])
    %disp(['     X = ' num2str(facedata3{1,Nextface}{1,5}{Nextlevel,1}{1,Nextcontour}(1,Nextpoint)) ', Y = ' num2str(facedata3{1,Nextface}{1,5}{Nextlevel,1}{1,Nextcontour}(2,Nextpoint)) ', Z = ' num2str(facedata3{1,Nextface}{1,5}{Nextlevel,1}{1,Nextcontour}(1,Nextpoint))])

    [WindingContour,EndX,EndY,EndZ,EndLevel]=AppendContour(WindingContour,facedata3,Nextface,Nextlevel,Nextcontour,Nextpoint);
    
    %disp(['End: X = ' num2str(EndX) ', Y = ' num2str(EndY) ', Z = ' num2str(EndZ)])
    %disp(' ')
    pause(0.01);

%     clf(fig)
%     
% 
% 
%     ax=axes(fig); 
%     grid(ax,'off');
%     ax.Color = 'none';
%     axis equal
%     ax.Clipping = 'off';
%     set(ax,'XColor','none')
%     set(ax,'YColor','none')
%     set(ax,'ZColor','none')
%     set(ax,'DataAspectRatioMode','manual')
%     set(ax,'DataAspectRatio',[1 1 1])
%     set(ax,'PlotBoxAspectRatioMode','manual')
%     set(ax,'PlotBoxAspectRatio',[1 1 1])
    
    
    plot3(ax,[WindingContour{1,:}],[WindingContour{2,:}],[WindingContour{3,:}],'-','color','k','LineWidth',1)
    
    
    contourchecklist{Nextface}{Nextlevel}{Nextcontour}=1;
end


    function [Contour_To_Append_To,LastX,LastY,LastZ,LastLevel]=AppendContour(Contour_To_Append_To,facedata3,Face,Level,Contour,Point)
        if(Point==1)
            StartToEnd=true;
            for index=Point:length(facedata3{1,Face}{1,5}{Level,1}{1,Contour})
                Contour_To_Append_To{1,end+1}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(1,index);
                Contour_To_Append_To{2,end}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(2,index);
                Contour_To_Append_To{3,end}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(3,index);
            end
        else
            StartToEnd =false;
            for index=Point:-1:1
                Contour_To_Append_To{1,end+1}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(1,index);
                Contour_To_Append_To{2,end}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(2,index);
                Contour_To_Append_To{3,end}=facedata3{1,Face}{1,5}{Level,1}{1,Contour}(3,index);
            end
        end
        LastLevel=Level;
        LastX=Contour_To_Append_To{1,end};
        LastY=Contour_To_Append_To{2,end};
        LastZ=Contour_To_Append_To{3,end};
        
    end

    function [Nexti,Nextj,Nextk,Nextp]=Find_Next_Contour(facedata3,contourchecklist,x,y,z,level)
        
        checker = 0;
        for faceindex=1:length(contourchecklist)
            if ~isempty(contourchecklist{faceindex})
                disp([ 'face = ' num2str(faceindex)])
                for levelindex=level-1:level+1
                    if length(contourchecklist{faceindex}) >= levelindex
                        if ~isempty(contourchecklist{faceindex}{levelindex})
                        disp([ 'level = ' num2str(levelindex)])
                            for contourindex=1:length(contourchecklist{faceindex}{levelindex})
                                if ~isempty(facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex})
                                disp([ 'contour = ' num2str(contourindex)])
                                    if(contourchecklist{faceindex}{levelindex}{contourindex}==0)
                                        %for pointsindex=1:length(facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex})
                                            if StartToEnd == true
                                                pointsindex = 1;
                                            else
                                                pointsindex = length(facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex});
                                            end

                                            checkdistance{1,faceindex}{1,5}{levelindex,1}{1,contourindex}=(x-facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex}(1,pointsindex))^2 + (y-facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex}(2,pointsindex))^2 + (z-facedata3{1,faceindex}{1,5}{levelindex,1}{1,contourindex}(3,pointsindex))^2;
                                            if (checker==0)
                                                checkdistancemin=checkdistance{1,faceindex}{1,5}{levelindex,1}{1,contourindex};
                                                prevcheckdistancemin=checkdistancemin;
                                                Nexti=faceindex;
                                                Nextj=levelindex;
                                                Nextk=contourindex; 
                                                Nextp=pointsindex;
                                                checker=1;
                                            end
                                            disp(checkdistance{1,faceindex}{1,5}{levelindex,1}{1,contourindex});
                                            checkdistancemin=min([checkdistancemin checkdistance{1,faceindex}{1,5}{levelindex,1}{1,contourindex}]);
                                            disp(checkdistancemin);
                                            if (checkdistancemin ~= prevcheckdistancemin)
                                                prevcheckdistancemin=checkdistancemin;
                                                Nexti=faceindex;
                                                Nextj=levelindex;
                                                Nextk=contourindex; 
                                                Nextp=pointsindex;
                                            end
                                        %end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

end