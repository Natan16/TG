h = Aero.Animation;
h.FramesPerSecond = 10;
h.TimeScaling = 5;
%delta2.ac lembra o VLS ac3d_xyzisrgb.ac
idx1 = h.createBody('delta2.ac','Ac3d');
idx2 = h.createBody('delta2.ac','Ac3d');
load simdata
load fltdata
h.Bodies{2}.TimeseriesReadFcn = @CustomReadBodyTSData;
h.Bodies{1}.TimeSeriesSource = simdata;
h.Bodies{2}.TimeSeriesSource = fltdata;
h.Bodies{2}.TimeSeriesSourceType = 'Custom';
h.Camera.PositionFcn = @staticCameraPosition;
h.Camera.ViewExtent = [-50,50] ;
%This code illustrates how to move the bodies to the starting position
%(based on timeseries data) and update the camera position according to the
%new 'PositionFcn'. This code uses updateBodies and updateCamera.
t = 0;
h.updateBodies(t);
h.updateCamera(t);
%create transparency in the first body
patchHandles2 = h.Bodies{1}.PatchHandles;
desiredFaceTransparency = .3;
desiredEdgeTransparency = 1;
for k = 1:size(patchHandles2,1)
    tempFaceAlpha = get(patchHandles2(k),'FaceVertexAlphaData');
    tempEdgeAlpha = get(patchHandles2(k),'EdgeAlpha');
	set(patchHandles2(k),...
        'FaceVertexAlphaData',repmat(desiredFaceTransparency,size(tempFaceAlpha)));
    set(patchHandles2(k),...
        'EdgeAlpha',repmat(desiredEdgeTransparency,size(tempEdgeAlpha)));
end
%change body color of the second body
patchHandles3 = h.Bodies{2}.PatchHandles;
desiredColor = [1 1 1];
for k = 1:size(patchHandles3,1)
    tempFaceColor = get(patchHandles3(k),'FaceVertexCData');
    tempName = h.Bodies{2}.Geometry.FaceVertexColorData(k).name;
    if isempty(strfind(tempName,'Windshield')) &&...
       isempty(strfind(tempName,'front-windows')) &&...
       isempty(strfind(tempName,'rear-windows'))
    set(patchHandles3(k),...
        'FaceVertexCData',repmat(desiredColor,[size(tempFaceColor,1),1]));
    end
end
for k = 1:size(patchHandles3)
    set(patchHandles3(k),'Visible','off')
end
%sem o 1º estágio
for k = [1:8 , 12]
    set(patchHandles2(k),'Visible','off')
end
%com o 1º estágio 
%{
for k = [1,3,5,7,12]
    set(patchHandles2(k),'Visible','off')
end
%}
h.show();
h.VideoRecord = 'on';
h.VideoQuality = 50;
h.VideoCompression = 'Motion JPEG AVI'
h.VideoFilename = 'astMotion_JPEG';
h.play();
h.VideoRecord = 'off';

