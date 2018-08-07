%% Question 1 Image Resizing

%% Image Shrinking by Factor D 
% Here the Images are shrinked by a factor of D . To Shrink an Image the
% process is as follows:-
%   1) Load the image into a matrix.
%   2) Rows in the new image are obtained by including every dth row beginning from 1
%   3) Cols in the new image are obtained by including every dth col beginning from 1
%     The Moire can be clearly visibile in the shirnked by 2 and shirnked by 3
%     Image .
tic;
% Question 1.A  Image Shrinking
im = imread('../data/circles_concentric.png');
circles_shrinked_by_2 = myShrinkImageByFactorD(im,2);
imwrite(circles_shrinked_by_2, '../images/circles_shrinked_by_2.png');
circles_shrinked_by_3 = myShrinkImageByFactorD(im,3);
imwrite(circles_shrinked_by_3, '../images/circles_shrinked_by_3.png');
figure;
colormap(gray(256));
image(im)
title('Original Image')
axis image;
colorbar;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
figure;
colormap(gray(256));
subplot(1,2,1),image(circles_shrinked_by_2)
title('Factor 2')
axis image
colorbar;
subplot(1,2,2),image(circles_shrinked_by_3)
title('Factor 3')
axis image
colorbar;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
toc;


%% Image Enlargement Using Biliniear Interpolation
% Here we consider for our image the number of rows as M and the number of 
% columns as N .Resize the image to have the number of rows = 3M-2 and 
% Number of columns 2N-1
%
%
% for understanding bilinear interpolation we have referred
% to Vanderbilt University School of Engineering's slides
% https://ia802707.us.archive.org/23/items/Lectures_on_Image_Processing/EECE_4353_15_Resampling.pdf
% Algorithm is on page number 59.
%
%
% Here to Achieve Bilinear Interpolation we do the following 
%       Let I be an R x C image.
%       Let J be resulting image with size 3M-2 and 2N-1 i.e. R' x C' with
%       pixel locs (r' , c')
% 
%       Let S_R be R/R'
%       Let S_C be C/C'    
%       Let r_f be equal to r'.S_R
%       Let c_f be equal to c'.S_C
%       Let r_o be [r_f] and c_o be [c_f]
%       Let delta_r be difference between r_f and r_o
%       Let delta_c be difference between c_f and c_o
%       Then J(r',c') = I(r_o,c_o).(1-delta_r).(1-delta_c) 
%       + I(r_o + 1,c_o).(delta_r).(1-delta_c) + I(r_o,c_o + 1).(1-delta_r).(delta_c)
%       + I(r_o + 1,c_o + 1).(delta_r).(delta_c)

tic;
% Question 1.B Bilinear Interpolation
im=imread('../data/barbaraSmall.png');
resized=myBilinearInterpolation(im);
figure
colormap(gray(256));
subplot(1,2,1),image(im)
axis image
title('Original Image')
subplot(1,2,2),image(resized)
title('Resized Image')
axis image
truesize;
imwrite(resized,'../images/barbaraBig_bilinear.png');
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
toc;

%% Image Enlargement using Nearest-Neighbor Interpolation
% Here we consider for our image the number of rows as M and the number of 
% columns as N .Resize the image to have the number of rows = 3M-2 and 
% Number of columns 2N-1
%
% Here We will achive the enlargement using nearest neighbor for the
% unknown pixel values .
%
% The process followed here is simple 
%
%       Output image is of size 3M-2,2N-1
%       Compute scale factor for the output image
%       Compute an upsampled set of indices:
%       row_Index = min(round(((1:M)-0.5)./scale_rows + 0.5),M)
%       col_Index = min(round(((1:N)-0.5)./scale_cols + 0.5),N)
% 
%       Index old image to get new image:
% 
%       outputImage = inputImage(row_Index,col_Index,:);
% 

tic;
% Question 1.C Nearest Neighbor Interpolation
im=imread('../data/barbaraSmall.png');
resized=myNearestNeighborInterpolation(im);
figure
colormap(gray(256));
subplot(1,2,1),image(im)
axis image
title('Original Image')
subplot(1,2,2),image(resized)
title('Resized Image')
axis image
imwrite(resized,'../images/barbaraBig_nearest.png');
truesize
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
toc;


