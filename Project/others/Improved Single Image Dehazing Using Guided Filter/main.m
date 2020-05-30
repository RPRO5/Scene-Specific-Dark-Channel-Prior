%% Set Parameters
clear all;clc;
traindataPath = './Dataset/';
trainData = imageSet(traindataPath,'recursive');
newSize = 500; %Size of the image
OutputPath = './Results/visibresto2/';
% GroundTruth = imageSet('GroundTruth','recursive');
% 
% img1 = read(trainData,1);
% imshow(img1)
% path = char(trainData.ImageLocation(1));
% [~,name,~] = fileparts(path) ;

for count = 1:trainData.Count
    img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;
    %% Pre-Processing
    img = imresize(img, [newSize,newSize]);
    img = double(img);   %convert image into double class
	img = img./255;        %normalize the pixels to whole range between [0,1]

	%% Fog removal
    sv=2*floor(max(size(img))/50)+1;
    % ICCV'2009 paper result (NBPC)
%     res=nbpc(im,sv,0.95,0.5,1,1.3);
%     figure;imshow([im, res],[0,1]);
    % IV'2010 paper result (NBPC+PA)
    res2=nbpcpa(img,sv,0.95,0.5,1,1.3,205,300);
%     figure;imshow([im, res2],[0,1]);
%% Save Image
    savepath = strcat(OutputPath,imgname, '.png');
%     savepath = strcat(OutputPath,imgname, '.jpg');
    imwrite(res2,savepath);
    
end