clc;%clear window
clear;%clear workspace
disp(toolboxdir('vision'))
setDir  = fullfile(toolboxdir('vision'),'visiondata','imgset');
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');%create image datastore object to store collection of images
[trainingSet,testSet] = splitEachLabel(imds,0.3,'randomize'); % Use splitEachLabel method to trim the set.
bag = bagOfFeatures(trainingSet); %bag here is used as a cistom feature extractor
categoryClassifier = trainImageCategoryClassifier(trainingSet,bag); %Train an image category classifier
confMatrix = evaluate(categoryClassifier,testSet)
mean(diag(confMatrix))
opencnt = 0;
closecnt = 0;
blink = VideoReader('blinkpls.mp4');%Create object to read video files
for img = 23:23
    b = read(blink, img);
    %b = imrotate(b,90);
    FDetect = vision.CascadeObjectDetector; %Detect objects using the Viola-Jones algorithm
    I = b;
    BB = step(FDetect,I);%step calculates the step response of a dynamic system
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));
        imshow(J);hold on
        J = im2bw(J);%Convert image to binary image, based on threshold
    end
    J = im2uint8(I);%Convert image to 8-bit unsigned integers
        
        img = J;
        [labelIdx, score] = predict(categoryClassifier,img);
        categoryClassifier.Labels(labelIdx)
        if labelIdx == 1
            closecnt = closecnt +1;
            opencnt = 0;
            
        end
        if labelIdx == 2
            opencnt = opencnt +1;
            closecnt = 0;
            
        end
        
        if closecnt > 5
            disp("sleepy");
        end
        
end