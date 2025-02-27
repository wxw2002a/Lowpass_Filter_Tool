function [y, xin] = Lp_filter(xin, T, p, h, n, y_init, y_delta, y_beta)
    % LP_FILTER: Applies the LP filter algorithm to an input signal.
    %
    % The algorithm processes the input signal using a sliding window approach.
    % For each step, it:
    %   1. Constructs a sliding window of the last n samples from the input.
    %   2. Generates three candidate outputs (one slightly below, equal to, and above the previous output).
    %   3. Computes the R value for each candidate.
    %   4. Uses quadratic interpolation to estimate the optimal output candidate.
    %   5. Refines the candidate using local adjustments (increasing or decreasing by y_beta)
    %      until the error no longer decreases.
    %
    % Parameters:
    %   xin     - Input signal (vector)
    %   T       - Time constant.
    %   p       - Lp norm parameter.
    %   h       - Sampling time (step size, default: 0.01).
    %   n       - Window size (default: 500).
    %   y_init  - Initial output value (default: 0).
    %   y_delta - Candidate step increment (default: 0.01).
    %   y_beta  - Local adjustment step (default: 0.001).
    %
    % Outputs:
    %   y   - The filtered output signal (vector).
    %   xin - The original input signal (returned unchanged).
    
    if nargin < 5 || isempty(n)
        n = 500;
    end
    if nargin < 6 || isempty(y_init)
        y_init = 0;
    end
    if nargin < 7 || isempty(y_delta)
        y_delta = 0.01;
    end
    if nargin < 8 || isempty(y_beta)
        y_beta = 0.001;
    end

    N = length(xin);
    y = zeros(1, N);  % Initialize the output vector.
    y(1) = y_init;    % Set the initial output value.
    
    for step = 2:N
        % Construct the sliding window of the last n samples.
        % If there are fewer than n samples, pad the beginning with zeros.
        if step < n
            x_window = zeros(1, n);
            x_window((n - step + 1):n) = xin(1:step);
        else
            x_window = xin(step - n + 1:step);
        end
        
        y_prev = y(step - 1);
        % Generate three candidate outputs: below, equal to, and above the previous output.
        y_candidates = [y_prev - y_delta, y_prev, y_prev + y_delta];
        R_vals = zeros(1, 3);
        for k = 1:3
            % Compute the R value for each candidate based on the current input window.
            R_vals(k) = R_calculation(n, y_candidates(k), x_window, p, T, h);
        end
        
        % Calculate the squared error between each candidate and its corresponding R value.
        j_vals = (y_candidates - R_vals).^2;
        try
            % Use quadratic interpolation to determine the optimal candidate output.
            y_out = Interpolacja(y_candidates, j_vals);
        catch
            % If interpolation fails, use the middle candidate.
            y_out = y_candidates(2);
        end
        
        % Local adjustment: refine y_out by checking if small positive or negative adjustments
        % reduce the error between y_out and the computed R value.
        diff_old = abs(y_out - R_calculation(n, y_out, x_window, p, T, h));
        y_out_pos = y_out + y_beta;
        diff_new = abs(y_out_pos - R_calculation(n, y_out_pos, x_window, p, T, h));
        if diff_new < diff_old
            while diff_new < diff_old
                y_out = y_out_pos;
                diff_old = diff_new;
                y_out_pos = y_out_pos + y_beta;
                diff_new = abs(y_out_pos - R_calculation(n, y_out_pos, x_window, p, T, h));
            end
        else
            y_out_neg = y_out - y_beta;
            diff_new = abs(y_out_neg - R_calculation(n, y_out_neg, x_window, p, T, h));
            while diff_new < diff_old
                y_out = y_out_neg;
                diff_old = diff_new;
                y_out_neg = y_out_neg - y_beta;
                diff_new = abs(y_out_neg - R_calculation(n, y_out_neg, x_window, p, T, h));
            end
        end
        
        % Update the output signal for the current step.
        y(step) = y_out;
    end
end
