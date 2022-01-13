disp(toolboxdir('vision'))
setDir  = fullfile(toolboxdir('vision'),'visiondata','imageSets');
imds = imageDatastore(setDir,'IncludeSubfolders',true,'LabelSource',...
    'foldernames');%create image datastore object to store collection of images
[trainingSet,testSet] = splitEachLabel(imds,0.3,'randomize');
bag = bagOfFeatures(trainingSet);%bag here is used as a cistom feature extractor
categoryClassifier = trainImageCategoryClassifier(trainingSet,bag);
confMatrix = evaluate(categoryClassifier,testSet)
mean(diag(confMatrix))
opencnt = 0;
closecnt = 0;
blink = VideoReader('heart.mp4');%Create object to read video files
for img = 300:305
    b = read(blink, img);
    %b = imrotate(b,90);
    FDetect = vision.CascadeObjectDetector;%Detect objects using the Viola-Jones algorithm
    I = b;
    BB = step(FDetect,I);%step calculates the step response of a dynamic system
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));
    end  

 EyeDetect = vision.CascadeObjectDetector('EyePairBig');
    BB=step(EyeDetect,I);
    figure,imshow(I);

    for i = 1:size(BB,1)
        aaa = rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    end
    title('Eyes Detection');

    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));        
        J = imadjust(J,stretchlim(J),[]);%Adjust image intensity values or colormapcollapse
        J = im2bw(J, 0.2);%Convert image to binary image, based on threshold
        J = im2uint8(J);%Convert image to 8-bit unsigned integers
        
        img = J;
        imshow(J);
        [labelIdx, score] = predict(categoryClassifier,img);%Predict labels using discriminant analysis classification model
        categoryClassifier.Labels(labelIdx)
        if labelIdx == 1
            closecnt = closecnt +1;
            opencnt = 0;
            
        end
        if labelIdx == 2
            opencnt = opencnt +1;
            closecnt = 0;
            
        end
        
        if closecnt > 1
            disp("sleepy");
        end
        
       
    end
end