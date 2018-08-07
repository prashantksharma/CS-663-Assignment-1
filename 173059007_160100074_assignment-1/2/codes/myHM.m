function myHM( path1, mask_path1, path2, mask_path2)
fname = 'retina'

img1 = imread(path1);
rows1 = size(img1,1);
cols1 = size(img1,2);
tot_channels = size(img1,3);

mask1 = imread(mask_path1);

img2 = imread(path2);
rows2 = size(img2,1);
cols2 = size(img2,2);

mask2 = imread(mask_path2);

for i=1:tot_channels
    
    masked_channel1 = img1(:,:,i) .* uint8(mask1);
    masked_channel2 = img2(:,:,i) .* uint8(mask2);
   
    out = helperHM(img1(:,:,i), img2(:,:,i));
    %out = helperHM(masked_channel1, masked_channel2);
    
    result(:,:,i) = out;
end

% image(img1);
% image(img2);
% image(result);
% imshow(result);

% imhist(img1);
% imhist(img2);
% imhist(result);


%%%%%%% Saving the output%%%%%%%%%
imwrite(result,strcat('../images/C/',fname,'_HM.png'));

%%%%%%%%% Plotting%%%%%%%%%%%%%%%%%%%%%
%Display the original image, histogram-matched image and the histogram-equalised image.

if tot_channels==3
    colors = hsv(300);
else
    colors = gray(300);
end


figure('Name','Histogram Matching');
title('Histogram Matching');


ax1=subplot(2,3,1),image(img1);
colormap(ax1,colors);
colorbar;
title('Original Image');
axis image

ax2=subplot(2,3,2),image(result);
colormap(ax2,colors);
colorbar;
title('Histogram Matched');
axis image

imgHE = myHE('retina', '../data/retina.png', 0);
ax3=subplot(2,3,3),image(imgHE);
colormap(ax3,colors);
colorbar;
title('Histogram Equilized');
axis image

if tot_channels==3
    ax4=subplot(2,3,4),hist(reshape(img1,[],tot_channels),0:255);
    colormap(ax4,[1 0 0; 0 1 0; 0 0 1]);
    title('Original Histogram')
    
    ax5=subplot(2,3,5),hist(reshape(result,[],tot_channels),0:255);
    colormap(ax5,[1 0 0; 0 1 0; 0 0 1]);
    title('Histogram Matched')
    
    ax6=subplot(2,3,6),hist(reshape(imgHE,[],tot_channels),0:255);
    colormap(ax6,[1 0 0; 0 1 0; 0 0 1]);
    title('Histogram Equilized')
    
else
    subplot(2,3,4),imhist(img1);
    subplot(2,3,5),imhist(result);
    subplot(2,3,6),imhist(imgHE);
end

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

end
    



