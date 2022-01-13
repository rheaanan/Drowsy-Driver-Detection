%To detect Mouth

clc;
blink = VideoReader('BLINK123.mp4');%Create object to read video files

for img = 1:1

I = read(blink,img);
I = imrotate(I,90);
imshow(I);
redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);
avg = rgb2gray(I);%Convert RGB image or colormap to grayscale
figure,imshowpair(redChannel,greenChannel,'diff');
frame = getframe();
image = frame2im(frame);%Return image data associated with movie frame
image = rgb2gray(image);
BW = roicolor(image,220,255);%Select region of interest (ROI) based on color

end
