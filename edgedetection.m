% MATLAB Code | Sobel Operator from Scratch

% Read Input Image
I = imread([pathname,filename]);

% Convert the truecolor RGB image to the grayscale image
input_image = rgb2gray(I);

% Convert the image to double
I = double(I);

% Pre-allocate the filtered_image matrix with zeros
filtered_image = zeros(size(I));

% Sobel Operator Mask
Mx = [-1 0 1; -2 0 2; -1 0 1];
My = [-1 -2 -1; 0 0 0; 1 2 1];

% Edge Detection Process
% When i = 1 and j = 1, then filtered_image pixel
% position will be filtered_image(2, 2)
% The mask is of 3x3, so we need to traverse
% to filtered_image(size(I, 1) - 2
%, size(I, 2) - 2)
% Thus we are not considering the borders.
for i = 1:size(I, 1) - 2
	for j = 1:size(I, 2) - 2

		% Gradient approximations
		Gx = sum(sum(Mx.*I(i:i+2, j:j+2)));
		Gy = sum(sum(My.*I(i:i+2, j:j+2)));
				
		% Calculate magnitude of vector
		filtered_image(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);
		
	end
end

% Displaying Filtered Image
filtered_image = uint8(filtered_image);
figure, imshow(filtered_image); title('Filtered Image');

% Define a threshold value
thresholdValue = 100; % varies between [0 255]
output_image = max(filtered_image, thresholdValue);
output_image(output_image == round(thresholdValue)) = 0;

% Displaying Output Image
output_image = im2bw(output_image);
figure, imshow(output_image); title('Edge Detected Image');
