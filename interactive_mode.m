function interactive_mode()
    % INTERACTIVE_MODE: Interactive mode for user input.
    %
    % In this mode, the user can provide custom parameters for the LP filter.
    % The following parameters are required:
    %   - xin:      Input signal (as a MATLAB array, e.g., [1 2 3 ...])
    %   - T:        Time constant
    %   - lp:       Lp norm parameter
    %   - h:        Sampling time (step size used in the exponential calculation)
    %   - y_init:   Initial output value (default is 0)
    %   - y_delta:  Candidate step increment (default is 0.01)
    %   - y_beta:   Local adjustment step (default is 0.001)
    %
    % The resulting plot displays both the input signal and the LP filter response,
    % with the x-axis starting at 0 (to match the Python version).
    
    disp('Interactive Mode: Please provide input parameters.');
    
    % Prompt for the input signal (xin) as a MATLAB array.
    xin_str = input('Please enter the input signal array (e.g., [1 2 3 ...]): ', 's');
    xin = str2num(xin_str);  %#ok<ST2NM>
    if isempty(xin)
        error('Error: No valid numbers provided for the input signal (xin).');
    end
    
    % Prompt for the time constant T.
    T_val = input('Please enter the time constant T: ');
    if isempty(T_val)
        error('Error: T must be a valid number.');
    end
    
    % Prompt for the Lp norm parameter.
    lp_val = input('Please enter the Lp norm parameter (lp): ');
    if isempty(lp_val)
        error('Error: lp must be a valid number.');
    end
    
    % Prompt for the sampling time h.
    h = input('Please enter the sampling time h (step size in exponential calculation) [default = 0.01]: ');
    if isempty(h)
        h = 0.01;
    end
    
    % Prompt for the initial output value (y_init). Default is 0.
    y_init = input('Please enter the initial output y_init [default = 0]: ');
    if isempty(y_init)
        y_init = 0;
    end
    
    % Prompt for the candidate step increment (y_delta). Default is 0.01.
    y_delta = input('Please enter the candidate step increment y_delta [default = 0.01]: ');
    if isempty(y_delta)
        y_delta = 0.01;
    end
    
    % Prompt for the local adjustment step (y_beta). Default is 0.001.
    y_beta = input('Please enter the local adjustment step y_beta [default = 0.001]: ');
    if isempty(y_beta)
        y_beta = 0.001;
    end
    
    % Set the default sliding window size to 500.
    n = 500;
    
    % Run the LP filter with the provided parameters.
    [y_out, ~] = Lp_filter(xin, T_val, lp_val, h, n, y_init, y_delta, y_beta);
    
    % Plot the input signal and the filtered output.
    % The x-axis is explicitly set from 0 to length-1 to match the Python plot.
    figure;
    hold on;
    plot(0:length(xin)-1, xin, 'Color', '#808080', 'DisplayName', 'Input Signal');  % Gray color (#808080)
    plot(0:length(y_out)-1, y_out, 'Color', 'blue', 'DisplayName', sprintf('Filtered Output (lp=%.2f)', lp_val));
    xlabel('Sample Index');
    ylabel('Amplitude');
    title('LP Filter: Custom Step Response');
    legend('show', 'Location', 'best');
    grid on;
    hold off;
end
