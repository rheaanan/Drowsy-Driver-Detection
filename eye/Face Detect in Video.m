clc;
blink = VideoReader('blink.mp4');
for img = 1:blink.NumberOfFrames; 
    b = read(blink, img);
    FDetect = vision.CascadeObjectDetector;
    I = b;
    BB = step(FDetect,I);
    figure,
    %imshow(I); hold on
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
   
end
