function main()
    % MAIN: Entry point for the LP Filter application.
    %
    % This script allows the user to choose between:
    %   1. Interactive Mode: Enter custom input signal and parameters.
    %   2. Test Mode: Generate a default step signal with preset parameters.
    
    disp('Choose mode:');
    disp('1: Interactive mode (enter your own xin, T, lp, h, y_init, y_delta, and y_beta values)');
    disp('2: Test mode (generate default step signal with preset parameters)');
    mode = input('Enter mode (1 or 2): ', 's');
    
    if strcmp(mode, '2')
        lp_filter_test();
    else
        interactive_mode();
    end
end
