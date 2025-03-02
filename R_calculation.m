function R = R_calculation(n, y, x, p, T, h)
    % R_CALCULATION: Compute the R value used in the LP filter algorithm.
    %
    % The function calculates two components:
    %   - s1: The contribution from the last sample in the window, computed using a modified coefficient
    %         (h*T/2) multiplied by an exponential factor.
    %   - s2: The weighted sum of contributions from the remaining samples in the window.
    % The final R value is derived from these combined contributions.
    %
    % Parameters:
    %   n - Number of samples in the current sliding window.
    %   y - Candidate output value.
    %   x - Input signal window (vector) with n samples.
    %   p - Lp norm parameter.
    %   T - Time constant.
    %   h - Sampling time (step size in the exponential calculation).
    %
    % Output:
    %   R - The computed R value.
    
    EPSILON = 1e-18;
    if length(x) < n
        error('Input vector x must have at least n elements.');
    end
    
    % Compute s1: using (h*T/2) and the exponential factor exp(n*h/T).
    s1 = (h  / (2* T)) * (abs(x(n) - y)^(p - 1)) * sign(x(n) - y) * exp(n * h / T);
    
    % Compute s2: sum contributions of the first n-1 samples with exponential weighting.
    s2 = 0;
    for i = 1:(n - 1)
        s3 = (abs(x(i) - y)^(p - 1)) * sign(x(i) - y);
        s3 = s3 * exp(i * h / T);
        s2 = s2 + s3;
    end
    s2 = s2 * (h / T);
    
    s21 = s1 + s2;
    
    % To avoid numerical instability, if s21 is very small, return 0.
    if abs(s21) < EPSILON
        R = 0;
    else
        R = (abs(s21)^(1/(p - 1))) * sign(s21);
    end
end
