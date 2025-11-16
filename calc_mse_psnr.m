function [mse, psnr_val] = calc_mse_psnr(original, restored)

%function to calculate the mse and psnr from 2 gray pictures
%mse: The half mean squared error operation computes the half mean squared error loss 
%     between network predictions and target values for regression tasks.
%psnr:  peak signal-to-noise ratio (PSNR) for the image A, with the image ref as the reference. 
%       A greater PSNR value indicates better image quality.
%MSE: measures how much the filtered image differs from the original image.
%PSNR: converts the MSE value into the decibel (dB) scale to make it easier to read and compare.

if ~isa(original, 'double')
        original = im2double(original);
end
if ~isa(restored, 'double')
        restored = im2double(restored);
end
 %isa: function to check the type of data
 %im2double: converts the image I to double precision.

 % Make sure that 2 images are the same size

if ~isequal(size(original), size(restored))
    error(' 2 images must be in the same size');
end

diff = original - restored;
mse = mean(diff(:).^2); %vector

if mse == 0
   psnr_val = Inf;
else
    MAX_I = 1; 
    psnr_val = 10 * log10( MAX_I^2 / mse );
end
end

