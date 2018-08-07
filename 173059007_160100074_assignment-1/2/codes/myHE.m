function out = myHE(fname, path, showFigure)

% showFigure = 1;

% if (showFigure == 0)
%     showFigure  = 0;
% end

img = imread(path);
rows = size(img,1);
cols = size(img,2);
tot_channels = size(img,3);

result = zeros(rows, cols, class(img));

bins  = zeros(tot_channels, 256);
counts = zeros(tot_channels, 256);

pmf = zeros(tot_channels, 256);
cdf = zeros(tot_channels, 256);

for i=1:tot_channels
    [counts(i,:),bins(i,:)]=imhist(img(:,:,i));
    pmf(i,:) = counts(i, :)/double(sum(counts(i,:)));
    cdf(i,:) = cumsum(pmf(i,:));
    
    for r=1:rows
        for c=1:cols
            result(r,c,i)=cdf(i, img(r,c,i)+1)*255;
        end
    end    
end

out = result;

imwrite(result,strcat('../images/B/',fname,'_HE.png'));


%%% Plotting %%%%%%%%%%%

if tot_channels==3
    colors = hsv(300);
else
    colors = gray(300);
end


if showFigure == 1
    figure('Name','Histogram Equlization');
    title('Histogram Equalization');
    
    
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
    title('Histogram Equalized');
    axis image
    
    if tot_channels==3
        ax3=subplot(2,2,3),hist(reshape(img,[],tot_channels),0:255);
        colormap(ax3,[1 0 0; 0 1 0; 0 0 1]);
%         title('Original Histogram')
        
        ax4=subplot(2,2,4),hist(reshape(result,[],tot_channels),0:255);
        colormap(ax4,[1 0 0; 0 1 0; 0 0 1]);
%         title('Histogram Equalized')
    else
        subplot(2,2,3),imhist(img);
%         title('Original Histogram')
        subplot(2,2,4),imhist(result);
%         title('Histogram Equalized')
    end
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

end


end
