function out = myLinearContrastStretching(fname, path)

flag = 0;

img = imread(path);
rows = size(img,1);
cols = size(img,2);
tot_channels = size(img,3);
    
if tot_channels == 3
    flag=1;
end

result = zeros(rows, cols, class(img));

% im_double = im2double(image);
for i=1:tot_channels
    channel = img(:,:,i);
    low = min(min(channel));
    high = max(max(channel));
%     out = round( ((channel - low)*255)/( high - low) );
%     op_image(:, :, i) = uint8(255*mat2gray(out));
    for r=1: rows
        for c=1:cols
            pixel = img(r,c, i);
            result(r,c,i) = (double(pixel - low)/double(high - low))*255;
        end
    end
end


out = result;

imwrite(result,strcat('../images/A/',fname, '_LinearContrastStretched.png'))


figure('Name','Linear Contrast Stretching');
title('Linear Contrast Stretching');

if tot_channels==3
    colors = hsv(300);
else
    colors = gray(300);
end



ax1=subplot(2,2,1);%,image(img)
imshow(img);
colormap(ax1,colors);
colorbar
title('Original')
axis image

ax2=subplot(2,2,2);%,image(result)
imshow(result);
colormap(ax2,colors);
colorbar
title('Linear Contrast Stretched')
axis image

    
% Histogram for RGB Images
% We have refered
% https://stackoverflow.com/questions/14682936/how-to-show-histogram-of-rgb-image-in-matlab/

if flag==1
    % RGB Image
    ax3=subplot(2,2,3),hist(reshape(img,[],tot_channels),0:255);
    colormap(ax3,[1 0 0; 0 1 0; 0 0 1]);
    title('Original Histogram')
    
    ax4=subplot(2,2,4),hist(reshape(result,[],tot_channels),0:255);
    colormap(ax4,[1 0 0; 0 1 0; 0 0 1]);
    title('Contrast Stretched Histogram')
else
    % Grayscale Image
    subplot(2,2,3),imhist(img)
    title('Original Histogram')
    subplot(2,2,4),imhist(result)
    title('Contrast Stretched Histogram')
end

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        
end