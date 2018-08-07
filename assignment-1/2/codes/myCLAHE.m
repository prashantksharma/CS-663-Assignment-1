function CLAHE(cliplevel,n, fname, path)

img = imread(path);
rows = size(img,1);
cols = size(img,2);
tot_channels = size(img,3);

result = zeros(rows, cols, class(img));

for i=1: tot_channels
    channel = img(:, :, i);
    
    out = nlfilter(channel, [n n], @helperCLAHE, cliplevel);
    
    result(:,:,i) = out;
end
    
% imshow(result);


n_str = int2str(n);
clip_str = num2str(cliplevel);
imwrite(result,strcat('../images/E/',fname,'_',clip_str,'_',n_str,'_CLAHE.png'));

%%%% Plotting %%%%%%%%%%

if tot_channels==3
    colors = hsv(300);
else
    colors = gray(300);
end

showFigure = 1;

if showFigure == 1
    figure('Name','Contrast Limited Adaptive Histogram Equlization');
    title('Contrast Limited Adaptive Histogram Equalization');
    
    ax1 = subplot(2,2,1);%,image(img);
    imshow(img);
    colormap(ax1,colors);
    colorbar;
    title('Original Image');
    axis image
    
    ax2=subplot(2,2,2); %,image(result);
    imshow(result);
    colormap(ax2,colors);
    colorbar;
    title(['After CLAHE: Window Size=', n_str, ' & Threshold= ', clip_str]);
    axis image
    
    if tot_channels==3
        ax3=subplot(2,2,3),hist(reshape(img,[],tot_channels),0:255);
        colormap(ax3,[1 0 0; 0 1 0; 0 0 1]);
%         title('Original')
        
        ax4=subplot(2,2,4),hist(reshape(result,[],tot_channels),0:255);
        colormap(ax4,[1 0 0; 0 1 0; 0 0 1]);
%         title('After AHE')
    else
        subplot(2,2,3),imhist(img);
        subplot(2,2,4),imhist(result);
    end
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

end



end