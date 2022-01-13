We have 9 files: 
1. Code to get training images
2. Code to get training images - mouth
3. Detect Blinks with difference images
4. Detect blinks with classifier 
5. Detecting blinks with classifier - small eyes
6. Detecting blinks with classifier - diff eye colour
7. Detect mouth using Viola jones
8. Detect mouth based on colour
9. Detect yawn using classifier 

1. The first code can be run with any of the videos. BLINK123 video has to be rotated to be executed. 
The rest of the videos can be executed directly.
2. This can be run on any of the video files as input 
3. This method can be executed with any of the video files as well
4. This file is used with the training data as the images in /Training Data/imageSets and can be run with 
all three different types of video files - heart.mp4, blinkpls.mp4 and BLINK123.mp4
5. This file is used with the training data as the images in /Training Data/Imagesetsize and can be run 
with all three different types of video files - heart.mp4, blinkpls.mp4 and BLINK123.mp4
6. This file is used with the training data as the images in /Traini
ng Data/Allimages and can be run 
with all three different types of video files - heart.mp4, blinkpls.mp4 and BLINK123.mp4
7. This method can be used with all videos except the yawn video. This gives us correct outputs by 
varying thresholds.
8. This file can be executed with BLINK123 video. It fails to work with the other videos.
9. This method can be used with yawn.mp4 and blinkpls.mp4.