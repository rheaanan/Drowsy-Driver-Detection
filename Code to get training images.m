clc;	%Clears Console
blink = VideoReader('yawn.mp4'); %Reads the video
count = 200	%Count for file name
for img = 300:400
    b = read(blink, img);
    FDetect = vision.CascadeObjectDetector;	%Face detection
    I = b;
    BB = step(FDetect,I);
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r'); %Rectangle to identify face
    end
    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));	%Cropping only the required area
    end  
        
    EyeDetect = vision.CascadeObjectDetector('EyePairBig');
    BB=step(EyeDetect,I);
    %figure,imshow(I);

    for i = 1:size(BB,1)
        aaa = rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    end
    title('Eyes Detection');

    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));        
        J = imadjust(J,stretchlim(J),[]);%Adjust image intensity values or colormapcollapse
        J = im2bw(J, 0.2);%Convert image to binary image, based on threshold
        
        filename = (['J_',num2str(count),'.jpg']);
        count = count +1;
        imwrite(J,filename);
        imshow(J);

    end
    
end
