# LP Filter MATLAB Implementation

## Overview

This project implements an LP filter algorithm in MATLAB, replicating the functionality of a Python version. The filter uses a sliding window approach, quadratic interpolation, and local adjustment to process input signals. 
All files must be placed in a single folder to run correctly.

## File Structure

The project contains the following MATLAB files (all must reside in the same folder):

- **main.m**  
  Entry point for the application. Running `main` will allow you to choose between interactive mode and test mode.

- **interactive_mode.m**  
  Provides an interactive interface where users can input their own data.  
  **Note:** When entering the input signal (`xin`), ensure you use a valid MATLAB array format (e.g., `[1 2 3 4 5]`).

- **lp_filter_test.m**  
  Test mode that automatically generates a default step signal and applies the LP filter with preset parameters.

- **generate_step_signal.m**  
  Generates a binary step signal (0 before a given time, 1 afterward).

- **Interpolacja.m**  
  Performs quadratic interpolation to find the vertex of the fitted quadratic function (optimal candidate).

- **R_calculation.m**  
  Computes the R value used in the LP filter algorithm. This function uses a modified coefficient `(h*T/2)` multiplied by an exponential factor.

- **Lp_filter.m**  
  Contains the core LP filter algorithm that processes the input signal using a sliding window, generates candidate outputs, and refines them using quadratic interpolation and local adjustments.

## Usage Instructions

1. **Single Folder Setup**  
   Place all the MATLAB files listed above in one folder. This is necessary for the functions to properly call one another.

2. **Input Signal Format (xin)**  
   When using interactive mode, make sure to input the signal in MATLAB array format. For example:
   ```matlab
   [0 0 0 1 1 1 1 1]
