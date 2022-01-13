clc;
blink = VideoReader('BLINK123.mp4');%Create object to read video files
count = 1;
cnt = 0;

c =datetime('now');%Create array based on current date
disp(c);

for img = 40:45
    b = read(blink, img);%Read video frame data from file
    b = imrotate(b,90);
    FDetect = vision.CascadeObjectDetector;%Detect objects using the Viola-Jones algorithm
    I = b;
    BB = step(FDetect,I);%step calculates the step response of a dynamic system
    for i = 1:size(BB,1)
        rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    for i = 1:size(BB,1)
        J= imcrop(I,BB(i,:));
    end  
    b1 = read(blink, img+1);
    b1 = imrotate(b1,90);%Rotate image
    FDetect = vision.CascadeObjectDetector;
    K = b1;
    BB1 = step(FDetect,K);
    figure,
    for i = 1:size(BB1,1)
        rectangle('Position',BB1(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    end
    for i = 1:size(BB1,1)
        L= imcrop(K,BB1(i,:));
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
        
        %filename = (['J_',num2str(count),'.jpg']);
        %count = count +1;
        %imwrite(J,filename);
        %imshow(J);

    end
    
    EyeDetect = vision.CascadeObjectDetector('EyePairBig');
    BB1=step(EyeDetect,K);
    %figure,imshow(I);

    for i = 1:size(BB1,1)
        aaa = rectangle('Position',BB1(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    end
    title('Eyes Detection');
    for i = 1:size(BB1,1)
        L= imcrop(K,BB1(i,:));        
        L = imadjust(L,stretchlim(L),[]);
        L = im2bw(L, 0.2);
        %imshow(L);
    
        figure,imshowpair(J,L,'diff');
        frame = getframe();
        image = frame2im(frame);%Return image data associated with movie frame
        
        %filename = (['J_',num2str(count),'.jpg']);
        %count = count +1;
        %imwrite(image,filename);
        
        %imshow(image);
        n = nnz(image);%Number of nonzero matrix elements
        c2=datetime('now');
        
        c3=[c,c2]
        
        d = diff(c3);
        d=seconds(d)
        if(d>10)
            c=datetime('now');
            disp("i worked")
            if cnt<4
                disp("sleepy")
            end
        end
                
        if n > 30000
            disp("change")
            cnt= cnt+1;
        end
        %imshow(Z); hold on;

    end
    disp(cnt);
    
end
