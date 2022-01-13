%To detect Mouth

clc;
blink = VideoReader('heart.mp4');%Create object to read video files
for img = 1:10

I = read(blink,img);
%I = imrotate(I,90);
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',120);%Detect objects using the Viola-Jones algorithm
BB=step(MouthDetect,I);%step calculates the step response of a dynamic system
figure,
imshow(I); hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
title('Mouth Detection');
hold off;
end
