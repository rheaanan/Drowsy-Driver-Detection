clc;	%Clears Console
blink = VideoReader('meyawn.mp4'); %Reads the video
count = 200	%Count for file name
for img = 1:50
    b = read(blink, img);
    b = imrotate(b,90);
    FDetect = vision.CascadeObjectDetector;	%Face detection
    I = b;
    BB = step(FDetect,I);%step calculates the step response of a dynamic system
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r'); %Rectangle to identify face
    end
    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));	%Cropping only the required area
    end  
        

   
        J = im2bw(J, 0.2);%Convert image to binary image, based on threshold
        
        filename = (['J_',num2str(count),'.jpg']);
        count = count +1;
        imwrite(J,filename);
        imshow(J);

    
    
end
