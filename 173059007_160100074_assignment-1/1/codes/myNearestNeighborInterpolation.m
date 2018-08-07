function outputImage = myNearestNeighborInterpolation(img)

rows = size(img, 1);    %input image row size
cols = size(img, 2);    %input image col size

result_rows = 3*rows - 2;   %desired output image row size
result_cols = 2*cols - 1;   %desired output image col size
scale_rows = (3-(2/rows));  %desired output image rows scale factor relative to input image
scale_cols = (2-(1/cols));  %desired output image cols scale factor relative to input image
shifted_rows = ((1:result_rows)-0.5);   % row index shifted by 0.5
shifted_cols = ((1:result_cols)-0.5);   % col index shifted by 0.5
rowInd = min(round(shifted_rows./scale_rows +0.5),rows);
colInd = min(round(shifted_cols./scale_cols +0.5),cols);

%# Indexing old image to get new image:

outputImage = img(rowInd,colInd,:);
