classdef ContourEditorApp < matlab.apps.AppBase
    
    
    % Properties that correspond to app components
    properties (Access = public)
        UIFigure    matlab.ui.Figure
        UIAxes      matlab.ui.control.UIAxes
        DeleteSelectedContourPointsButton  matlab.ui.control.Button
        SplitContourButton  matlab.ui.control.Button
        JoinContourButton  matlab.ui.control.Button
        ResetContoursButton  matlab.ui.control.Button
        LevelListBoxLabel  matlab.ui.control.Label
        LevelListBox       matlab.ui.control.ListBox
        ContourListBoxLabel  matlab.ui.control.Label
        ContourListBox       matlab.ui.control.ListBox
        BackgroundPlotButtonGroup  matlab.ui.container.ButtonGroup
        PolyFitButton              matlab.ui.control.RadioButton
        InterpolateButton          matlab.ui.control.RadioButton
        ConfirmButton   matlab.ui.control.Button
        Contours
        ResetContoursBackup
        Levels
        X
        Y
        Vm
        Face
        NumFaces
        ConvexHullIdx
        VmMargin
        ContourHandles
        JoinCheck
        join1_i
        join1_j
        join1_brushed_x
        join1_brushed_y
        join2_i
        join2_j
        join2_brushed_x
        join2_brushed_y
        join1startend
        join2startend
    end

    % Callbacks that handle component events
    methods (Access = private)
        
        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            global modified_contours
            modified_contours = app.Contours;
            delete(app)
            
        end
        
        
        % Selection changed function: BackgroundPlotButtonGroup
        function BackgroundPlotButtonGroupSelectionChanged(app, event)
            app.ContourHandles={[]};
            cla(app.UIAxes);
            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            
            valueLevel = app.LevelListBox.Value;
            valueCont = app.ContourListBox.Value;
            
            selLevel=str2double(valueLevel);
            
            if strcmp(valueLevel,'ALL')
                for j = 1:length(app.Levels)
                    for k = 1:length(app.Contours{j}) 
                        exx = app.Contours{j}{k}(1,:);
                        eye = app.Contours{j}{k}(2,:);
                        app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                    end
                end
            else
                if strcmp(valueCont,'ALL')
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                exx = app.Contours{j}{k}(1,:);
                                eye = app.Contours{j}{k}(2,:);
                                app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                            end
                        end
                    end
                else 
                    selCont=str2num(valueCont);
                    disp(valueCont)
                    disp(selCont)
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                if k == selCont
                                    exx = app.Contours{j}{k}(1,:);
                                    eye = app.Contours{j}{k}(2,:);
                                    app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                                end  
                            end
                        end 
                    end
                end
            end
   
            hold(app.UIAxes,'off');

        end
        
        % Value changed function: LevelListBox
        function LevelListBoxValueChanged(app, event)
            valueLevel = app.LevelListBox.Value;
            
            app.ContourHandles={[]};
            cla(app.UIAxes);
            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)


            if strcmp(valueLevel,'ALL')
                
                            app.SplitContourButton.Enable = 'off';
                            
                app.ContourListBox.Items={};

                for j = 1:length(app.Levels)
                    for k = 1:length(app.Contours{j}) 
                            exx = app.Contours{j}{k}(1,:);
                            eye = app.Contours{j}{k}(2,:);
                            app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                    end
                end
                
 
            else    
                for j = 1:length(app.Levels)
                     if strcmp(num2str(app.Levels(j)),valueLevel)
                        if length(app.Contours{j})==1
                            app.SplitContourButton.Enable = 'on';
                            app.ContourListBox.Items={'1'};
                            app.ContourListBox.Value='1';
                            exx = app.Contours{j}{1}(1,:);
                            eye = app.Contours{j}{1}(2,:);
                            app.ContourHandles{j}{1}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                        else
                            app.SplitContourButton.Enable = 'off';
                            app.ContourListBox.Items={'ALL'};
                            idx=2;
                            for k = 1:length(app.Contours{j}) 
                                exx = app.Contours{j}{k}(1,:);
                                eye = app.Contours{j}{k}(2,:);
                                app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                                app.ContourListBox.Items{idx}=num2str(k);
                                idx=idx+1;
                            end

                        end
                    end
                end   

            end
            
           hold(app.UIAxes,'off')

        end
        
        % Value changed function: ContourListBox
        function ContourListBoxValueChanged(app, event)
            valueCont = app.ContourListBox.Value;
            valueLevel = app.LevelListBox.Value;
            
            app.ContourHandles={[]};

            cla(app.UIAxes);
            hold(app.UIAxes,'on')

            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            
            selLevel=str2double(valueLevel);
            if strcmp(valueCont,'ALL')
                app.SplitContourButton.Enable = 'off';
                for j = 1:length(app.Levels)
                    if strcmp(num2str(app.Levels(j)),valueLevel)
                        for k = 1:length(app.Contours{j}) 
                            exx = app.Contours{j}{k}(1,:);
                            eye = app.Contours{j}{k}(2,:);
                            app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                        end
                    end
                end
            else  
                app.SplitContourButton.Enable = 'on';
                selCont=str2num(valueCont);
                for j = 1:length(app.Levels)
                    if strcmp(num2str(app.Levels(j)),valueLevel)
                        for k = 1:length(app.Contours{j}) 
                            if k == selCont
                                exx = app.Contours{j}{k}(1,:);
                                eye = app.Contours{j}{k}(2,:);
                                app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                            end  
                        end
                    end 
                end
            end
            
           hold(app.UIAxes,'off')
            
        end
        
        % Button pushed function: ResetContoursButtonPushed
        function ResetContoursButtonPushed(app, event)
            app.Contours=app.ResetContoursBackup;
            
            app.ContourHandles={[]};
            
            cla(app.UIAxes);


            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            
            app.LevelListBox.Value='ALL';
            app.ContourListBox.Items={''};           
            app.ContourListBox.Value='';


            for j = 1:length(app.Levels)
                for k = 1:length(app.Contours{j}) 
                    exx = app.Contours{j}{k}(1,:);
                    eye = app.Contours{j}{k}(2,:);
                    app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                end
            end
    
            hold(app.UIAxes,'off')

            app.SplitContourButton.Enable = 'off';

        end
        
        % Button pushed function: ConfirmButtonPushed
        function ConfirmButtonPushed(app, event)
            UIFigureCloseRequest(app,event);   
        end
        
        % Button pushed function: SplitContourButtonPushed
        function SplitContourButtonPushed(app, event)

            valueLevel = app.LevelListBox.Value;
            selLevel=str2double(valueLevel);
            valueCont = app.ContourListBox.Value;
            selCont = str2num(valueCont);
            
            for i=1:length(app.Levels)
                if strcmp(valueLevel,num2str(app.Levels(i)))
                    for j=1:length(app.Contours{i})
                        if selCont == j
                            disp(['i = ',num2str(i)])
                            Handle = app.ContourHandles{i}{j};
                            xd = get(Handle, 'XData');
                            yd = get(Handle, 'YData');
                            brushing = logical(get(Handle, 'BrushData'));
                            %disp(brushing);
                            p=1;
                            delta=0;
                            for q =1:length(brushing)
                                if q~=1
                                    delta=brushing(q)-brushing(q-1);
                                    if delta == 1
                                        start=q;
                                    elseif delta == -1
                                        stop=q;
                                    end
                                end
                            end
                           
                            nbrushed = sum(brushing);
                            disp(nbrushed);
                            brushed_xd = xd(~brushing);
                            brushed_x1 = brushed_xd(1:start-nbrushed);
                            brushed_x2 = brushed_xd(stop-nbrushed:length(brushed_xd));                            
                            brushed_yd = yd(~brushing);
                            brushed_y1 = brushed_yd(1:start-nbrushed);
                            brushed_y2 = brushed_yd(stop-nbrushed:length(brushed_yd)); 
                            
                            app.Contours{i}{j}=[];
                            app.Contours{i}{j}=zeros(2,length(brushed_x1));
                            app.Contours{i}{j}(1,:)=brushed_x1;
                            app.Contours{i}{j}(2,:)=brushed_y1;

                            app.Contours{i}{j+1}=[];
                            app.Contours{i}{j+1}=zeros(2,length(brushed_x2));
                            app.Contours{i}{j+1}(1,:)=brushed_x2;
                            app.Contours{i}{j+1}(2,:)=brushed_y2;
   
                        end
                    end
                end
            end
            
            app.ContourListBox.Items={'ALL'};
            idx=2;
            for j=1:length(app.Levels)
                if strcmp(valueLevel,num2str(app.Levels(j)))
                    for k = 1:length(app.Contours{j}) 
                        app.ContourListBox.Items{idx}=num2str(k);
                        idx=idx+1;
                    end
                end
            end
            app.ContourListBox.Value='ALL';
            
            app.ContourHandles={[]};
            
            cla(app.UIAxes);

            
            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            
            valueLevel = app.LevelListBox.Value;
            valueCont = app.ContourListBox.Value;
            
            selLevel=str2double(valueLevel);
            
            if strcmp(valueLevel,'ALL')
                for j = 1:length(app.Levels)
                    for k = 1:length(app.Contours{j}) 
                        exx = app.Contours{j}{k}(1,:);
                        eye = app.Contours{j}{k}(2,:);
                        app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                    end
                end
            else
                if strcmp(valueCont,'ALL')
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                exx = app.Contours{j}{k}(1,:);
                                eye = app.Contours{j}{k}(2,:);
                                app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                            end
                        end
                    end
                else 
                    selCont=str2num(valueCont);
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                if k == selCont
                                    exx = app.Contours{j}{k}(1,:);
                                    eye = app.Contours{j}{k}(2,:);
                                    app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                                end  
                            end
                        end 
                    end
                end
            end
   
            hold(app.UIAxes,'off')
            
        end

        % Button pushed function: JoinContourButtonPushed
        function JoinContourButtonPushed(app, event)
            app.JoinCheck=app.JoinCheck+1;
            if(app.JoinCheck == 1)
                for i = 1:length(app.ContourHandles)
                    if ~isempty(app.ContourHandles{i})
                        for j=1:length(app.ContourHandles{i})
                            if ~isempty(app.ContourHandles{i}{j})
                                disp(['i = ',num2str(i)])
                                Handle = app.ContourHandles{i}{j};
                                xd = get(Handle, 'XData');
                                yd = get(Handle, 'YData');
                                brushing = logical(get(Handle, 'BrushData'));
                                if sum(brushing)>0
                                    if sum(brushing)>1
                                        break
                                    else
                                        if brushing(1) == 1
                                            app.join1startend=0;
                                            app.join1_i=i;
                                            app.join1_j=j;
                                            app.join1_brushed_x = xd(brushing);
                                            app.join1_brushed_y = yd(brushing);
                                        elseif brushing(end) == 1
                                            app.join1startend=1;
                                            app.join1_i=i;
                                            app.join1_j=j;
                                            app.join1_brushed_x = xd(brushing);
                                            app.join1_brushed_y = yd(brushing); 
                                        else
                                             warndlg('Can not join to middle of contour. Pick end points.', 'Error Message')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                TF = isempty(app.join1_brushed_x);
                if TF == 1
                    warndlg('No data marked. Draw over a data point with the mouse.', 'Error Message')
                    app.JoinCheck=0;
                    app.join1_i=[];
                    app.join1_j=[];
                    app.join1_brushed_x = [];
                    app.join1_brushed_y = [];
                    app.join2_i=[];
                    app.join2_j=[];
                    app.join2_brushed_x = [];
                    app.join2_brushed_y = [];
                    app.JoinContourButton.Text = 'Join Contour at Selection to...';
                else
                    app.JoinContourButton.Text = 'Join Contour to Previous Selection';
                end
            end
            
            if(app.JoinCheck == 2)
                for i = 1:length(app.ContourHandles)
                    if ~isempty(app.ContourHandles{i})
                        for j=1:length(app.ContourHandles{i})
                            if ~isempty(app.ContourHandles{i}{j})
                                disp(['i = ',num2str(i)])
                                Handle = app.ContourHandles{i}{j};
                                xd = get(Handle, 'XData');
                                yd = get(Handle, 'YData');
                                brushing = logical(get(Handle, 'BrushData'));
                                if sum(brushing)>0
                                    if sum(brushing)>1
                                        break
                                    else
                                        if brushing(1) == 1
                                            app.join2startend=0;
                                            app.join2_i=i;
                                            app.join2_j=j;
                                            app.join2_brushed_x = xd(brushing);
                                            app.join2_brushed_y = yd(brushing);
                                        elseif brushing(end) == 1
                                            app.join2startend=1;
                                            app.join2_i=i;
                                            app.join2_j=j;
                                            app.join2_brushed_x = xd(brushing);
                                            app.join2_brushed_y = yd(brushing);
                                        else
                                            warndlg('Can not join to middle of contour. Pick end points.', 'Error Message')
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                TF = isempty(app.join1_brushed_x);
                if TF == 1
                    warndlg('No data marked. Draw over a data point with the mouse.', 'Error Message')
                    app.JoinCheck=0;
                    app.join1_i=[];
                    app.join1_j=[];
                    app.join1_brushed_x = [];
                    app.join1_brushed_y = [];
                    app.join2_i=[];
                    app.join2_j=[];
                    app.join2_brushed_x = [];
                    app.join2_brushed_y = [];
                    app.JoinContourButton.Text = 'Join Contour at Selection to...';

                else
                    temp1 = app.Contours{app.join1_i}{app.join1_j};
                    temp2 = app.Contours{app.join2_i}{app.join2_j};
                    disp(temp1(1,:))
                    disp(temp1(2,:))
                    disp(temp2(1,:))
                    disp(temp2(2,:))
                    if app.join1startend == 0
                        if app.join2startend == 0
                            app.Contours{app.join1_i}{app.join1_j}=[];
                            app.Contours{app.join2_i}{app.join2_j}=[];
                            app.Contours{app.join1_i}{app.join1_j}=zeros(2,length(temp1)+length(temp2));
                            app.Contours{app.join1_i}{app.join1_j}(1,:)=[flip(temp1(1,:)) temp2(1,:)];
                            app.Contours{app.join1_i}{app.join1_j}(2,:)=[flip(temp1(2,:)) temp2(2,:)];
                            
                        elseif app.join2startend == 1 
                            app.Contours{app.join1_i}{app.join1_j}=[];
                            app.Contours{app.join2_i}{app.join2_j}=[];
                            app.Contours{app.join1_i}{app.join1_j}=zeros(2,length(temp1)+length(temp2));
                            app.Contours{app.join1_i}{app.join1_j}(1,:)=[flip(temp1(1,:)) flip(temp2(1,:))];
                            app.Contours{app.join1_i}{app.join1_j}(2,:)=[flip(temp1(2,:)) flip(temp2(2,:))];

                        end
                    elseif app.join1startend == 1
                        if app.join2startend == 0
                            app.Contours{app.join1_i}{app.join1_j}=[];
                            app.Contours{app.join2_i}{app.join2_j}=[];
                            app.Contours{app.join1_i}{app.join1_j}=zeros(2,length(temp1)+length(temp2));
                            app.Contours{app.join1_i}{app.join1_j}(1,:)=[temp1(1,:) temp2(1,:)];
                            app.Contours{app.join1_i}{app.join1_j}(2,:)=[temp1(2,:) temp2(2,:)];
                            disp(app.Contours{app.join1_i}{app.join1_j})

                        elseif app.join2startend == 1
                            app.Contours{app.join1_i}{app.join1_j}=[];
                            app.Contours{app.join2_i}{app.join2_j}=[];
                            app.Contours{app.join1_i}{app.join1_j}=zeros(2,length(temp1)+length(temp2{app.join2_i}{app.join2_j}));
                            app.Contours{app.join1_i}{app.join1_j}(1,:)=[temp1(1,:) flip(temp2(1,:))];
                            app.Contours{app.join1_i}{app.join1_j}(2,:)=[temp1(2,:) flip(temp2(2,:))];
                            
                        end
                    end
                    
                    if length(app.Contours{app.join2_i}) == 1
                        app.Contours{app.join2_i}=[];  
                    end

                    if ~isempty(app.Contours{app.join2_i})
                        if length(app.Contours{app.join2_i})==1
                           if ~isempty(app.Contours{app.join2_i}{1})
                               app.Contours{app.join2_i}=[];
                           end
                        end
                    end
                    disp(['Join1 : ' app.Contours{app.join1_i}])
                    disp(['Join2 : ' app.Contours{app.join2_i}])
                    if ~isempty(app.Contours{app.join2_i})
                        app.Contours{app.join2_i}=app.Contours{app.join2_i}(~cellfun('isempty',app.Contours{app.join2_i}));
                    end

                    levellistCell={'ALL'};
                    j=2;
                    for i = 1:length(app.Levels)
                        if ~isempty(app.Contours{i})
                            levellistCell{j}=num2str(app.Levels(i));
                            j=j+1;
                        end
                    end
                    app.LevelListBox.Items = levellistCell;
                    app.LevelListBox.Value = levellistCell{1};
                    
                    hold(app.UIAxes,'on')

                    xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
                    yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
                    [contX,contY]=meshgrid(xvec,yvec);

                    selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
                    if strcmp(selectedButton.Text,'Poly Fit')
                        fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                        contZ=fitobj(contX,contY);
                    elseif strcmp(selectedButton.Text,'Interpolate')
                        contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
                    end

                    [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
                    set(h,'LineColor','none')
                    cb = colorbar(app.UIAxes);
                    cb.Color = [1,1,1];     

                    plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

                    for j = 1:length(app.Levels)
                        if ~isempty(app.Contours{j})
                                for k = 1:length(app.Contours{j}) 
                                    level=app.Levels(j);
                                    exx = app.Contours{j}{k}(1,:);
                                    eye = app.Contours{j}{k}(2,:);
                                    app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                                end
                        end
                    end


                    %brush('on')

                    hold(app.UIAxes,'off')
                    
                    app.JoinCheck=0;
                    app.join1_i=[];
                    app.join1_j=[];
                    app.join1_brushed_x = [];
                    app.join1_brushed_y = [];
                    app.join2_i=[];
                    app.join2_j=[];
                    app.join2_brushed_x = [];
                    app.join2_brushed_y = [];
                    app.JoinContourButton.Text = 'Join Contour at Selection to...';
    
                end
            end
        
            
        
        end

        % Button pushed function: DeleteSelectedContourPointsButton
        function DeleteSelectedContourPointsButtonPushed(app, event)
            for i = 1:length(app.ContourHandles)
                if ~isempty(app.ContourHandles{i})
                    for j=1:length(app.ContourHandles{i})
                        if ~isempty(app.ContourHandles{i}{j})
                            disp(['i = ',num2str(i)])
                            Handle = app.ContourHandles{i}{j};
                            xd = get(Handle, 'XData');
                            yd = get(Handle, 'YData');
                            brushing = logical(get(Handle, 'BrushData'));
                            %disp(brushing);
                            brushed_x = xd(~brushing);
                            brushed_y = yd(~brushing);
                            disp(brushed_x)
                            app.Contours{i}{j}=[];
                            app.Contours{i}{j}=zeros(2,length(brushed_x));
                            app.Contours{i}{j}(1,:)=brushed_x;
                            app.Contours{i}{j}(2,:)=brushed_y;

    %             TF = isempty(brushedData);
    %             if TF == 1
    %                 errordlg('No data marked. Draw over the data points with the mouse.', 'Error Message')
    %             else
                        end
                    end
                end
            end
            app.ContourHandles={[]};
            
            cla(app.UIAxes);

            
            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            
            valueLevel = app.LevelListBox.Value;
            valueCont = app.ContourListBox.Value;
            
            selLevel=str2double(valueLevel);
            
            if strcmp(valueLevel,'ALL')
                for j = 1:length(app.Levels)
                    for k = 1:length(app.Contours{j}) 
                        exx = app.Contours{j}{k}(1,:);
                        eye = app.Contours{j}{k}(2,:);
                        app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                    end
                end
            else
                if strcmp(valueCont,'ALL')
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                exx = app.Contours{j}{k}(1,:);
                                eye = app.Contours{j}{k}(2,:);
                                app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                            end
                        end
                    end
                else 
                    selCont=str2num(valueCont);
                    for j = 1:length(app.Levels)
                        if strcmp(num2str(app.Levels(j)),valueLevel)
                            for k = 1:length(app.Contours{j}) 
                                if k == selCont
                                    exx = app.Contours{j}{k}(1,:);
                                    eye = app.Contours{j}{k}(2,:);
                                    app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                                end  
                            end
                        end 
                    end
                end
            end
   
            hold(app.UIAxes,'off')

        end

    end

    
    
    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1080 800];
            app.UIFigure.Name = 'Contour Editor';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);
            set(app.UIFigure,'Color',[42/255,48/255,53/255])
            
            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, ['Face ' num2str(app.Face) ' of ' num2str(app.NumFaces)])
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Position = [15 150 1000 550];
            set(app.UIAxes,'BackgroundColor',[42/255,48/255,53/255])
            set(app.UIAxes,'Color',[71/255,77/255,83/255])
            set(app.UIAxes,'XColor',[255/255,255/255,255/255])
            set(app.UIAxes,'YColor',[255/255,255/255,255/255])
            set(app.UIAxes.Title,'Color',[255/255,255/255,255/255])
           
            
            % Create LevelListBoxLabel
            app.LevelListBoxLabel = uilabel(app.UIFigure);
            app.LevelListBoxLabel.HorizontalAlignment = 'right';
            app.LevelListBoxLabel.Position = [80 115 30 20];
            app.LevelListBoxLabel.Text = 'Level';
            app.LevelListBoxLabel.FontColor = [255/255,255/255,255/255];
            
            levellistCell={'ALL'};
            j=2;
            for i = 1:length(app.Levels)
                if ~isempty(app.Contours{i})
                    levellistCell{j}=num2str(app.Levels(i));
                    j=j+1;
                end
            end

                        
            % Create LevelListBox
            app.LevelListBox = uilistbox(app.UIFigure);
            app.LevelListBox.Items = levellistCell;
            app.LevelListBox.ValueChangedFcn = createCallbackFcn(app, @LevelListBoxValueChanged, true);
            app.LevelListBox.Position = [80 65 100 50];
            app.LevelListBox.Value = levellistCell{1};
            
            % Create ContourListBoxLabel
            app.ContourListBoxLabel = uilabel(app.UIFigure);
            app.ContourListBoxLabel.HorizontalAlignment = 'right';
            app.ContourListBoxLabel.Position = [210 115 45 20];
            app.ContourListBoxLabel.Text = 'Contour';
            app.ContourListBoxLabel.FontColor = [255/255,255/255,255/255];

            
            % Create ContourListBox
            app.ContourListBox = uilistbox(app.UIFigure);
            app.ContourListBox.Items = {''};
            app.ContourListBox.ValueChangedFcn = createCallbackFcn(app, @ContourListBoxValueChanged, true);
            app.ContourListBox.Position = [210 65 100 50];
            app.ContourListBox.Value = '';

            
            % Create DeleteSelectedContourPointsButton
            app.DeleteSelectedContourPointsButton = uibutton(app.UIFigure, 'push');
            app.DeleteSelectedContourPointsButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteSelectedContourPointsButtonPushed, true);
            app.DeleteSelectedContourPointsButton.Position = [575 90 185 22];
            app.DeleteSelectedContourPointsButton.Text = 'Delete Selected Contour Points';
   
            % Create SplitContourButton
            app.SplitContourButton = uibutton(app.UIFigure, 'push');
            app.SplitContourButton.ButtonPushedFcn = createCallbackFcn(app, @SplitContourButtonPushed, true);
            app.SplitContourButton.Position = [825 90 180 30];
            app.SplitContourButton.Text = 'Split Contour at Selection';
            app.SplitContourButton.Enable = 'off';
            
            % Create JoinContourButton
            app.JoinContourButton = uibutton(app.UIFigure, 'push');
            app.JoinContourButton.ButtonPushedFcn = createCallbackFcn(app, @JoinContourButtonPushed, true);
            app.JoinContourButton.Position = [825 55 195 30];
            app.JoinContourButton.Text = 'Join Contour at Selection to...';
            
            % Create ResetContoursButton
            app.ResetContoursButton = uibutton(app.UIFigure, 'push');
            app.ResetContoursButton.ButtonPushedFcn = createCallbackFcn(app, @ResetContoursButtonPushed, true);
            app.ResetContoursButton.Position = [140 15 115 25];
            app.ResetContoursButton.Text = 'Reset All Contours';
            
            % Create ConfirmButton
            app.ConfirmButton = uibutton(app.UIFigure, 'push');
            app.ConfirmButton.ButtonPushedFcn = createCallbackFcn(app, @ConfirmButtonPushed, true);
            app.ConfirmButton.Position = [950 15 115 25];
            app.ConfirmButton.Text = 'Confirm Contours';
                        
            % Create BackgroundPlotButtonGroup
            app.BackgroundPlotButtonGroup = uibuttongroup(app.UIFigure);
            app.BackgroundPlotButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @BackgroundPlotButtonGroupSelectionChanged, true);
            app.BackgroundPlotButtonGroup.Title = 'Background Plot';
            app.BackgroundPlotButtonGroup.Position = [400 15 123 106];

            % Create PolyFitButton
            app.PolyFitButton = uiradiobutton(app.BackgroundPlotButtonGroup);
            app.PolyFitButton.Text = 'Poly Fit';
            app.PolyFitButton.Position = [11 60 62 22];
            app.PolyFitButton.Value = true;

            % Create InterpolateButton
            app.InterpolateButton = uiradiobutton(app.BackgroundPlotButtonGroup);
            app.InterpolateButton.Text = 'Interpolate';
            app.InterpolateButton.Position = [11 38 79 22];
            
            % Show the figure after all components are created
            
            hold(app.UIAxes,'on')
            
            xvec=linspace(min(app.X)-app.VmMargin,max(app.X)+app.VmMargin);
            yvec=linspace(min(app.Y)-app.VmMargin,max(app.Y)+app.VmMargin);
            [contX,contY]=meshgrid(xvec,yvec);
            
            selectedButton = app.BackgroundPlotButtonGroup.SelectedObject;
            if strcmp(selectedButton.Text,'Poly Fit')
                fitobj=fit([app.X.',app.Y.'],app.Vm,'poly33');
                contZ=fitobj(contX,contY);
            elseif strcmp(selectedButton.Text,'Interpolate')
                contZ=griddata(app.X.',app.Y.',app.Vm,contX,contY);
            end

            [~,h]=contourf(app.UIAxes,contX,contY,contZ,30);
            set(h,'LineColor','none')
            cb = colorbar(app.UIAxes);
            cb.Color = [1,1,1];     
            
            plot(app.UIAxes,app.X(app.ConvexHullIdx), app.Y(app.ConvexHullIdx),'--k','LineWidth',2)

            for j = 1:length(app.Levels)
                if ~isempty(app.Contours{j})
                        for k = 1:length(app.Contours{j}) 
                            level=app.Levels(j);
                            exx = app.Contours{j}{k}(1,:);
                            eye = app.Contours{j}{k}(2,:);
                            app.ContourHandles{j}{k}=plot(app.UIAxes,exx,eye,'-o','color','k','LineWidth',1.5,'MarkerSize',5,'MarkerFaceColor',[1,1,1]);
                        end
                end
            end
            
                
            %brush('on')
            
            hold(app.UIAxes,'off')
            
            brush(app.UIAxes, 'on');

            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ContourEditorApp(contours_input,levels_input,x_input,y_input,Vm_input,face_input,numfaces_input)
            app.Contours = contours_input;
            app.ResetContoursBackup=contours_input;
            app.Levels = levels_input;
            app.X = x_input;
            app.Y = y_input;
            app.Vm = Vm_input;
            app.Face = face_input;
            app.NumFaces = numfaces_input;
            app.ConvexHullIdx=convhull(app.X,app.Y);
            app.VmMargin=0.01;
            app.JoinCheck=0;
            app.join1_i=[];
            app.join1_j=[];
            app.join1_brushed_x = [];
            app.join1_brushed_y = [];
            app.join2_i=[];
            app.join2_j=[];
            app.join2_brushed_x = [];
            app.join2_brushed_y = [];

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end