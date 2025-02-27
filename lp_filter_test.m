function lp_filter_test()
    % LP_FILTER_TEST: Test mode for the LP filter.
    %
    % This function generates a default step signal using preset parameters:
    %   - Sampling rate: n = 100
    %   - Signal duration: t1 = 3
    %   - Step time: t2 = 0.005
    %
    % It then applies the LP filter using various lp norm parameters and plots the
    % filtered outputs along with the input signal. The x-axis starts at 0.
    
    % Generate the default step signal.
    xin = generate_step_signal(100, 3, 0.005);
    T_val = 1.0;  % Time constant.
    lp_values = [2, 1.8, 1.6, 1.4, 1.2, 1.1, 1.02];  % Array of lp norm parameters.
    colors = ["#E0E0E0", "#CC0000", "#FF8000", "#FFFF00", "#00FF00", "#00FFFF", "#0080FF", "#FF00FF"];
    
    figure;
    hold on;
    % Plot the input signal with the x-axis starting at 0.
    plot(0:length(xin)-1, xin, 'Color', colors(1), 'DisplayName', 'Input Signal');
    
    % For each lp value, run the LP filter and plot the filtered output.
    for i = 1:length(lp_values)
        [y_out, ~] = Lp_filter(xin, T_val, lp_values(i), 0.01, 500, 0, 0.01, 0.001);
        plot(0:length(y_out)-1, y_out, 'Color', colors(i+1), 'DisplayName', sprintf('lp=%.2f', lp_values(i)));
    end
    xlabel('Sample Index');
    ylabel('Amplitude');
    title('LP Filter Responses (Default Step Signal)');
    legend('show', 'Location', 'best');
    grid on;
    hold off;
end
