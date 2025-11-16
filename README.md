"Image Denoising in MATLAB" 
This project demonstrates noise generation, noise removal, and quality evaluation in digital images using MATLAB.
It compares different filtering techniques on two common noise types: Gaussian noise and Salt & Pepper noise.

1. Features

Load an image using a file explorer (uigetfile)

Add two types of noise:

Gaussian noise

Salt & Pepper noise

Apply three types of filters:

Mean filter (Average)

Gaussian filter

Median filter

Compute image quality metrics:

MSE (Mean Squared Error)

PSNR (Peak Signal-to-Noise Ratio)

Display visual comparison and print numerical results

2. How It Works
Noise Addition

Gaussian noise simulates sensor or transmission noise.

Salt & Pepper noise simulates random black/white corrupted pixels.

Filtering Methods

Mean filter: simple averaging; reduces noise but blurs the image.

Gaussian filter: weighted averaging; smoother and preserves structure better.

Median filter: removes extreme pixel values (outliers); best for Salt & Pepper noise.

Evaluation Metrics

MSE measures the average error between the original and restored images.
Lower MSE = better quality.

PSNR expresses quality in decibels.
Higher PSNR = better quality.

3. Results Summary
Gaussian Noise

Median 3×3 achieves the best quality (highest PSNR, lowest MSE).

Gaussian filters perform moderately well.

Mean filters perform the worst.

Salt & Pepper Noise

Median filters dominate, especially 3×3.

Gaussian and mean filters are less effective.

4. Why Median Filter Works Best

A median filter replaces each pixel with the median value of neighboring pixels.
It removes outliers (extremely bright or dark pixels) without blurring the image, making it ideal for Salt & Pepper noise.

5. How to Run

Open MATLAB.

Place all .m files in the same folder.

Run:

main


Choose an image when prompted.

View the filtered results and quality metrics.

6. Requirements

MATLAB R2018+

Image Processing Toolbox (recommended)

7. Files

main.m – main program

calc_mse_psnr.m – function to compute MSE & PSNR

Sample images for testing
