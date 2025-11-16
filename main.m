clc; clear; close all;

%% Load data
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'}, ...
                                 'Choose file to process');
if isequal(filename, 0)
    disp('You have not selected the image yet');
    return;
end

img = imread(fullfile(pathname, filename));

%% Grayscale
if size(img, 3) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

%% Convert the image into double[0,1] to process
img_gray = im2double(img_gray);

%% Add noise to the image

% Gaussian
mean_noise = 0;
var_noise  = 0.01; % Other values: 0.005, 0.02,...
img_gaussian_noisy = imnoise(img_gray, 'gaussian', mean_noise, var_noise);

% Salt & Pepper
density_sp = 0.05; % Noise percentage, thử 0.1, 0.2,...
img_sp_noisy = imnoise(img_gray, 'salt & pepper', density_sp);

%% Filter tools

% Mean filter (Average)
%h = fspecial(type) creates a two-dimensional filter h of the specified type.
% Some of the filter types have optional additional parameters, shown in the following syntaxes.
% fspecial returns h as a correlation kernel, which is the appropriate form to use with imfilter.

h_mean_3 = fspecial('average', [3 3]); %[3 3] is the mask with size of 3x3
h_mean_5 = fspecial('average', [5 5]);

% Gaussian filter
h_gauss_3 = fspecial('gaussian', [3 3], 0.5); %0.5 is sigma which decides the blur rate of the image
h_gauss_5 = fspecial('gaussian', [5 5], 1.0);

%% Filter

% Gaussian
img_gauss_mean3  = imfilter(img_gaussian_noisy, h_mean_3, 'replicate');
img_gauss_mean5  = imfilter(img_gaussian_noisy, h_mean_5, 'replicate');
img_gauss_gauss3 = imfilter(img_gaussian_noisy, h_gauss_3, 'replicate');
img_gauss_gauss5 = imfilter(img_gaussian_noisy, h_gauss_5, 'replicate');
img_gauss_median3 = medfilt2(img_gaussian_noisy, [3 3]);
img_gauss_median5 = medfilt2(img_gaussian_noisy, [5 5]);

% B = imfilter(A,h) filters the multidimensional array A with the multidimensional 
% filter h and returns the result in B.
% medfilt2: 2D median filter
%A median filter replaces the center pixel of a window with the median value of all pixels inside that window.

% Salt and Pepper
img_sp_mean3  = imfilter(img_sp_noisy, h_mean_3, 'replicate');
img_sp_mean5  = imfilter(img_sp_noisy, h_mean_5, 'replicate');
img_sp_gauss3 = imfilter(img_sp_noisy, h_gauss_3, 'replicate');
img_sp_gauss5 = imfilter(img_sp_noisy, h_gauss_5, 'replicate');
img_sp_median3 = medfilt2(img_sp_noisy, [3 3]);
img_sp_median5 = medfilt2(img_sp_noisy, [5 5]);

%% MSE and PSNR calculating

% ---- Gaussian noise ----
[metrics.gauss.mean3_mse,   metrics.gauss.mean3_psnr]   = calc_mse_psnr(img_gray, img_gauss_mean3);
[metrics.gauss.mean5_mse,   metrics.gauss.mean5_psnr]   = calc_mse_psnr(img_gray, img_gauss_mean5);
[metrics.gauss.gauss3_mse,  metrics.gauss.gauss3_psnr]  = calc_mse_psnr(img_gray, img_gauss_gauss3);
[metrics.gauss.gauss5_mse,  metrics.gauss.gauss5_psnr]  = calc_mse_psnr(img_gray, img_gauss_gauss5);
[metrics.gauss.median3_mse, metrics.gauss.median3_psnr] = calc_mse_psnr(img_gray, img_gauss_median3);
[metrics.gauss.median5_mse, metrics.gauss.median5_psnr] = calc_mse_psnr(img_gray, img_gauss_median5);

