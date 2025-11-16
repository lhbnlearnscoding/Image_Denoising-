# Image Denoising in MATLAB

This project demonstrates image denoising using different filters in MATLAB.  
Two types of noise are added to a clean image and then removed using several filtering techniques.  
The quality of the restored images is evaluated using MSE and PSNR.

---

## 1. Features

- Load an image using a file explorer (`uigetfile`).
- Add two types of noise:
  - Gaussian noise
  - Salt & Pepper noise
- Apply three types of filters:
  - Mean filter (average filter)
  - Gaussian filter
  - Median filter
- Compute quality metrics:
  - **MSE** (Mean Squared Error)
  - **PSNR** (Peak Signal-to-Noise Ratio)
- Display:
  - Original image
  - Noisy images
  - Denoised images for each filter
  - Numerical results in the Command Window

---

## 2. Theory Overview

### Noise Types

- **Gaussian noise**  
  Models sensor or transmission noise, values are usually distributed around the original pixel value.

- **Salt & Pepper noise**  
  Random pixels are set to minimum (black) or maximum (white) values. This often comes from bit errors or impulsive disturbances.

### Filters

- **Mean filter**  
  Replaces each pixel with the average of its neighbors. Simple but blurs edges and is sensitive to outliers.

- **Gaussian filter**  
  Performs a weighted average where pixels closer to the center have higher weights. It produces smooth results and preserves structure better than the mean filter.

- **Median filter**  
  Replaces each pixel with the median of its neighbors. It is very effective at removing outliers (e.g., Salt & Pepper noise) while preserving edges.

### Evaluation Metrics

- **MSE (Mean Squared Error)**  
  Measures the average squared difference between the original and denoised images.  
  → Lower MSE means better reconstruction.

- **PSNR (Peak Signal-to-Noise Ratio)**  
  A logarithmic measure in decibels (dB) derived from MSE.  
  → Higher PSNR means better image quality.

---

## 3. Experimental Results (Example)

For both Gaussian noise and Salt & Pepper noise:

- The **3×3 median filter** gives the **best results** (lowest MSE, highest PSNR).
- The **5×5 median filter** is second best but causes more blurring.
- Gaussian filters perform moderately.
- Mean filters generally perform the worst.

**Conclusion:**

- For **Salt & Pepper noise**, the median filter is clearly the best choice.
- For **Gaussian noise**, Gaussian and median filters both work, but in this experiment, the 3×3 median filter still performs very well.
- Smaller kernels (3×3) tend to preserve more details than larger ones (5×5).

---

## 4. How to Run

1. Open MATLAB.
2. Put all `.m` files in the same folder:
   - `main.m`
   - `calc_mse_psnr.m`
3. In the MATLAB Command Window, run:
   ```matlab
   main
