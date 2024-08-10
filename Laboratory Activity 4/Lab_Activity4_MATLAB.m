% Group 3 - Block 1
% Alambra, Joseph Nathaniel A.
% Aragon, Patrick Laurence M.
% Banal, Daryll L.
% Sentasas, David Bryan L.
% Tutanes, Allen Christopher O.
pkg load image;  % Load the image package for Octave

% Read the image
img = imread('flower.jpg');  % Replace with the path to your image file

% Display the original image
figure(1); imshow(img); title('Original Image');

% Convert to grayscale if the image is RGB
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

% Display the grayscale image
figure(2); imshow(img_gray); title('Grayscale');

% Edge detection using Canny
edges_canny = edge(img_gray, 'Canny', [0.1 0.3]);
figure(3); imshow(edges_canny); title('Canny Edge Detection');

% Edge detection using Sobel
sobelx = imfilter(double(img_gray), fspecial('sobel')');  % Sobel X axis
sobely = imfilter(double(img_gray), fspecial('sobel'));   % Sobel Y axis
sobel_combined = sqrt(sobelx.^2 + sobely.^2);
figure(4); imshow(sobel_combined, []); title('Sobel Edge Detection');

% Add blur to the image
len = 21;
theta = 11;
psf = fspecial('motion', len, theta);
img_blur = imfilter(img_gray, psf, 'conv', 'circular');

% Display the motion blurred image
figure(5); imshow(img_blur); title('Motion Blurred Image');

% Gaussian filtering with an experimented value
h_gaussian = fspecial('gaussian', [5, 5], 10);  % Changed value from 1 to 10
img_gaussian_filtered = imfilter(img_blur, h_gaussian);

% Display the Gaussian filtered image
figure(6); imshow(img_gaussian_filtered); title('Filtered Image with Experimented Value (Gaussian)');

% Histogram (Gaussian Filtered)
figure(7); imhist(img_gaussian_filtered); title('Histogram of the Experimented Value (Gaussian Filtered)');

% Sharpening using unsharp masking
img_sharpened = imsharpen(img_blur);

% Display the sharpened image
figure(8); imshow(img_sharpened); title('Sharpened Image');

% Add Gaussian noise and remove it using median filter
img_noisy_exp1 = imnoise(img_gray, 'gaussian', 0, 0.5);
img_noisy_exp2 = imnoise(img_gray, 'gaussian', 0, 0.1);

% Display the noisy images
figure(9); imshow(img_noisy_exp1); title('Noisy Using Experimented Value (Gaussian = 0.5)');
figure(10); imshow(img_noisy_exp2); title('Noisy Using Experimented Value (Gaussian = 0.1)');

% Display the histograms for noisy images
figure(11); imhist(img_noisy_exp1); title('Histogram of Noisy Image Experimented Value 1');
figure(12); imhist(img_noisy_exp2); title('Histogram of Noisy Image Experimented Value 2');

% Remove Gaussian noise using median filter
img_noisy_removed = medfilt2(img_noisy_exp1, [5, 5]);

% Display the noise-removed image
figure(13); imshow(img_noisy_removed); title('Noise Removed');

% Deblurring using Wiener filter
estimated_nsr = 0.01;
img_deblurred = deconvwnr(img_blur, psf, estimated_nsr);

% Display the deblurred image
figure(14); imshow(img_deblurred); title('Deblurred Image');

