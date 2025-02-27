function y = Interpolacja(x_vals, j_vals)
    % INTERPOLACJA: Perform quadratic interpolation to find the vertex.
    %
    % This function fits a quadratic polynomial to the given data points (x_vals, j_vals)
    % and returns the x-coordinate of the vertex, which is considered the optimal candidate.
    %
    % Parameters:
    %   x_vals - Vector of candidate output values.
    %   j_vals - Vector of squared error values corresponding to each candidate.
    %
    % Output:
    %   y - The x-coordinate of the vertex of the fitted quadratic polynomial.
    
    p = polyfit(x_vals, j_vals, 2);  % Fit a quadratic polynomial: p(1)*x^2 + p(2)*x + p(3)
    if abs(p(1)) < 1e-18
        error('Quadratic coefficient is too small to determine a unique vertex.');
    end
    y = -p(2) / (2 * p(1));
end
