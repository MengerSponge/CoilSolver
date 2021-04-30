function facedata3 = AffineRestoreAllFaces(facedata)

% facedata3 = affineRestoreAllFaces(facedata)
% 
% Uses the transformation matrix 'M' returned by affine transform to cycle
% through all faces in facedata and restore the contours to 3D space
% 
% KES 2020.11.02

Vmin=-0.64;
Vmax=0.64;
nlevels=129;
levels = linspace(Vmin,Vmax,nlevels);

facedatasize=size(facedata);
facecounter=facedatasize(2);

facedata3=facedata;

for i=1:facecounter
   tempsize=size(facedata{1,i}{1,5});
   contoursize{i}=zeros(tempsize(1),1);
   for j=1:tempsize(1)
       disp(['face = ' num2str(i) ' | level = ' num2str(j)])
        if isempty(facedata{1,i}{1,5}{j,1})
            disp('EMPTY LEVEL!')
            contoursize{1,i}(j,1)=0;
        else
            disp('NON-EMPTY LEVEL!')
            contoursize{1,i}(j,1)=1;
        end
   
   end
end

fig=figure('Visible','on');
ax=axes(fig);  
hold(ax,'on');
cmap = parula(length(levels));

for i=1:facecounter
    numOfContours=size(contoursize{1,1});
    %jdx=1;
    for j=1:numOfContours(1)
        if contoursize{1,i}(j,1)==1
            facedata3{1,i}{1,5}{j,2} = levels(j);
            for k = 1:length(facedata{1,i}{1,5}{j,1})
                facedata3{1,i}{1,5}{j,1}{1,k}=affineRestore(facedata{1,i}{1,5}{j,1}{1,k}(1,:),facedata{1,i}{1,5}{j,1}{1,k}(2,:),facedata{1,i}{1,4});
                plot3(ax,facedata3{1,i}{1,5}{j,1}{1,k}(1,:),facedata3{1,i}{1,5}{j,1}{1,k}(2,:),facedata3{1,i}{1,5}{j,1}{1,k}(3,:),'-o','color','k','LineWidth',1,'MarkerSize',2,'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',cmap(j,:))
                %jdx=jdx+1;
            end
        end
    end
end

view(3);
hold(ax,'off');
grid(ax,'off');
ax.Color = 'none';
axis equal
ax.Clipping = 'off';
set(ax,'XColor','none')
set(ax,'YColor','none')
set(ax,'ZColor','none')
% set(gca,'xtick',[])
% set(gca,'xticklabel',[])
% set(gca,'ytick',[])
% set(gca,'yticklabel',[])
% set(gca,'ztick',[])
% set(gca,'zticklabel',[])
set(ax,'DataAspectRatioMode','manual')
set(ax,'DataAspectRatio',[1 1 1])
set(ax,'PlotBoxAspectRatioMode','manual')
set(ax,'PlotBoxAspectRatio',[1 1 1])