% ---- Salt & Pepper noise ----
[metrics.sp.mean3_mse,   metrics.sp.mean3_psnr]   = calc_mse_psnr(img_gray, img_sp_mean3);
[metrics.sp.mean5_mse,   metrics.sp.mean5_psnr]   = calc_mse_psnr(img_gray, img_sp_mean5);
[metrics.sp.gauss3_mse,  metrics.sp.gauss3_psnr]  = calc_mse_psnr(img_gray, img_sp_gauss3);
[metrics.sp.gauss5_mse,  metrics.sp.gauss5_psnr]  = calc_mse_psnr(img_gray, img_sp_gauss5);
[metrics.sp.median3_mse, metrics.sp.median3_psnr] = calc_mse_psnr(img_gray, img_sp_median3);
[metrics.sp.median5_mse, metrics.sp.median5_psnr] = calc_mse_psnr(img_gray, img_sp_median5);

%% Result

% Orginal and Noisy Images
figure('Name', 'Original & Noisy Images');
subplot(1,3,1); imshow(img_gray);              title('Original');
subplot(1,3,2); imshow(img_gaussian_noisy);    title('Gaussian noise');
subplot(1,3,3); imshow(img_sp_noisy);          title('Salt & Pepper noise');

% Comparing Gaussian noise filter
figure('Name', 'Denoising Gaussian noise');
subplot(2,3,1); imshow(img_gauss_mean3);   title('Mean 3x3');
subplot(2,3,2); imshow(img_gauss_mean5);   title('Mean 5x5');
subplot(2,3,3); imshow(img_gauss_gauss3);  title('Gaussian 3x3');
subplot(2,3,4); imshow(img_gauss_gauss5);  title('Gaussian 5x5');
subplot(2,3,5); imshow(img_gauss_median3); title('Median 3x3');
subplot(2,3,6); imshow(img_gauss_median5); title('Median 5x5');

% Comparing Salt and Pepper noise filter
figure('Name', 'Denoising Salt & Pepper noise');
subplot(2,3,1); imshow(img_sp_mean3);   title('Mean 3x3');
subplot(2,3,2); imshow(img_sp_mean5);   title('Mean 5x5');
subplot(2,3,3); imshow(img_sp_gauss3);  title('Gaussian 3x3');
subplot(2,3,4); imshow(img_sp_gauss5);  title('Gaussian 5x5');
subplot(2,3,5); imshow(img_sp_median3); title('Median 3x3');
subplot(2,3,6); imshow(img_sp_median5); title('Median 5x5');

%% 7. Result Table

disp('==== DENOISING (Gaussian noise) ====');
fprintf('Mean 3x3:    MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.mean3_mse,   metrics.gauss.mean3_psnr);
fprintf('Mean 5x5:    MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.mean5_mse,   metrics.gauss.mean5_psnr);
fprintf('Gauss 3x3:   MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.gauss3_mse,  metrics.gauss.gauss3_psnr);
fprintf('Gauss 5x5:   MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.gauss5_mse,  metrics.gauss.gauss5_psnr);
fprintf('Median 3x3:  MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.median3_mse, metrics.gauss.median3_psnr);
fprintf('Median 5x5:  MSE = %.6f, PSNR = %.2f dB\n',  metrics.gauss.median5_mse, metrics.gauss.median5_psnr);

disp(' ');
disp('==== DENOISING (Salt & Pepper noise) ====');
fprintf('Mean 3x3:    MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.mean3_mse,   metrics.sp.mean3_psnr);
fprintf('Mean 5x5:    MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.mean5_mse,   metrics.sp.mean5_psnr);
fprintf('Gauss 3x3:   MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.gauss3_mse,  metrics.sp.gauss3_psnr);
fprintf('Gauss 5x5:   MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.gauss5_mse,  metrics.sp.gauss5_psnr);
fprintf('Median 3x3:  MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.median3_mse, metrics.sp.median3_psnr);
fprintf('Median 5x5:  MSE = %.6f, PSNR = %.2f dB\n',  metrics.sp.median5_mse, metrics.sp.median5_psnr);


%% Explaining the result
%For Gaussian noise, the 3×3 median filter gives the best result (lowest MSE, highest PSNR).
%Gaussian filters work reasonably well, while mean filters perform the worst.

%For Salt & Pepper noise, the median filter is clearly the best, especially the 3×3 version.
%This matches theory because median filtering removes outliers very effectively.

%3×3 filters generally perform better than 5×5 because they preserve image details and edges, while 5×5 filters cause more blurring.