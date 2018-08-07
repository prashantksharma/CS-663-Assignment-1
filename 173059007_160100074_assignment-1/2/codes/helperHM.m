function [out] =  helperHM(img1, img2)

M = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
hist1 = imhist(img1); %// Compute histograms
hist2 = imhist(img2);
cdf1 = cumsum(hist1) / numel(img1); %// Compute CDFs
cdf2 = cumsum(hist2) / numel(img2);

% Computing the mapping for each intensity
for idx = 1 : 256
    [~,ind] = min(abs(cdf1(idx) - cdf2));
    M(idx) = ind ;
end

row = size(img1,1);
col = size(img2,2);

out = zeros(row,col, class(img1));

for r=1:row
    for c=1:col
        val = img1(r,c)+1;
        m = M(val);
%         disp(m)
        out(r,c) = m;
    end
end
% imshow(out);
% imhist(out);
end