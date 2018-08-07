function [y] = helperAHE(img)

% img = imread(path);
rows = size(img,1);
cols = size(img,2);
% tot_channels = size(img,3);

result = zeros(rows, cols, class(img));

bins  = zeros(1, 256);
counts = zeros(1, 256);

pmf = zeros(1, 256);
cdf = zeros(1, 256);

[counts(1,:),bins(1,:)]=imhist(img(:,:,1));
pmf(1,:) = counts(1, :)/double(sum(counts(1,:)));
cdf(1,:) = cumsum(pmf(1,:));

r = round((rows + 1)/2);
c = round((cols + 1)/ 2);

y = cdf(1, img(r,c,1)+1)*255;

end