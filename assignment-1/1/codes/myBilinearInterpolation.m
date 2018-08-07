function [out] = myBilinearInterpolation(im)
% for understanding bilinear interpolation we have referred
% to Vanderbilt University School of Engineering's slides
% https://ia802707.us.archive.org/23/items/Lectures_on_Image_Processing/EECE_4353_15_Resampling.pdf
% It is on page number 59.
rows = size(im, 1);    %input image row size
cols = size(im, 2);    %input image col size

result_rows = 3*rows - 2;   %desired output image row size
result_cols = 2*cols - 1;   %desired output image col size


% Let S_R = R / R'        
S_R = rows / result_rows;
% Let S_C = C / C'
S_C = cols / result_cols;

% Defining grid of co-ordinates in our image
% Generating (x,y) pairs for each point in our image
[c_f, r_f] = meshgrid(1 : result_cols, 1 : result_rows);

% Let r_f = r'*S_R for r = 1,...,R'
% Let c_f = c'*S_C for c = 1,...,C'
r_f = r_f * S_R;
c_f = c_f * S_C;

% Let r = floor(rf) and c = floor(cf)
r_o = floor(r_f);
c_o = floor(c_f);

% Any values out of range, cap
r_o(r_o < 1) = 1;
c_o(c_o < 1) = 1;
r_o(r_o > rows - 1) = rows - 1;
c_o(c_o > cols - 1) = cols - 1;

% Let delta_R = rf - r and delta_C = cf - c
delta_R = r_f - r_o;
delta_C = c_f - c_o;

% Final line of algorithm
% For accessing point in the image getting column major indices 
in1_ind = sub2ind([rows, cols], r_o, c_o);
in2_ind = sub2ind([rows, cols], r_o+1,c_o);
in3_ind = sub2ind([rows, cols], r_o, c_o+1);
in4_ind = sub2ind([rows, cols], r_o+1, c_o+1);

% Now interpolating
% Going through each channel for the case of colour
% Creating output image that is the same class as input
out = zeros(result_rows, result_cols, size(im, 3));
out = cast(out, class(im));

for idx = 1 : size(im, 3)
    chan = double(im(:,:,idx)); % Getting i'th channel
    % Interpolate the channel
    tmp = chan(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
        chan(in2_ind).*(delta_R).*(1 - delta_C) + ...
        chan(in3_ind).*(1 - delta_R).*(delta_C) + ...
        chan(in4_ind).*(delta_R).*(delta_C);
    out(:,:,idx) = cast(tmp, class(im));
end

end