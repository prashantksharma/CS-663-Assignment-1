function [y] = blockCLAHE(img, cliplevel)
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

for i=1:256
    if ( pmf(1,i) > cliplevel)
        pmf(1,i) = cliplevel;
    end
end

mass = 1 - sum(pmf(1,:));

new_pmf = zeros(1,256);
new_cdf = zeros(1,256);

new_pmf(1, :) = pmf(1,:) + mass/numel(pmf);
new_cdf(1,:) = cumsum(new_pmf(1,:));


r = round((rows + 1)/2);
c = round((cols + 1)/ 2);

y = new_cdf(1, img(r,c,1)+1)*255;

end